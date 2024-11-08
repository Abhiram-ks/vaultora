import 'package:hive/hive.dart';

part 'catalog.g.dart';

@HiveType(typeId: 1)
class CategoryModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String userid;
  @HiveField(2)
  final String categoryName;
  @HiveField(3)
  final String imagePath;

  CategoryModel({required this.id,required this.userid, required this.categoryName, required this.imagePath});
}
