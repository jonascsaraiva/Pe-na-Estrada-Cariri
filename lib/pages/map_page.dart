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
        // Atualiza mapa se tema mudar
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
            ),
            // botão localização
            Positioned(
              bottom: 20,
              right: 20,
              child: Column(
                children: [
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

            // Botões de marcador
            if (geo.marcadorSelecionado != null)
              Positioned(
                bottom: 20,
                left: 20,
                child: Row(
                  children: [
                    // dentro do Row dos botões de marcador, substitua o atual "Como Chegar" por isso:
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

                          // inicia stream de posição para atualizar a rota dinamicamente
                          geo.iniciarStreamPosicao((atual) async {
                            geo.centralizarCameraNavegacao(
                              atual,
                            ); // centraliza camera
                            if (trajetoria.navegando && geo.destino != null) {
                              await trajetoria.atualizarRota(
                                atual,
                                geo.destino!,
                              );
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
