import 'dart:convert';

import 'package:http/http.dart' as http;

class GetMeals {
  static Future<List<Map<String, dynamic>>?> fetchApiData(
      String category) async {
    var apiUrl =
        'https://www.themealdb.com/api/json/v1/1/filter.php?c=$category';
    print("from fetch now $category");
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

          if (name != null && img != null) {
            Map<String, dynamic> mealData = {
              'name': name,
              'img': img,
            };

            mealList.add(mealData);
          }
        });
        // print(meals);
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
