import 'package:hive/hive.dart';
  
part 'add.g.dart';

@HiveType(typeId: 2)
class AddModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String userid;
  @HiveField(2)
  final String itemName;
  @HiveField(3)
  final String description;
  @HiveField(4)
  final String purchaseRate;
  @HiveField(5)
  final String mrp;
  @HiveField(6)
  final String dropDown;
  @HiveField(7)
  final String itemCount;
  @HiveField(8)
  final String totalPurchase;
   @HiveField(9)
  final String imagePath;

  AddModel({
    required this.id,
    required this.userid,
    required this.itemName,
    required this.description,
    required this.purchaseRate,
    required this.mrp,
    required this.dropDown,
    required this.itemCount,
    required this.totalPurchase,
    required this.imagePath
  });
}
