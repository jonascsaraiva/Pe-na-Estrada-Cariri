import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pe_na_estrada_cariri/controllers/darkmode.dart';
import 'package:pe_na_estrada_cariri/controllers/geolocalizacao.dart';
import 'package:pe_na_estrada_cariri/controllers/trajetoria.dart';
import 'package:pe_na_estrada_cariri/pages/detailpages/detail_list.dart';
import 'package:pe_na_estrada_cariri/theme/dark_theme.dart';
import 'package:pe_na_estrada_cariri/theme/light_theme.dart';
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
  bool _showCentralizarBtn = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final geo = context.read<Geolocalizacao>();
      geo.getPosicao();
      if (widget.destino != null) {
        geo.addDestino(widget.destino!, widget.destinoNome ?? "Destino");
        Future.delayed(const Duration(milliseconds: 500), () {
          _mapController?.animateCamera(
            CameraUpdate.newLatLngZoom(widget.destino!, 17),
          );
        });
      }
    });
  }

  Future<void> _loadMapStyle(BuildContext context) async {
    final themeSettings = Provider.of<ThemeSettings>(context, listen: false);
    if (themeSettings.isDark) {
      final style = await rootBundle.loadString(
        'assets/mapstyles/map_style_dark.json',
      );
      setState(() => _mapStyle = style);
    } else {
      final style = await rootBundle.loadString(
        'assets/mapstyles/map_style_light.json',
      );
      setState(() => _mapStyle = style);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Consumer3<Geolocalizacao, Trajetoria, ThemeSettings>(
      builder: (context, geo, traj, theme, child) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _loadMapStyle(context);
        });

        return Stack(
          children: [
            GoogleMap(
              onMapCreated: (controller) {
                _mapController = controller;
                geo.onMapCreated(controller);
              },
              style: _mapStyle,
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
              onCameraMove: (pos) {
                // mostra botão de centralizar se se afastou do centro do trajeto
                if (traj.navegando && geo.destino != null) {
                  final distance = GeoUtils.distance(
                    pos.target.latitude,
                    pos.target.longitude,
                    geo.lat,
                    geo.long,
                  );
                  setState(() => _showCentralizarBtn = distance > 20);
                }
              },
            ),

            // botão localização, zoom e centralizar
            Positioned(
              bottom: 20,
              right: 20,
              child: Column(
                children: [
                  if (_showCentralizarBtn)
                    FloatingActionButton(
                      heroTag: "btnCentralizar",
                      mini: true,
                      onPressed: () {
                        final atual = LatLng(geo.lat, geo.long);
                        geo.centralizarCameraNavegacao(atual);
                        setState(() => _showCentralizarBtn = false);
                      },
                      backgroundColor: isDark
                          ? AppThemeDark.curvedButton
                          : AppThemeLight.curvedButton,
                      foregroundColor: isDark
                          ? AppThemeDark.curvedIconSelected
                          : AppThemeLight.curvedIconSelected,
                      child: const Icon(Icons.center_focus_strong),
                    ),
                  const SizedBox(height: 5),
                  FloatingActionButton(
                    heroTag: "btnLocalizacao",
                    mini: true,
                    onPressed: () => geo.getPosicao(),
                    backgroundColor: isDark
                        ? AppThemeDark.curvedButton
                        : AppThemeLight.curvedButton,
                    foregroundColor: isDark
                        ? AppThemeDark.curvedIconSelected
                        : AppThemeLight.curvedIconSelected,
                    child: const Icon(Icons.my_location),
                  ),
                  const SizedBox(height: 5),
                  FloatingActionButton(
                    heroTag: "btnZoomIn",
                    mini: true,
                    onPressed: () =>
                        _mapController?.animateCamera(CameraUpdate.zoomIn()),
                    backgroundColor: isDark
                        ? AppThemeDark.curvedButton
                        : AppThemeLight.curvedButton,
                    foregroundColor: isDark
                        ? AppThemeDark.curvedIconSelected
                        : AppThemeLight.curvedIconSelected,
                    child: const Icon(Icons.add),
                  ),
                  const SizedBox(height: 5),
                  FloatingActionButton(
                    heroTag: "btnZoomOut",
                    mini: true,
                    onPressed: () =>
                        _mapController?.animateCamera(CameraUpdate.zoomOut()),
                    backgroundColor: isDark
                        ? AppThemeDark.curvedButton
                        : AppThemeLight.curvedButton,
                    foregroundColor: isDark
                        ? AppThemeDark.curvedIconSelected
                        : AppThemeLight.curvedIconSelected,
                    child: const Icon(Icons.remove),
                  ),
                ],
              ),
            ),

            // Botões marcador
            if (geo.marcadorSelecionado != null)
              Positioned(
                bottom: 20,
                left: 20,
                child: Row(
                  children: [
                    FloatingActionButton.extended(
                      heroTag: "btnRotas",
                      onPressed: () async {
                        final geo = context.read<Geolocalizacao>();
                        final trajetoria = context.read<Trajetoria>();

                        try {
                          final origem = await geo.getPosicao();
                          final destino = LatLng(
                            geo.marcadorSelecionado!.latitude,
                            geo.marcadorSelecionado!.longitude,
                          );

                          await trajetoria.criarRota(origem, destino);
                          geo.addDestino(
                            destino,
                            geo.marcadorSelecionado!.nome,
                          );
                          geo.destino = destino;
                          trajetoria.iniciarNavegacao();

                          // chama stream com heading
                          geo.iniciarStreamPosicao(trajetoria, (
                            atual,
                            heading,
                          ) {
                            geo.centralizarCameraNavegacao(
                              atual,
                              bearing: heading,
                            );

                            if (trajetoria.navegando && geo.destino != null) {
                              trajetoria.atualizarRota(atual, geo.destino!);
                            }
                          });

                          geo.marcadorSelecionado = null;
                          geo.atualizar();
                        } catch (e) {
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Erro ao gerar rota: $e')),
                          );
                        }
                      },
                      label: Text(traj.navegando ? "Parar" : "Como chegar"),
                      icon: Icon(
                        traj.navegando ? Icons.close : Icons.directions,
                      ),
                      backgroundColor: isDark
                          ? AppThemeDark.curvedButton
                          : AppThemeLight.curvedButton,
                      foregroundColor: isDark
                          ? AppThemeDark.curvedIconSelected
                          : AppThemeLight.curvedIconSelected,
                    ),
                    const SizedBox(width: 15),
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
                      backgroundColor: isDark
                          ? AppThemeDark.curvedButton
                          : AppThemeLight.curvedButton,
                      foregroundColor: isDark
                          ? AppThemeDark.curvedIconSelected
                          : AppThemeLight.curvedIconSelected,
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

// Classe utilitária para calcular distância (metros)
class GeoUtils {
  static double distance(double lat1, double lng1, double lat2, double lng2) {
    const R = 6371000; // raio da Terra em metros
    final dLat = _deg2rad(lat2 - lat1);
    final dLng = _deg2rad(lng2 - lng1);
    final a =
        math.sin(dLat / 2) * math.sin(dLat / 2) +
        math.cos(_deg2rad(lat1)) *
            math.cos(_deg2rad(lat2)) *
            math.sin(dLng / 2) *
            math.sin(dLng / 2);
    final c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
    return R * c;
  }

  static double _deg2rad(double d) => d * math.pi / 180;
}
