import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pe_na_estrada_cariri/controllers/geolocalizacao.dart';
import 'package:pe_na_estrada_cariri/controllers/historico_controller.dart';
import 'package:pe_na_estrada_cariri/controllers/trajetoria.dart';
import 'package:pe_na_estrada_cariri/pages/detailpages/card_destino.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:pe_na_estrada_cariri/pages/detailpages/detail_list.dart';
import 'package:pe_na_estrada_cariri/theme/dark_theme.dart';
import 'package:pe_na_estrada_cariri/theme/light_theme.dart';
import 'package:pe_na_estrada_cariri/controllers/darkmode.dart';
import 'package:pe_na_estrada_cariri/models/localizacoes.dart';

class MapController {
  final BuildContext context;
  final LatLng? initialDestino;
  final String? initialDestinoNome;
  final ThemeSettings theme;

  late final Geolocalizacao geo;
  late final Trajetoria traj;

  GoogleMapController? _mapController;
  String? mapStyle;

  final ValueNotifier<bool> showCentralizarBtn = ValueNotifier(false);

  // Guarda o destino atual em navegação
  Localizacoes? _destinoEmCurso;

  MapController(
    this.context,
    this.initialDestino,
    this.initialDestinoNome,
    this.theme,
  ) {
    geo = context.read<Geolocalizacao>();
    traj = context.read<Trajetoria>();
  }

  Future<void> init() async {
    geo.getPosicao();
    await _loadMapStyle();

    if (initialDestino != null) {
      geo.addDestino(initialDestino!, initialDestinoNome ?? "Destino");
      Future.delayed(const Duration(milliseconds: 500), () {
        _mapController?.animateCamera(
          CameraUpdate.newLatLngZoom(initialDestino!, 17),
        );
      });
    }
  }

  Future<void> _loadMapStyle() async {
    final path = theme.isDark
        ? 'assets/mapstyles/map_style_dark.json'
        : 'assets/mapstyles/map_style_light.json';
    mapStyle = await rootBundle.loadString(path);
  }

  void dispose() {
    showCentralizarBtn.dispose();
    geo.pararStreamPosicao();
  }

  void onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    geo.onMapCreated(controller);
    applyThemeIfReady(theme.isDark);
  }

  void onCameraMove(CameraPosition pos) {
    if (traj.navegando && geo.destino != null) {
      final distance = GeoUtils.distance(
        pos.target.latitude,
        pos.target.longitude,
        geo.lat,
        geo.long,
      );
      if (distance > 20 && !showCentralizarBtn.value) {
        showCentralizarBtn.value = true;
      }
      if (distance <= 20 && showCentralizarBtn.value) {
        showCentralizarBtn.value = false;
      }
    }
  }

  void centralizar() {
    geo.centralizarCamera(LatLng(geo.lat, geo.long));
    showCentralizarBtn.value = false;
  }

  FloatingActionButton fabCentralizar() =>
      _fab(Icons.center_focus_strong, centralizar, "btnCentralizar");

  FloatingActionButton fabMinhaLocalizacao() =>
      _fab(Icons.my_location, () => geo.getPosicao(), "btnLocalizacao");

  FloatingActionButton fabZoomIn() => _fab(
    Icons.add,
    () => _mapController?.animateCamera(CameraUpdate.zoomIn()),
    "btnZoomIn",
  );

  FloatingActionButton fabZoomOut() => _fab(
    Icons.remove,
    () => _mapController?.animateCamera(CameraUpdate.zoomOut()),
    "btnZoomOut",
  );

  FloatingActionButton _fab(IconData icon, VoidCallback onPress, String tag) {
    final isDark = theme.isDark;
    return FloatingActionButton(
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
  }

  FloatingActionButton fabComoChegar() {
    if (geo.marcadorSelecionado == null) {
      return _fab(Icons.directions, () {}, "btnRotas");
    }

    final destino = LatLng(
      geo.marcadorSelecionado!.latitude,
      geo.marcadorSelecionado!.longitude,
    );
    final isAtivo = traj.navegando && traj.destinoAtual == destino;

    return FloatingActionButton.extended(
      heroTag: "btnRotas",
      onPressed: () async {
        final origem = await geo.getPosicao();

        if (isAtivo) {
          traj.pararNavegacao();
          geo.destino = null;
          _destinoEmCurso = null;
        } else {
          // Guardar o destino antes de limpar
          _destinoEmCurso = geo.marcadorSelecionado;

          await traj.criarRota(origem, destino);
          geo.addDestino(destino, geo.marcadorSelecionado!.nome);
          traj.iniciarNavegacao();

          geo.iniciarStreamPosicao(
            onUpdate: (LatLng novaPos) async {
              await traj.atualizarPosicao(novaPos);
              _mapController?.animateCamera(CameraUpdate.newLatLng(novaPos));

              if (traj.destinoAtual != null) {
                final distance = GeoUtils.distance(
                  novaPos.latitude,
                  novaPos.longitude,
                  traj.destinoAtual!.latitude,
                  traj.destinoAtual!.longitude,
                );

                if (distance <= 30) {
                  traj.pararNavegacao();
                  geo.destino = null;

                  if (_destinoEmCurso != null) {
                    final historico = HistoricoController();
                    final partidaStr =
                        "${novaPos.latitude},${novaPos.longitude}";
                    await historico.addVisita(
                      partida: partidaStr,
                      destino: _destinoEmCurso!,
                    );

                    if (context.mounted) {
                      mostrarOverlayChegada(
                        context,
                        _destinoEmCurso!.nome,
                        theme.isDark,
                      );
                    }
                  }

                  _destinoEmCurso = null;
                  geo.pararStreamPosicao();
                }
              }
            },
          );

          geo.marcadorSelecionado = null;
          geo.atualizar();
        }
      },
      label: Text(isAtivo ? "Parar rota" : "Como chegar"),
      icon: Icon(isAtivo ? Icons.close : Icons.directions),
      backgroundColor: theme.isDark
          ? AppThemeDark.curvedButton
          : AppThemeLight.curvedButton,
      foregroundColor: theme.isDark
          ? AppThemeDark.curvedIconSelected
          : AppThemeLight.curvedIconSelected,
    );
  }

  FloatingActionButton fabSaberSobre() {
    if (geo.marcadorSelecionado == null) {
      return _fab(Icons.info, () {}, "btnDetalhes");
    }

    return FloatingActionButton.extended(
      heroTag: "btnDetalhes",
      onPressed: () {
        if (!context.mounted) return;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DetailList(loc: geo.marcadorSelecionado!),
          ),
        );
      },
      label: const Text("Saber sobre"),
      icon: const Icon(Icons.info),
      backgroundColor: theme.isDark
          ? AppThemeDark.curvedButton
          : AppThemeLight.curvedButton,
      foregroundColor: theme.isDark
          ? AppThemeDark.curvedIconSelected
          : AppThemeLight.curvedIconSelected,
    );
  }

  FloatingActionButton fabSairComoChegar() {
    return FloatingActionButton.extended(
      heroTag: "btnSairComoChegar",
      onPressed: () => Navigator.pop(context),
      label: const Text("Voltar"),
      icon: const Icon(Icons.close),
      backgroundColor: theme.isDark
          ? AppThemeDark.curvedButton
          : AppThemeLight.curvedButton,
      foregroundColor: theme.isDark
          ? AppThemeDark.curvedIconSelected
          : AppThemeLight.curvedIconSelected,
    );
  }

  void applyThemeIfReady(bool isDark) {
    if (_mapController != null && mapStyle != null) {
      final path = isDark
          ? 'assets/mapstyles/map_style_dark.json'
          : 'assets/mapstyles/map_style_light.json';
      rootBundle.loadString(path).then((style) {
        // ignore: deprecated_member_use
        _mapController?.setMapStyle(style);
      });
    }
  }
}

/// Função helper para overlay
void mostrarOverlayChegada(BuildContext context, String titulo, bool isDark) {
  final overlay = Overlay.of(context);
  late OverlayEntry entry;

  entry = OverlayEntry(
    builder: (_) => OverlayChegada(
      titulo: titulo,
      isDark: isDark,
      onClose: () => entry.remove(),
    ),
  );

  overlay.insert(entry);
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
