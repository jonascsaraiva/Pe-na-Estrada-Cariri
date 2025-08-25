import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pe_na_estrada_cariri/controllers/geolocalizacao.dart';
import 'package:provider/provider.dart';

class MapPage extends StatefulWidget {
  final LatLng? destino; // destino opcional
  final String? destinoNome; // nome do destino opcional

  const MapPage({super.key, this.destino, this.destinoNome});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  GoogleMapController? _mapController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final geo = context.read<Geolocalizacao>();

      // Atualiza posição do usuário
      geo.getPosicao();

      // Se houver destino, adiciona marker e centraliza
      if (widget.destino != null) {
        geo.addDestino(widget.destino!, widget.destinoNome ?? "Destino");
        _mapController?.animateCamera(CameraUpdate.newLatLng(widget.destino!));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Geolocalizacao>(
      builder: (context, local, child) {
        return Stack(
          children: [
            GoogleMap(
              onMapCreated: (controller) {
                _mapController = controller;
                context.read<Geolocalizacao>().onMapCreated(controller);
              },
              markers: local.markers,
              initialCameraPosition: CameraPosition(
                target: LatLng(local.lat, local.long),
                zoom: 18,
              ),
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
              mapType: MapType.normal,
              minMaxZoomPreference: MinMaxZoomPreference(15, 40),
            ),

            // Botão centralizar na localização (inferior direito)
            Positioned(
              bottom: 20,
              right: 20,
              child: FloatingActionButton(
                heroTag: "btn1",
                mini: true,
                onPressed: () => context.read<Geolocalizacao>().getPosicao(),
                child: const Icon(Icons.my_location),
              ),
            ),

            // Botões de zoom (inferior esquerdo)
            Positioned(
              bottom: 20,
              left: 20,
              child: Column(
                children: [
                  FloatingActionButton(
                    heroTag: "btn2",
                    mini: true,
                    onPressed: () =>
                        _mapController?.animateCamera(CameraUpdate.zoomIn()),
                    child: const Icon(Icons.add),
                  ),
                  const SizedBox(height: 8),
                  FloatingActionButton(
                    heroTag: "btn3",
                    mini: true,
                    onPressed: () =>
                        _mapController?.animateCamera(CameraUpdate.zoomOut()),
                    child: const Icon(Icons.remove),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
