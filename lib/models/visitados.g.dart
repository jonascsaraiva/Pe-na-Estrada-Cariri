// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visitados.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VisitadoAdapter extends TypeAdapter<Visitado> {
  @override
  final int typeId = 1;

  @override
  Visitado read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Visitado(
      partida: fields[0] as String,
      destino: fields[1] as Localizacoes,
      dataHora: fields[2] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, Visitado obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.partida)
      ..writeByte(1)
      ..write(obj.destino)
      ..writeByte(2)
      ..write(obj.dataHora);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VisitadoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
