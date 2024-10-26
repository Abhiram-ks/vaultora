import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/user.dart';

ValueNotifier<List<UserModel>> userListNotifier = ValueNotifier([]);
Box<UserModel>? userBox;
String? _currentLoggedInUserId; // Stores the ID of the currently logged-in user

// Initialize the Hive database for user management
Future<void> initUserDB() async {
  if (userBox == null) {
    userBox = await Hive.openBox<UserModel>('user_db');
    log("user_db box opened");
  } else {
    log("user_db box is already open");
  }
}

// Add a new user to the database
Future<bool> addUser({
  required String id,
  required String username,
  required String email,
  required String phone,
  required String pass,
}) async {
  await initUserDB();

  // Check if the username already exists
  final existingUser = userBox!.values.firstWhere(
    (user) => user.username == username,
    orElse: () => UserModel(id: '', username: '', email: '', phone: '', password: ''),
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
    await getAllUser(); // Refresh the user list
    log("User added: $username");
    return true;
  } catch (e) {
    log("Error adding user: $e");
    return false;
  }
}

// Retrieve all users from the database
Future<void> getAllUser() async {
  await initUserDB();
  userListNotifier.value.clear();
  userListNotifier.value.addAll(userBox!.values);
  userListNotifier.notifyListeners();
}

// Delete a user by ID
Future<void> deleteUser(String id) async {
  await initUserDB();
  await userBox!.delete(id);
  await getAllUser(); // Refresh the user list
}

// Print all users in the console
void printAllUsers() {
  for (var user in userListNotifier.value) {
    log('Username: ${user.username}, Email: ${user.email}, Phone: ${user.phone}, Password: ${user.password}');
  }
}

// User login function
Future<bool> loginUser({
  required String username,
  required String password,
}) async {
  await initUserDB();

  // Ensure no user is already logged in
  if (_currentLoggedInUserId != null) {
    log("Another user is already logged in");
    return false;
  }

  // Check if the credentials match any user
  final user = userBox!.values.firstWhere(
    (user) => user.username == username && user.password == password,
    orElse: () => UserModel(id: '', username: '', email: '', phone: '', password: ''),
  );

  if (user.username.isNotEmpty) {
    _currentLoggedInUserId = user.id;
    log("Login successful for user: $username");
    return true;
  } else {
    log("Login failed: Invalid username or password");
    return false;
  }
}

// User logout function
Future<void> logoutUser() async {
  if (_currentLoggedInUserId != null) {
    log("User logged out: $_currentLoggedInUserId");
    _currentLoggedInUserId = null;
  } else {
    log("No user is currently logged in");
  }
}
