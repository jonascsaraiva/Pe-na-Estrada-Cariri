// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'localizacoes.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LocalizacoesAdapter extends TypeAdapter<Localizacoes> {
  @override
  final int typeId = 0;

  @override
  Localizacoes read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Localizacoes(
      nome: fields[0] as String,
      latitude: fields[1] as double,
      longitude: fields[2] as double,
      endereco: fields[3] as String,
      foto: fields[4] as String,
      descricao: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Localizacoes obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.nome)
      ..writeByte(1)
      ..write(obj.latitude)
      ..writeByte(2)
      ..write(obj.longitude)
      ..writeByte(3)
      ..write(obj.endereco)
      ..writeByte(4)
      ..write(obj.foto)
      ..writeByte(5)
      ..write(obj.descricao);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocalizacoesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
