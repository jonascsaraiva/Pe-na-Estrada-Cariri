import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pe_na_estrada_cariri/models/localizacoes.dart';
import 'package:pe_na_estrada_cariri/repositories/loc_repository.dart';

class Geolocalizacao extends ChangeNotifier {
  StreamSubscription<Position>? _posicaoStream;
  double lat = 0.0;
  double long = 0.0;
  String erro = '';
  LatLng? destino;

  Set<Marker> markers = {};
  Localizacoes? marcadorSelecionado;

  late GoogleMapController _mapsController;
  get mapsController => _mapsController;

  onMapCreated(GoogleMapController gmc) async {
    _mapsController = gmc;
    await getPosicao();
    loadPostos();
    iniciarStreamPosicao();
  }

  Future<void> loadPostos() async {
    markers.clear();
    final localizacoes = LocRepository().localizacoes;

    for (var local in localizacoes) {
      markers.add(
        Marker(
          markerId: MarkerId(local.nome),
          position: LatLng(local.latitude, local.longitude),
          onTap: () {
            marcadorSelecionado = local;
            notifyListeners();
          },
        ),
      );
    }

    notifyListeners();
  }

  Future<LatLng> getPosicao() async {
    try {
      final posicao = await _posicaoAtual();
      lat = posicao.latitude;
      long = posicao.longitude;

      final atual = LatLng(lat, long);

      centralizarCamera(atual);

      notifyListeners();
      return atual;
    } catch (e) {
      erro = e.toString();
      throw Exception(erro);
    }
  }

  Future<Position> _posicaoAtual() async {
    LocationPermission permissao;
    final ativado = await Geolocator.isLocationServiceEnabled();
    if (!ativado) throw Exception('Habilite a localização no smartphone');

    permissao = await Geolocator.checkPermission();
    if (permissao == LocationPermission.denied) {
      permissao = await Geolocator.requestPermission();
      if (permissao == LocationPermission.denied) {
        throw Exception('Permissão negada para acesso à localização');
      }
    }
    if (permissao == LocationPermission.deniedForever) {
      throw Exception('Permissão negada permanentemente');
    }

    return Geolocator.getCurrentPosition();
  }

  void atualizar() => notifyListeners();

  void addDestino(LatLng destino, String nome) {
    marcadorSelecionado = Localizacoes(
      nome: nome,
      latitude: destino.latitude,
      longitude: destino.longitude,
      endereco: '',
      foto: '',
      descricao: '',
    );
    notifyListeners();
  }

  void irParaDestino(LatLng destino) {
    this.destino = destino;
    centralizarCamera(destino);
  }

  void limparSelecao() {
    marcadorSelecionado = null;
    notifyListeners();
  }

  // ------------------- STREAM SIMPLES -------------------
  void iniciarStreamPosicao({Function(LatLng)? onUpdate}) {
    _posicaoStream?.cancel();

    _posicaoStream =
        Geolocator.getPositionStream(
          locationSettings: const LocationSettings(
            accuracy: LocationAccuracy.bestForNavigation,
            distanceFilter: 2,
          ),
        ).listen((pos) {
          lat = pos.latitude;
          long = pos.longitude;

          final atual = LatLng(lat, long);
          if (onUpdate != null) {
            onUpdate(atual);
          }
          centralizarCamera(atual);

          notifyListeners();
        });
  }

  void pararStreamPosicao() {
    _posicaoStream?.cancel();
    _posicaoStream = null;
  }

  void centralizarCamera(LatLng atual, {double zoom = 18}) {
    _mapsController.animateCamera(
      CameraUpdate.newCameraPosition(CameraPosition(target: atual, zoom: zoom)),
    );
  }
}
