import 'package:TastyBites/Api/getMealDetails.dart';

import '../Api/getMeals.dart';

class Meals {
  String name = "";
  String urlImg = "";
  String cal = "";

  Meals(this.name, this.urlImg, this.cal);

  static List<Meals> mealList = [];

  static Future<List<Meals>> fetchData(String category) async {
    // await Future.delayed(Duration(seconds: 2));
    List<Map<String, dynamic>>? apiData = await GetMeals.fetchApiData(category);
    List<Map<String, dynamic>>? apiDatadetails = await GetMealDetails.fetchApiData(category);
    print(category);
    if (apiData == null) {
      return []; // Handle the case where the fetched data is null
    }

    mealList = apiData.map((meal) {
      String mealName = meal['name'] ?? '';
      String mealImg = meal['img'] ?? '';
      String calor = "350";
      return Meals(mealName, mealImg, calor);
    }).toList();
    print("*******************************");
    print("*******************************");
    print("*******************************");
    print("*******************************");
    print(apiDatadetails);
    print("*******************************");
    print("*******************************");
    print("*******************************");
    print("*******************************");
    return mealList;
  }
}
