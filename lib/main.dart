
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:bcrypt/bcrypt.dart';
import 'Handlers/DatabaseHandler.dart';
import 'User.dart';

void main() {
  runApp(const MyApp());
  String name = "name";
  String email = "email";
  String pw = "password";
  String hashedPW = BCrypt.hashpw(pw, BCrypt.gensalt());
  User user = User(name:name, email:email, hashedPW:hashedPW);
  DatabaseHandler.addUser(user);
  Future<User?> user2 = DatabaseHandler.getUser("email");
  user2.then((value) => print(value?.getHashedPW()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Local Database demo app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}