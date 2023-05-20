
import '../Api/getData.dart';

class Category {
  String name = "";
  String speciality = "";

  String urlPhoto = "";

  Category(
    this.name,
    this.speciality,
    this.urlPhoto,
  );

  static List<String> areas = [];

  static Future<List<String>> fetchData() async {
    GetData getData = GetData();
    areas = await getData.fetchApiData();
    // print("Hello from Doctor");
    // print(areas.length);

    return areas;
  }

  static List<Category> initstat() {
    List<Category> categories = [];

    Category.areas.forEach((area) {
      categories.add(
        Category(
          area,
          'eyes speciality',
          'assets/images/category.jpg',
        ),
      );
    });

    // print(categories);

    return categories;
  }
}
