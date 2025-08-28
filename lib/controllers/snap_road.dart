import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RoadsAPI {
  final String apiKey;

  RoadsAPI(this.apiKey);

  /// Ajusta coordenadas para a rua mais próxima e retorna LatLng + heading
  Future<Map<String, dynamic>?> snapToRoad(LatLng location) async {
    final url =
        'https://roads.googleapis.com/v1/snapToRoads?path=${location.latitude},${location.longitude}&interpolate=false&key=$apiKey';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['snappedPoints'] != null && data['snappedPoints'].isNotEmpty) {
        final snapped = data['snappedPoints'][0];
        final lat = snapped['location']['latitude'];
        final lng = snapped['location']['longitude'];
        final heading = snapped['originalIndex'] != null
            ? (snapped['heading'] ?? 0.0)
            : 0.0;
        return {'location': LatLng(lat, lng), 'heading': heading.toDouble()};
      }
    } else {
      if (kDebugMode) {
        print('Erro Snap-to-Road: ${response.body}');
      }
    }
    return null;
  }
}
