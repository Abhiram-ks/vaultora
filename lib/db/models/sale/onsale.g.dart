// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onsale.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SalesModelAdapter extends TypeAdapter<SalesModel> {
  @override
  final int typeId = 3;

  @override
  SalesModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SalesModel(
      id: fields[0] as String,
      date: fields[1] as String,
      accountName: fields[2] as String,
      address: fields[3] as String,
      phoneNumber: fields[4] as String,
      salesNumber: fields[5] as String,
      saleProduct: (fields[7] as List).cast<SaleProduct>(),
      totalPrice: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SalesModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.accountName)
      ..writeByte(3)
      ..write(obj.address)
      ..writeByte(4)
      ..write(obj.phoneNumber)
      ..writeByte(5)
      ..write(obj.salesNumber)
      ..writeByte(6)
      ..write(obj.totalPrice)
      ..writeByte(7)
      ..write(obj.saleProduct);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SalesModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SaleProductAdapter extends TypeAdapter<SaleProduct> {
  @override
  final int typeId = 4;

  @override
  SaleProduct read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SaleProduct(
      id: fields[0] as String,
      dropdown: fields[1] as String,
      product: fields[2] as String,
      mrprate: fields[3] as String,
      count: fields[4] as String,
      price: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SaleProduct obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.dropdown)
      ..writeByte(2)
      ..write(obj.product)
      ..writeByte(3)
      ..write(obj.mrprate)
      ..writeByte(4)
      ..write(obj.count)
      ..writeByte(5)
      ..write(obj.price);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SaleProductAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
