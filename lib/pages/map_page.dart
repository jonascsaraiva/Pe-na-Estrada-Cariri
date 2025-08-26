import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pe_na_estrada_cariri/controllers/geolocalizacao.dart';
import 'package:pe_na_estrada_cariri/controllers/trajetoria.dart';
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

      geo.getPosicao(); // sempre atualiza a posição atual

      if (widget.destino != null) {
        geo.addDestino(widget.destino!, widget.destinoNome ?? "Destino");

        // centraliza no destino
        Future.delayed(const Duration(milliseconds: 500), () {
          _mapController?.animateCamera(
            CameraUpdate.newLatLngZoom(widget.destino!, 17),
          );
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<Geolocalizacao, Trajetoria>(
      builder: (context, geo, traj, child) {
        return Stack(
          children: [
            GoogleMap(
              onMapCreated: (controller) {
                _mapController = controller;
                geo.onMapCreated(controller);
              },
              markers: geo.markers,
              polylines: traj.polylines,
              initialCameraPosition: CameraPosition(
                target: LatLng(geo.lat, geo.long),
                zoom: 17,
              ),
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
              mapType: MapType.normal,
            ),

            // botão localização
            Positioned(
              bottom: 20,
              right: 20,
              child: FloatingActionButton(
                heroTag: "btnLocalizacao",
                mini: true,
                onPressed: () => geo.getPosicao(),
                child: const Icon(Icons.my_location),
              ),
            ),

            // botões zoom
            Positioned(
              bottom: 20,
              left: 20,
              child: Column(
                children: [
                  FloatingActionButton(
                    heroTag: "btnZoomIn",
                    mini: true,
                    onPressed: () =>
                        _mapController?.animateCamera(CameraUpdate.zoomIn()),
                    child: const Icon(Icons.add),
                  ),
                  const SizedBox(height: 8),
                  FloatingActionButton(
                    heroTag: "btnZoomOut",
                    mini: true,
                    onPressed: () =>
                        _mapController?.animateCamera(CameraUpdate.zoomOut()),
                    child: const Icon(Icons.remove),
                  ),
                ],
              ),
            ),

            // Botão de rota que aparece ao clicar no marcador
            if (geo.marcadorSelecionado != null)
              Positioned(
                bottom: 20,
                left: MediaQuery.of(context).size.width / 2 - 60,
                child: FloatingActionButton.extended(
                  heroTag: "btnRotas",
                  onPressed: () async {
                    final origem = await geo.getPosicao();
                    final destino = geo.marcadorSelecionado!;

                    if (!context.mounted) return;

                    await context.read<Trajetoria>().criarRota(origem, destino);
                    geo.addDestino(destino, "Destino");

                    _mapController?.animateCamera(
                      CameraUpdate.newLatLngZoom(destino, 17),
                    );

                    // esconde o botão depois
                    geo.marcadorSelecionado = null;
                    geo.atualizar();
                  },
                  label: const Text("Como chegar"),
                  icon: const Icon(Icons.directions),
                ),
              ),
          ],
        );
      },
    );
  }
}
