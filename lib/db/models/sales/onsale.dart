import 'package:hive/hive.dart';

import '../product/add.dart';
part 'onsale.g.dart';



@HiveType(typeId: 3)
class SalesModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String accountName;

  @HiveField(2)
  final String address;

  @HiveField(3)
  final String phoneNumber;

  @HiveField(4)
  final String salesNumber;

  @HiveField(5)
  final String totalPrice;

  @HiveField(6)
  final List<SaleProduct> saleProduct;



  SalesModel({
    required this.id,
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
  final AddModel product;

  @HiveField(1)
  final String count;

  @HiveField(2)
  final String price;

  SaleProduct({
    required this.product,
    required this.count,
    required this.price,
  });
}
