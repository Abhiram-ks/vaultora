import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class UserModel{
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String email;

  @HiveField(3)
  final String phone;

  @HiveField(4)
  final String username;

  @HiveField(5)
  final String password;
  
  @HiveField(6)
  final String bio;

  @HiveField(7)
  final String age;

  @HiveField(8)
  final String? imagePath;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.username,
    required this.password,
    this.bio ='',
    this.age = '',
    this.imagePath,
  });
}
