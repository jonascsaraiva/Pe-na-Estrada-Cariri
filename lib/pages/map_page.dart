import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pe_na_estrada_cariri/controllers/map_controller.dart';
import 'package:provider/provider.dart';
import 'package:pe_na_estrada_cariri/controllers/geolocalizacao.dart';
import 'package:pe_na_estrada_cariri/controllers/trajetoria.dart';
import 'package:pe_na_estrada_cariri/controllers/darkmode.dart';

class MapPage extends StatefulWidget {
  final LatLng? destino;
  final String? destinoNome;
  final bool modoComoChegar;

  const MapPage({
    super.key,
    this.destino,
    this.destinoNome,
    this.modoComoChegar = false,
  });

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late MapController _controller;

  @override
  void initState() {
    super.initState();
    final theme = context.read<ThemeSettings>();
    _controller = MapController(
      context,
      widget.destino,
      widget.destinoNome,
      theme,
    );
    _controller.init();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer3<Geolocalizacao, Trajetoria, ThemeSettings>(
      builder: (_, geo, traj, theme, __) {
        _controller.applyThemeIfReady(theme.isDark);

        return Scaffold(
          body: Stack(
            children: [
              GoogleMap(
                onMapCreated: _controller.onMapCreated,
                mapType: MapType.normal,
                style: _controller.mapStyle,
                markers: geo.markers,
                polylines: traj.polylines,
                initialCameraPosition: CameraPosition(
                  target: LatLng(geo.lat, geo.long),
                  zoom: 17,
                ),
                myLocationEnabled: true,
                myLocationButtonEnabled: false,
                zoomControlsEnabled: false,
                onTap: (_) => geo.limparSelecao(),
                onCameraMove: _controller.onCameraMove,
              ),

              // Botões laterais
              Positioned(
                bottom: 20,
                right: 20,
                child: ValueListenableBuilder(
                  valueListenable: _controller.showCentralizarBtn,
                  builder: (_, show, __) => Column(
                    children: [
                      if (show) _controller.fabCentralizar(),
                      const SizedBox(height: 5),
                      _controller.fabMinhaLocalizacao(),
                      const SizedBox(height: 5),
                      _controller.fabZoomIn(),
                      const SizedBox(height: 5),
                      _controller.fabZoomOut(),
                    ],
                  ),
                ),
              ),

              // Marcador selecionado
              if (geo.marcadorSelecionado != null)
                Positioned(
                  bottom: 20,
                  left: 20,
                  child: Row(
                    children: [
                      _controller.fabComoChegar(),
                      const SizedBox(width: 15),
                      _controller.fabSaberSobre(),
                    ],
                  ),
                ),

              // Botão sair "Como Chegar"
              if (widget.modoComoChegar)
                Positioned(
                  top: 20,
                  right: 20,
                  child: _controller.fabSairComoChegar(),
                ),
            ],
          ),
        );
      },
    );
  }
}
