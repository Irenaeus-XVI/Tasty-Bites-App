import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GetData {
  Future<List<String>> fetchApiData() async {
    //https://www.themealdb.com/api/json/v1/1/list.php?a=list
    var apiUrl =
        'https://www.themealdb.com/api/json/v1/1/categories.php'; // Replace with your API endpoint

    var response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      // Request successful, parse the response data
      var responseData = response.body;
      var data = jsonDecode(responseData);
      List<dynamic> meals = data['categories'];
      List<String> areas = [];

      // Get the strArea from each meal

      meals.forEach((meal) {
        String area = meal['strCategory'];
        areas.add(area);
      });

      // Print the strArea values
      // print('--------------------------------------------------');
      // print('strArea values:');
      // print(areas);
      // print('--------------------------------------------------');
      //
      // // Print the entire meals data
      // print('--------------------------------------------------');
      // print('meals data:');
      // meals.forEach((meal) {
      //   print(meal);
      // });

      print('--------------------------------------------------');

      // print(areas);

      return areas;
    } else {
      // Request failed
      print('Request failed with status: ${response.statusCode}');
      return [];
    }
  }
}
