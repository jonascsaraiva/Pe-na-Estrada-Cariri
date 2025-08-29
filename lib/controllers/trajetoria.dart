import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart'
    hide Route;
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Trajetoria extends ChangeNotifier {
  final Set<Polyline> _polylines = {};
  Set<Polyline> get polylines => _polylines;

  bool _navegando = false;
  bool get navegando => _navegando;

  LatLng? _destinoAtual;
  LatLng? get destinoAtual => _destinoAtual;

  /// Pontos atuais da rota
  List<LatLng> _pontosRota = [];

  /// Cria a rota do ponto atual até o destino
  Future<void> criarRota(LatLng origem, LatLng destino) async {
    final polylinePoints = PolylinePoints(
      apiKey: "AIzaSyBIHVSEY_Fe7mr9eyb53Ux9bunA0y7EAvQ",
    );

    try {
      final request = RoutesApiRequest(
        origin: PointLatLng(origem.latitude, origem.longitude),
        destination: PointLatLng(destino.latitude, destino.longitude),
        travelMode: TravelMode.driving,
        routingPreference: RoutingPreference.trafficAware,
      );

      final response = await polylinePoints.getRouteBetweenCoordinatesV2(
        request: request,
      );

      if (response.routes.isNotEmpty) {
        final route = response.routes.first;
        final pontos = route.polylinePoints ?? [];
        _pontosRota = pontos
            .map((p) => LatLng(p.latitude, p.longitude))
            .toList();

        _polylines
          ..clear()
          ..add(
            Polyline(
              polylineId: const PolylineId("rota"),
              color: const Color(0xFF00BCF4),
              width: 6,
              points: List.from(_pontosRota),
            ),
          );

        _destinoAtual = destino;
        notifyListeners();
      }
    } catch (e) {
      debugPrint("Erro ao criar rota: $e");
    }
  }

  /// Atualiza a rota conforme a posição atual do usuário
  Future<void> atualizarPosicao(LatLng novaPos) async {
    if (!_navegando || _destinoAtual == null) return;

    // Se estiver muito distante do caminho atual, recalcula a rota
    final distanceToDest = _distance(novaPos, _destinoAtual!);
    if (_pontosRota.isEmpty || distanceToDest > 50) {
      await criarRota(novaPos, _destinoAtual!);
    } else {
      // Mantém a rota, só atualiza o ponto inicial (posição atual)
      final novaRota = [novaPos, ..._pontosRota.where((p) => p != novaPos)];
      _pontosRota = novaRota;

      _polylines
        ..clear()
        ..add(
          Polyline(
            polylineId: const PolylineId("rota"),
            color: const Color(0xFF00BCF4),
            width: 6,
            points: List.from(_pontosRota),
          ),
        );

      notifyListeners();
    }
  }

  double _distance(LatLng a, LatLng b) {
    const R = 6371000; // raio da terra
    final dLat = (b.latitude - a.latitude) * (3.141592653589793 / 180);
    final dLng = (b.longitude - a.longitude) * (3.141592653589793 / 180);
    final lat1 = a.latitude * (3.141592653589793 / 180);
    final lat2 = b.latitude * (3.141592653589793 / 180);

    final hav =
        (sin(dLat / 2) * sin(dLat / 2)) +
        cos(lat1) * cos(lat2) * (sin(dLng / 2) * sin(dLng / 2));
    final c = 2 * atan2(sqrt(hav), sqrt(1 - hav));
    return R * c;
  }

  void limparRotas() {
    _polylines.clear();
    _pontosRota.clear();
    _destinoAtual = null;
    notifyListeners();
  }

  void iniciarNavegacao() {
    _navegando = true;
    notifyListeners();
  }

  void pararNavegacao() {
    _navegando = false;
    limparRotas();
  }
}
