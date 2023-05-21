import 'package:final_flutter/Screens/categories.dart';
import 'package:final_flutter/Screens/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/Category.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences pref = await SharedPreferences.getInstance();

  Widget currentScreen;
  String? savedEmail = await getData();
  if (savedEmail != "" && savedEmail != null) {
    currentScreen = CategoryList();
    // Data is available, do something with savedEmail
    print('Saved email: $savedEmail');
  } else {
    currentScreen = LoginScreen();
    // Data is not available
    print('No saved email found');
  }


  List<String> areas = await Category.fetchData();
  // await MealDetails.fetchData("");

  // await Meals.fetchData();
  // print(areas);
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: currentScreen,
    theme: ThemeData(
      primaryColor: Color(0xFF222222),
      appBarTheme: AppBarTheme(
        backgroundColor: Color(0xFF008080), // Set the color for the app bar
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Color(0xFF008080), // Set the color for the bottom navigation bar
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Color(0xFF008080), // Set the color for the floating action button
      ),
    ),
  ));



  // GetData().fetchApiData();

  // GetMeals.fetchApiData();
}

Future<String?> getData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? email = prefs.getString('email');
  return email;
}
