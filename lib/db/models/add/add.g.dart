// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AddModelAdapter extends TypeAdapter<AddModel> {
  @override
  final int typeId = 2;

  @override
  AddModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AddModel(
      id: fields[0] as String,
      userid: fields[1] as String,
      itemName: fields[2] as String,
      description: fields[3] as String,
      purchaseRate: fields[4] as String,
      mrp: fields[5] as String,
      dropDown: fields[6] as String,
      itemCount: fields[7] as String,
      totalPurchase: fields[8] as String,
      imagePath: fields[9] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AddModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.userid)
      ..writeByte(2)
      ..write(obj.itemName)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.purchaseRate)
      ..writeByte(5)
      ..write(obj.mrp)
      ..writeByte(6)
      ..write(obj.dropDown)
      ..writeByte(7)
      ..write(obj.itemCount)
      ..writeByte(8)
      ..write(obj.totalPurchase)
      ..writeByte(9)
      ..write(obj.imagePath);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AddModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
