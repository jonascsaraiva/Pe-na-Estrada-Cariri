import 'package:hive/hive.dart';
import 'package:pe_na_estrada_cariri/models/localizacoes.dart';

part 'visitados.g.dart'; // <--- ESSENCIAL

@HiveType(typeId: 1)
class Visitado extends HiveObject {
  @HiveField(0)
  final String partida;

  @HiveField(1)
  final Localizacoes destino;

  @HiveField(2)
  final DateTime dataHora;

  Visitado({
    required this.partida,
    required this.destino,
    required this.dataHora,
  });
}
