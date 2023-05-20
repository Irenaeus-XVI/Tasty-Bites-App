import 'package:final_flutter/Screens/login.dart';
import 'package:flutter/material.dart';

import '../Models/Category.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  List<String> areas = await Category.fetchData();
  // await MealDetails.fetchData("");

  // await Meals.fetchData();
  // print(areas);
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: LoginScreen(),
    theme: ThemeData(
      primaryColor: Color(0xFF222222),
      appBarTheme: AppBarTheme(
        backgroundColor: Color(0xFF008080), // Set the color for the app bar
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor:
            Color(0xFF008080), // Set the color for the bottom navigation bar
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor:
            Color(0xFF008080), // Set the color for the floating action button
      ),
    ),
  ));

  // GetData().fetchApiData();

  // GetMeals.fetchApiData();
}
