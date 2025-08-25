import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pe_na_estrada_cariri/repositories/loc_repository.dart';

class Geolocalizacao extends ChangeNotifier {
  double lat = 0.0;
  double long = 0.0;
  String erro = '';
  Set<Marker> markers = {};
  late GoogleMapController _mapsController;

  get mapsController => _mapsController;

  onMapCreated(GoogleMapController gmc) async {
    _mapsController = gmc;
    getPosicao();
    loadPostos();
  }

  //Isso aqui eu posso retornar depois com API ou firebase,etc
  loadPostos() async {
    final localizacoes = LocRepository().localizacoes;
    for (var local in localizacoes) {
      markers.add(
        Marker(
          // Ajeita o icone do marcador
          // icon: await BitmapDescriptor.fromAssetImage(
          //   ImageConfiguration(),
          //   'image/assets',
          // ),
          markerId: MarkerId(local.nome),
          position: LatLng(local.latitude, local.longitude),
          onTap: () {},
        ),
      );
    }
  }

  getPosicao() async {
    try {
      Position posicao = await _posicaoAtual();
      lat = posicao.latitude;
      long = posicao.longitude;
      _mapsController.animateCamera(CameraUpdate.newLatLng(LatLng(lat, long)));
    } catch (e) {
      erro = e.toString();
    }
    notifyListeners();
  }

  Future<Position> _posicaoAtual() async {
    LocationPermission permissao;
    bool ativado = await Geolocator.isLocationServiceEnabled();
    if (!ativado) {
      return Future.error('Por favor, habilite a localização no smartphone');
    }
    permissao = await Geolocator.checkPermission();
    if (permissao == LocationPermission.denied) {
      permissao = await Geolocator.requestPermission();
      if (permissao == LocationPermission.denied) {
        return Future.error('Você precisa autorizar o acesso à localização');
      }
    }

    if (permissao == LocationPermission.deniedForever) {
      return Future.error('Você precisa autorizar o acesso à localização');
    }

    return await Geolocator.getCurrentPosition();
  }

  void addDestino(LatLng destino, String nome) {
    markers.add(
      Marker(
        markerId: MarkerId(nome),
        position: destino,
        infoWindow: InfoWindow(title: nome),
      ),
    );
    notifyListeners();
  }
}
