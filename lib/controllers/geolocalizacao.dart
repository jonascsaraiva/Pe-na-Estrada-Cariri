import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pe_na_estrada_cariri/models/localizacoes.dart';
import 'package:pe_na_estrada_cariri/repositories/loc_repository.dart';

class Geolocalizacao extends ChangeNotifier {
  double lat = 0.0;
  double long = 0.0;
  String erro = '';

  LatLng? destino;

  Set<Marker> markers = {};
  Localizacoes? marcadorSelecionado;

  late GoogleMapController _mapsController;

  get mapsController => _mapsController;

  // Inicializa o mapa e carrega os postos
  onMapCreated(GoogleMapController gmc) async {
    _mapsController = gmc;
    await getPosicao(); // pega posição inicial
    loadPostos(); // carrega marcadores
  }

  // Carrega marcadores fixos do repositório
  Future<void> loadPostos() async {
    markers.clear(); // garante que não duplica

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

  // Retorna LatLng da posição atual ou lança exceção
  Future<LatLng> getPosicao() async {
    try {
      debugPrint("Obtendo posição atual...");
      Position posicao = await _posicaoAtual();
      lat = posicao.latitude;
      long = posicao.longitude;

      LatLng atual = LatLng(lat, long);
      debugPrint("Posição atual: $atual");

      _mapsController.animateCamera(CameraUpdate.newLatLng(atual));
      notifyListeners();

      return atual;
    } catch (e) {
      erro = e.toString();
      debugPrint("Erro ao obter posição: $erro");
      throw Exception(erro); // lança exceção para botão capturar
    }
  }

  // Verifica permissões e retorna posição do GPS
  Future<Position> _posicaoAtual() async {
    LocationPermission permissao;
    bool ativado = await Geolocator.isLocationServiceEnabled();
    if (!ativado) {
      throw Exception('Por favor, habilite a localização no smartphone');
    }

    permissao = await Geolocator.checkPermission();
    if (permissao == LocationPermission.denied) {
      permissao = await Geolocator.requestPermission();
      if (permissao == LocationPermission.denied) {
        throw Exception('Você precisa autorizar o acesso à localização');
      }
    }

    if (permissao == LocationPermission.deniedForever) {
      throw Exception('Você precisa autorizar o acesso à localização');
    }

    return await Geolocator.getCurrentPosition();
  }

  void atualizar() {
    notifyListeners();
  }

  // Define destino sem adicionar marcador extra
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

  // Vai para o destino no mapa
  void irParaDestino(LatLng destino) {
    this.destino = destino;
    _mapsController.animateCamera(CameraUpdate.newLatLngZoom(destino, 17.5));
    notifyListeners();
  }

  // Vai para o destino no mapa
  void limparSelecao() {
    marcadorSelecionado = null;
    notifyListeners();
  }
}
