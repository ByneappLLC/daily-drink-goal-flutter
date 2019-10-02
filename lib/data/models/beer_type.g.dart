// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'beer_type.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BeerTypeAdapter extends TypeAdapter<BeerType> {
  @override
  BeerType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return BeerType.CanOrSmallBottle;
      case 1:
        return BeerType.LargeBottle;
      case 2:
        return BeerType.ManualEntry;
      default:
        return null;
    }
  }

  @override
  void write(BinaryWriter writer, BeerType obj) {
    switch (obj) {
      case BeerType.CanOrSmallBottle:
        writer.writeByte(0);
        break;
      case BeerType.LargeBottle:
        writer.writeByte(1);
        break;
      case BeerType.ManualEntry:
        writer.writeByte(2);
        break;
    }
  }
}
