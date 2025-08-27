import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pe_na_estrada_cariri/controllers/geolocalizacao.dart';
import 'package:pe_na_estrada_cariri/controllers/trajetoria.dart';
import 'package:pe_na_estrada_cariri/pages/detailpages/detail_list.dart';
import 'package:provider/provider.dart';

class MapPage extends StatefulWidget {
  final LatLng? destino;
  final String? destinoNome;

  const MapPage({super.key, this.destino, this.destinoNome});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  GoogleMapController? _mapController;
  String? _mapStyle;

  @override
  void initState() {
    super.initState();

    _loadMapStyle();

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

  Future<void> _loadMapStyle() async {
    final style = await rootBundle.loadString('assets/map_style.json');
    setState(() {
      _mapStyle = style;
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
              style: _mapStyle,
              markers: geo.markers,
              onTap: (LatLng pos) {
                geo.limparSelecao();
              },
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
              // left: MediaQuery.of(context).size.width / 2 - 1,
              child: Column(
                children: [
                  // Botão Localização
                  FloatingActionButton(
                    heroTag: "btnLocalizacao",
                    mini: true,
                    onPressed: () => geo.getPosicao(),
                    child: const Icon(Icons.my_location),
                  ),
                  Divider(height: 5),
                  // Botões de zoom in/out
                  FloatingActionButton(
                    heroTag: "btnZoomIn",
                    mini: true,
                    onPressed: () =>
                        _mapController?.animateCamera(CameraUpdate.zoomIn()),
                    child: const Icon(Icons.add),
                  ),
                  const SizedBox(height: 5),
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

            // Botões que aparecem ao clicar em qualquer marcador.
            if (geo.marcadorSelecionado != null)
              Positioned(
                bottom: 20,
                left: 20,
                child: Row(
                  children: [
                    // Botão de Rota
                    FloatingActionButton.extended(
                      heroTag: "btnRotas",
                      onPressed: () async {
                        final origem = await geo.getPosicao();
                        final destino = LatLng(
                          geo.marcadorSelecionado!.latitude,
                          geo.marcadorSelecionado!.longitude,
                        );

                        if (!context.mounted) return;

                        await context.read<Trajetoria>().criarRota(
                          origem,
                          destino,
                        );
                        geo.addDestino(destino, geo.marcadorSelecionado!.nome);

                        _mapController?.animateCamera(
                          CameraUpdate.newLatLngZoom(destino, 17),
                        );

                        geo.marcadorSelecionado = null;
                        geo.atualizar();
                      },
                      label: const Text("Como chegar"),
                      icon: const Icon(Icons.directions),
                    ),
                    const SizedBox(width: 15),
                    // Botão Saber sobre
                    FloatingActionButton.extended(
                      heroTag: "btnDetalhes",
                      onPressed: () {
                        if (!context.mounted) return;

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                DetailList(loc: geo.marcadorSelecionado!),
                          ),
                        );
                      },
                      label: const Text("Saber sobre"),
                      icon: const Icon(Icons.info),
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
