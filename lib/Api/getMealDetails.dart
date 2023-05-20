import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GetMealDetails {
  static Future<List<Map<String, dynamic>>?> fetchApiData(String meal) async {
    var apiUrl = 'https://www.themealdb.com/api/json/v1/1/search.php?s=Arrabiata';
    print("from fetch now $meal");
    var response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      var responseData = response.body;
      var data = jsonDecode(responseData);
      List<dynamic>? meals = data['meals'];

      if (meals != null) {
        List<Map<String, dynamic>> mealList = [];

        meals.forEach((meal) {
          String? name = meal['strMeal'];
          String? img = meal['strMealThumb'];
          String? instruction = meal['strInstructions'];

          if (name != null && img != null) {
            Map<String, dynamic> mealData = {
              'name': name,
              'img': img,
              'instruction':instruction,
            };

            mealList.add(mealData);
          }
        });
        print("*******************************");
        print("*******************************");

        mealList.forEach((element) {
          print(element);
        });
        print("*******************************");
        print("*******************************");

        return mealList;
      } else {
        return null;
      }
    } else {
      print('Request failed with status: ${response.statusCode}');
      return null;
    }
  }
}
