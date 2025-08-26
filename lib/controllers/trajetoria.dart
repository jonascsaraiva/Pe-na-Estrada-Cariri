import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart'
    hide Route;
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Trajetoria extends ChangeNotifier {
  final Set<Polyline> _polylines = {};
  Set<Polyline> get polylines => _polylines;

  /// Cria a rota do ponto atual até o destino
  Future<void> criarRota(LatLng origem, LatLng destino) async {
    final polylinePoints = PolylinePoints(
      apiKey: "AIzaSyBIHVSEY_Fe7mr9eyb53Ux9bunA0y7EAvQ",
    );

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

      final polylineCoordinates = pontos
          .map((p) => LatLng(p.latitude, p.longitude))
          .toList();

      // Adiciona polyline no mapa
      final polyline = Polyline(
        polylineId: PolylineId("rota"),
        color: const Color(0xFF4285F4),
        width: 6,
        points: polylineCoordinates,
      );

      _polylines
        ..clear()
        ..add(polyline);

      notifyListeners();
    }
  }

  void limparRotas() {
    _polylines.clear();
    notifyListeners();
  }
}
