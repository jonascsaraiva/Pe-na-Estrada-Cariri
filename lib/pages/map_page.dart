import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pe_na_estrada_cariri/controllers/geolocalizacao.dart';
import 'package:provider/provider.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  GoogleMapController? _mapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(0, 188, 212, 1),
        title: const Center(
          child: Text('Mapa', style: TextStyle(fontWeight: FontWeight.w500)),
        ),
      ),
      body: ChangeNotifierProvider<Geolocalizacao>(
        create: (context) => Geolocalizacao(),
        child: Consumer<Geolocalizacao>(
          builder: (context, local, child) {
            // Atualiza a câmera sem rebuildar o mapa
            if (_mapController != null) {
              _mapController!.animateCamera(
                CameraUpdate.newLatLng(LatLng(local.lat, local.long)),
              );
            }

            return GoogleMap(
              onMapCreated: (controller) => _mapController = controller,
              initialCameraPosition: CameraPosition(
                target: LatLng(local.lat, local.long),
                zoom: 18,
              ),
              mapType: MapType.normal,
              minMaxZoomPreference: MinMaxZoomPreference(15, 20),
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              zoomControlsEnabled: true,
            );
          },
        ),
      ),
    );
  }
}
