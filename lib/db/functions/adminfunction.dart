import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/user/user.dart';

ValueNotifier<UserModel?> currentUserNotifier = ValueNotifier<UserModel?>(null);
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
  required String name,
  required String email,
  required String phone,
  required String username,
  required String pass,
}) async {
  await initUserDB();

  if (await userExists(username)) {
    log("Username already exists: $username");
    return false;
  }

  try {
    final newUser = UserModel(
      id: id,
      name: name,
      email: email,
      phone: phone,
      username: username,
      password: pass,
    );

    await userBox!.put(id, newUser);
    await getAllUser();
    log("User added successfully: $name");
    return true;
  } catch (e) {
    log("Error adding user: $e");
    return false;
  }
}

Future<bool> updateUser({
  required String id,
  required String username,
  required String name,
  required String phone,
  required String bio,
  required String age,
  String? imagePath,
}) async {
  await initUserDB();
    if (userBox == null) {
    log("Error: userBox is not initialized.");
    return false;
  }
  
  try {
    UserModel? user = userBox!.get(id);
    if(user != null){
      UserModel updatedUser = UserModel(
        id: id,
        name: name,
        email: user.email,
        phone: phone,
        username: username,
        password: user.password,
        bio: bio,
        age: age,
        imagePath: imagePath ?? user.imagePath,
        );

        await userBox!.put(id, updatedUser);
        await getAllUser();
        log("User updated successfully: $username");
         currentUserNotifier.value = updatedUser;
      currentUserNotifier.notifyListeners();
      return true;
    }else {
      log("User not found: $id");
      return false;
    }
  }catch (e) {
    log("Error updating user: $e");
    return false;
  }
}

Future<bool> userExists(String username) async {
  await initUserDB();
  try {
     return userBox!.values.any((user) => user.username == username);
  } catch (e) {
    log("Error in userExists: $e");
    return false;
  }
}

Future<void> getAllUser() async {
  await initUserDB();
  if (userBox != null && userBox!.isOpen) {
    userListNotifier.value = userBox!.values.toList();
    userListNotifier.notifyListeners();
  } else {
    log("Error: userBox is null or not opened");
  }
}

Future<void> deleteUser(String id) async {
  await initUserDB();
  await userBox!.delete(id);
  await getAllUser();
}

void printAllUsers() {
  for (var user in userListNotifier.value) {
    log('User: ${user.name}, Email: ${user.email}, Phone: ${user.phone}, Username: ${user.username}, Password: ${user.password}');
  }
}

Future<void> logOutUser(String id) async {
  await initUserDB();
  UserModel? user = userBox!.get(id);
  if (user != null) {
    await userBox!.put(id, user);
  }
}
