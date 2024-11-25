import 'package:hive/hive.dart';

part 'onsale.g.dart';


@HiveType(typeId: 3)
class SalesModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String date;

  @HiveField(2)
  final String accountName;

  @HiveField(3)
  final String address;

  @HiveField(4)
  final String phoneNumber;

  @HiveField(5)
  final String salesNumber;

  @HiveField(6)
  final String totalPrice;

  @HiveField(7)
  final List<SaleProduct> saleProduct;

  SalesModel({
    required this.id,
    required this.date,
    required this.accountName,
    required this.address,
    required this.phoneNumber,
    required this.salesNumber,
    required this.saleProduct,
    required this.totalPrice,
  });
}

@HiveType(typeId: 4)
class SaleProduct extends HiveObject {
    @HiveField(0)
  final String id;

  @HiveField(1)
  final String dropdown;

  @HiveField(2)
  final String product;

  @HiveField(3)
  final String mrprate;

  @HiveField(4)
  final String count;

  @HiveField(5)
  final String price;

  SaleProduct({
    required this.id,
    required this.dropdown,
    required this.product,
    required this.mrprate,
    required this.count,
    required this.price,
  });
}
