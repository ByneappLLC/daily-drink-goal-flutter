// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drink.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DrinkAdapter extends TypeAdapter<Drink> {
  @override
  Drink read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Drink(
      fields[0] as int,
      fields[1] as BeerType,
      fields[2] as DateTime,
      fields[3] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Drink obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.amount)
      ..writeByte(1)
      ..write(obj.type)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.synced);
  }
}
