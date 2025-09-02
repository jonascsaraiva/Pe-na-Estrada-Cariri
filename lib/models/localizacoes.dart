import 'package:hive/hive.dart';

part 'localizacoes.g.dart'; // <--- ESSENCIAL

@HiveType(typeId: 0)
class Localizacoes extends HiveObject {
  @HiveField(0)
  final String nome;

  @HiveField(1)
  final double latitude;

  @HiveField(2)
  final double longitude;

  @HiveField(3)
  final String endereco;

  @HiveField(4)
  final String foto;

  @HiveField(5)
  final String descricao;

  Localizacoes({
    required this.nome,
    required this.latitude,
    required this.longitude,
    required this.endereco,
    required this.foto,
    required this.descricao,
  });
}
