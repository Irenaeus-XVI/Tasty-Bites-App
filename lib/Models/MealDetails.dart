import 'package:final_flutter/Api/getMealDetails.dart';

import '../Api/getMeals.dart';

class MealDetails {
  String name = "";
  String urlImg = "";
  String instruction = "";

  MealDetails(this.name, this.urlImg, this.instruction);

  static List<MealDetails> mealList = [];

  static Future<List<MealDetails>> fetchData(String Meal) async {
    // await Future.delayed(Duration(seconds: 2));
    List<Map<String, dynamic>>? apiData = await GetMealDetails.fetchApiData(
        Meal);
    print(Meal);
    if (apiData == null) {
      return []; // Handle the case where the fetched data is null
    }

    mealList = apiData.map((meal) {
      String mealName = meal['name'] ?? '';
      String mealImg = meal['img'] ?? '';
      String mealInst = meal['instruction'] ?? '';
      return MealDetails(mealName, mealImg, mealInst);
    }).toList();

    mealList.forEach((element) {
      print(element);
    });

    return mealList;
  }
}
