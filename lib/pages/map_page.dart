import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:pe_na_estrada_cariri/controllers/darkmode.dart';
import 'package:pe_na_estrada_cariri/controllers/geolocalizacao.dart';
import 'package:pe_na_estrada_cariri/controllers/trajetoria.dart';
import 'package:pe_na_estrada_cariri/pages/detailpages/detail_list.dart';
import 'package:pe_na_estrada_cariri/theme/dark_theme.dart';
import 'package:pe_na_estrada_cariri/theme/light_theme.dart';

class MapPage extends StatefulWidget {
  final LatLng? destino;
  final String? destinoNome;
  final bool modoComoChegar; // novo parâmetro

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
  GoogleMapController? _mapController;
  String? _mapStyle;
  bool _showCentralizarBtn = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _initMap());
  }

  void _initMap() {
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
  }

  Future<void> _loadMapStyle(BuildContext ctx) async {
    final theme = Provider.of<ThemeSettings>(ctx, listen: false);
    final path = theme.isDark
        ? 'assets/mapstyles/map_style_dark.json'
        : 'assets/mapstyles/map_style_light.json';
    _mapStyle = await rootBundle.loadString(path);
    setState(() {});
  }

  @override
  void dispose() {
    final geo = context.read<Geolocalizacao>();
    final traj = context.read<Trajetoria>();
    traj.pararNavegacao();
    geo.pararStreamPosicao();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Consumer3<Geolocalizacao, Trajetoria, ThemeSettings>(
      builder: (ctx, geo, traj, theme, _) {
        WidgetsBinding.instance.addPostFrameCallback((_) => _loadMapStyle(ctx));

        void centralizar() {
          geo.centralizarCameraNavegacao(LatLng(geo.lat, geo.long));
          setState(() => _showCentralizarBtn = false);
        }

        FloatingActionButton fab(
          IconData icon,
          VoidCallback onPress,
          String tag,
        ) => FloatingActionButton(
          heroTag: tag,
          mini: true,
          onPressed: onPress,
          backgroundColor: isDark
              ? AppThemeDark.curvedButton
              : AppThemeLight.curvedButton,
          foregroundColor: isDark
              ? AppThemeDark.curvedIconSelected
              : AppThemeLight.curvedIconSelected,
          child: Icon(icon),
        );

        FloatingActionButton fabExt(
          String label,
          IconData icon,
          VoidCallback onPress,
          String tag,
        ) => FloatingActionButton.extended(
          heroTag: tag,
          onPressed: onPress,
          label: Text(label),
          icon: Icon(icon),
          backgroundColor: isDark
              ? AppThemeDark.curvedButton
              : AppThemeLight.curvedButton,
          foregroundColor: isDark
              ? AppThemeDark.curvedIconSelected
              : AppThemeLight.curvedIconSelected,
        );

        return Scaffold(
          body: Stack(
            children: [
              GoogleMap(
                onMapCreated: (c) {
                  _mapController = c;
                  geo.onMapCreated(c);
                },
                mapType: MapType.normal,
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

              // Botões laterais
              Positioned(
                bottom: 20,
                right: 20,
                child: Column(
                  children: [
                    if (_showCentralizarBtn)
                      fab(
                        Icons.center_focus_strong,
                        centralizar,
                        "btnCentralizar",
                      ),
                    const SizedBox(height: 5),
                    fab(
                      Icons.my_location,
                      () => geo.getPosicao(),
                      "btnLocalizacao",
                    ),
                    const SizedBox(height: 5),
                    fab(
                      Icons.add,
                      () =>
                          _mapController?.animateCamera(CameraUpdate.zoomIn()),
                      "btnZoomIn",
                    ),
                    const SizedBox(height: 5),
                    fab(
                      Icons.remove,
                      () =>
                          _mapController?.animateCamera(CameraUpdate.zoomOut()),
                      "btnZoomOut",
                    ),
                  ],
                ),
              ),

              // Botões marcador selecionado
              if (geo.marcadorSelecionado != null)
                Positioned(
                  bottom: 20,
                  left: 20,
                  child: Row(
                    children: [
                      fabExt(
                        traj.navegando &&
                                traj.destinoAtual ==
                                    LatLng(
                                      geo.marcadorSelecionado!.latitude,
                                      geo.marcadorSelecionado!.longitude,
                                    )
                            ? "Parar rota"
                            : "Como chegar",
                        traj.navegando &&
                                traj.destinoAtual ==
                                    LatLng(
                                      geo.marcadorSelecionado!.latitude,
                                      geo.marcadorSelecionado!.longitude,
                                    )
                            ? Icons.close
                            : Icons.directions,
                        () async {
                          final origem = await geo.getPosicao();
                          final destino = LatLng(
                            geo.marcadorSelecionado!.latitude,
                            geo.marcadorSelecionado!.longitude,
                          );

                          if (traj.navegando && traj.destinoAtual == destino) {
                            traj.pararNavegacao();
                            geo.destino = null;
                            return;
                          }

                          await traj.criarRota(origem, destino);
                          geo.addDestino(
                            destino,
                            geo.marcadorSelecionado!.nome,
                          );
                          geo.destino = destino;
                          traj.iniciarNavegacao();

                          geo.iniciarStreamPosicao(traj, (posAtual, heading) {
                            geo.centralizarCameraNavegacao(
                              posAtual,
                              bearing: heading,
                            );
                          });

                          geo.marcadorSelecionado = null;
                          geo.atualizar();
                        },
                        "btnRotas",
                      ),
                      const SizedBox(width: 15),
                      fabExt("Saber sobre", Icons.info, () {
                        if (!ctx.mounted) return;
                        Navigator.push(
                          ctx,
                          MaterialPageRoute(
                            builder: (_) =>
                                DetailList(loc: geo.marcadorSelecionado!),
                          ),
                        );
                      }, "btnDetalhes"),
                    ],
                  ),
                ),

              // Novo: botão de sair do modo Como Chegar
              if (widget.modoComoChegar)
                Positioned(
                  top: 20,
                  right: 20,
                  child: fabExt("Voltar", Icons.close, () {
                    Navigator.pop(context); // volta para a ListPage
                  }, "btnSairComoChegar"),
                ),
            ],
          ),
        );
      },
    );
  }
}

class GeoUtils {
  static double distance(double lat1, double lng1, double lat2, double lng2) {
    const R = 6371000;
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
