import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pe_na_estrada_cariri/models/localizacoes.dart';
import 'package:pe_na_estrada_cariri/repositories/loc_repository.dart';
import 'package:pe_na_estrada_cariri/controllers/trajetoria.dart';

class Geolocalizacao extends ChangeNotifier {
  double lat = 0.0;
  double long = 0.0;
  String erro = '';

  LatLng? destino;

  Set<Marker> markers = {};
  Localizacoes? marcadorSelecionado;

  late GoogleMapController _mapsController;
  get mapsController => _mapsController;

  // Estado do GPS
  LatLng? _ultimoPonto;
  double _ultimoBearing = 0.0;

  StreamSubscription<Position>? _posicaoStream;

  // ------------------- MAPA -------------------
  onMapCreated(GoogleMapController gmc) async {
    _mapsController = gmc;
    await getPosicao();
    loadPostos();
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

      // Centraliza no mapa
      centralizarCameraNavegacao(atual, bearing: _ultimoBearing);

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
    centralizarCameraNavegacao(destino);
  }

  void limparSelecao() {
    marcadorSelecionado = null;
    notifyListeners();
  }

  // ------------------- STREAM GPS + SNAP-TO-ROAD -------------------
  void iniciarStreamPosicao(
    Trajetoria traj,
    void Function(LatLng pos, double heading) onUpdate, {
    bool centralizar = true,
  }) {
    _posicaoStream?.cancel();

    _posicaoStream =
        Geolocator.getPositionStream(
          locationSettings: const LocationSettings(
            accuracy: LocationAccuracy.bestForNavigation,
            distanceFilter: 2,
          ),
        ).listen((pos) async {
          final atual = LatLng(pos.latitude, pos.longitude);
          lat = pos.latitude;
          long = pos.longitude;

          // Calcula direção
          double heading;
          if (pos.heading.isFinite && pos.heading != 0.0) {
            heading = _normalizeBearing(pos.heading);
          } else if (_ultimoPonto != null) {
            heading = _bearingBetween(_ultimoPonto!, atual);
          } else {
            heading = _ultimoBearing;
          }

          _ultimoBearing = heading;
          _ultimoPonto = atual;

          // Atualiza trajeto via API
          if (traj.navegando && destino != null) {
            await traj.atualizarRota(atual, destino!);
          }

          // Atualiza câmera se habilitado
          if (centralizar) {
            centralizarCameraNavegacao(atual, bearing: heading);
          }

          notifyListeners();
          onUpdate(atual, heading); // passa ambos
        });
  }

  void pararStreamPosicao() {
    _posicaoStream?.cancel();
    _posicaoStream = null;
  }

  void centralizarCameraNavegacao(
    LatLng atual, {
    double bearing = 0,
    double zoom = 19.5,
    double tilt = 60,
  }) {
    _mapsController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: atual, zoom: zoom, tilt: tilt, bearing: bearing),
      ),
    );
  }

  // ------------------- UTILS -------------------
  double _normalizeBearing(double b) => (b % 360 + 360) % 360;

  double _bearingBetween(LatLng from, LatLng to) {
    final lat1 = _deg2rad(from.latitude);
    final lat2 = _deg2rad(to.latitude);
    final dLon = _deg2rad(to.longitude - from.longitude);

    final y = math.sin(dLon) * math.cos(lat2);
    final x =
        math.cos(lat1) * math.sin(lat2) -
        math.sin(lat1) * math.cos(lat2) * math.cos(dLon);
    final brng = math.atan2(y, x);
    return _normalizeBearing(_rad2deg(brng));
  }

  double _deg2rad(double d) => d * math.pi / 180.0;
  double _rad2deg(double r) => r * 180.0 / math.pi;
}
