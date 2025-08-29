import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pe_na_estrada_cariri/controllers/darkmode.dart';
import 'package:pe_na_estrada_cariri/controllers/geolocalizacao.dart';
import 'package:pe_na_estrada_cariri/controllers/trajetoria.dart';
import 'package:pe_na_estrada_cariri/theme/dark_theme.dart';
import 'package:pe_na_estrada_cariri/theme/light_theme.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:pe_na_estrada_cariri/pages/detailpages/detail_list.dart';

class MapController {
  final BuildContext context;
  final LatLng? initialDestino;
  final String? initialDestinoNome;

  late final Geolocalizacao geo;
  late final Trajetoria traj;

  GoogleMapController? _mapController;
  String? mapStyle;

  final ValueNotifier<bool> showCentralizarBtn = ValueNotifier(false);

  MapController(this.context, this.initialDestino, this.initialDestinoNome) {
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
    final theme = context.read<ThemeSettings>();
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

  // --- FABs normais ---
  Widget fabCentralizar() =>
      _fab(Icons.center_focus_strong, centralizar, "btnCentralizar");
  Widget fabMinhaLocalizacao() =>
      _fab(Icons.my_location, () => geo.getPosicao(), "btnLocalizacao");
  Widget fabZoomIn() => _fab(
    Icons.add,
    () => _mapController?.animateCamera(CameraUpdate.zoomIn()),
    "btnZoomIn",
  );
  Widget fabZoomOut() => _fab(
    Icons.remove,
    () => _mapController?.animateCamera(CameraUpdate.zoomOut()),
    "btnZoomOut",
  );

  Widget _fab(IconData icon, VoidCallback onPress, String tag) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
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

  // --- FABs estendidos ---
  Widget fabComoChegar() {
    final destino = LatLng(
      geo.marcadorSelecionado!.latitude,
      geo.marcadorSelecionado!.longitude,
    );
    final isAtivo = traj.navegando && traj.destinoAtual == destino;

    return _fabExt(
      isAtivo ? "Parar rota" : "Como chegar",
      isAtivo ? Icons.close : Icons.directions,
      () async {
        final origem = await geo.getPosicao();
        if (isAtivo) {
          traj.pararNavegacao();
          geo.destino = null;
        } else {
          await traj.criarRota(origem, destino);
          geo.addDestino(destino, geo.marcadorSelecionado!.nome);
          traj.iniciarNavegacao();
          geo.iniciarStreamPosicao();
        }
        geo.marcadorSelecionado = null;
        geo.atualizar();
      },
      "btnRotas",
    );
  }

  Widget fabSaberSobre() => _fabExt("Saber sobre", Icons.info, () {
    if (!context.mounted) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DetailList(loc: geo.marcadorSelecionado!),
      ),
    );
  }, "btnDetalhes");

  Widget fabSairComoChegar() => _fabExt(
    "Voltar",
    Icons.close,
    () => Navigator.pop(context),
    "btnSairComoChegar",
  );

  Widget _fabExt(
    String label,
    IconData icon,
    VoidCallback onPress,
    String tag,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return FloatingActionButton.extended(
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
