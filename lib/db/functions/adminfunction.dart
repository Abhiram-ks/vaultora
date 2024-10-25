import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../models/admindb.dart';

ValueNotifier<List<UserModel>> userListNotifier = ValueNotifier([]);
Box<UserModel>? userBox;

Future<void> initUserDB() async {
  if (userBox == null) {
    userBox = await Hive.openBox<UserModel>('user_db');
    log("user_db box opened");
  } else {
    log("user_db box is already open");
  }
}

Future<bool> addUser({
  required String id,
  required String username,
  required String email,
  required String phone,
  required String pass,
}) async {
  await initUserDB();
  final existingUser = userBox!.values.firstWhere(
    (user) => user.username == username,
    orElse: () =>
        UserModel(id: '', username: '', email: '', phone: '', password: ''),
  );

  if (existingUser.username.isNotEmpty) {
    log("Username already exists: $username");
    return false;
  }

  try {
    final newUser = UserModel(
      id: id,
      username: username,
      email: email,
      phone: phone,
      password: pass,
    );

    await userBox!.put(id, newUser);
    await getAllUser();
    log("User added: $username");
    return true;
  } catch (e) {
    log("Error adding user: $e");
    return false;
  }
}

Future<void> getAllUser() async {
  await initUserDB();
  userListNotifier.value.clear();
  userListNotifier.value.addAll(userBox!.values);
  userListNotifier.notifyListeners();
}

Future<void> deleteUser(String id) async {
  await initUserDB();
  await userBox!.delete(id);
  await getAllUser();
}

void printAllUsers() {
  for (var user in userListNotifier.value) {
    log('Username: ${user.username}, Email: ${user.email}, Phone: ${user.phone}, Password: ${user.password}');
  }
}
