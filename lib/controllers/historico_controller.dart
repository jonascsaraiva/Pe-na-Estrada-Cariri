import 'package:hive/hive.dart';
import 'package:pe_na_estrada_cariri/models/localizacoes.dart';
import 'package:pe_na_estrada_cariri/models/visitados.dart';

class HistoricoController {
  static const String boxName = "historicoBox";

  Future<Box<Visitado>> _getBox() async {
    if (Hive.isBoxOpen(boxName)) {
      return Hive.box<Visitado>(boxName);
    }
    return await Hive.openBox<Visitado>(boxName);
  }

  Future<void> addVisita({
    required String partida,
    required Localizacoes destino,
  }) async {
    final box = await _getBox();

    final visita = Visitado(
      partida: partida,
      destino: destino,
      dataHora: DateTime.now(),
    );

    await box.add(visita);
  }

  Future<List<Visitado>> getHistorico() async {
    final box = await _getBox();
    return box.values.toList();
  }

  Future<void> limparHistorico() async {
    final box = await _getBox();
    await box.clear();
  }
}
