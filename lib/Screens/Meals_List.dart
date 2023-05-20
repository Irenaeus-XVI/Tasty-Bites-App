import 'package:final_flutter/Models/Meals.dart';
import 'package:final_flutter/Screens/profile.dart';
import 'package:flutter/material.dart';

import 'Meals_Details.dart';

class MealsList extends StatefulWidget {
  final String selectedCategory;

  MealsList({Key? key, required this.selectedCategory}) : super(key: key);

  @override
  State<MealsList> createState() => _MealsListState();
}

class _MealsListState extends State<MealsList> {
  int _selectedItem = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String selectedCategory =
        widget.selectedCategory; // Use widget.selectedCategory
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
        backgroundColor: Color(0xFF008080),
      ),
      appBar: appBar(),
      bottomNavigationBar: bottomNavBar(),
      body: FutureBuilder<List<Meals>>(
        future: Meals.fetchData(selectedCategory),
        builder: (BuildContext context, AsyncSnapshot<List<Meals>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          List<Meals> mealItems = snapshot.data!;
          return ListView.builder(
            itemCount: mealItems.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: size.width,
                  height: size.height / 5,
                  child: mealCard(mealItems[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      title: const Text("Meals List"),
      centerTitle: true,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back, color: Colors.white),
      ),
      actions: [
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.workspaces_filled,
              color: Colors.white,
            ))
      ],
    );
  }

  Widget bottomNavBar() {
    return BottomNavigationBar(
      currentIndex: _selectedItem,
      onTap: (index) {
        setState(() {
          _selectedItem = index;
        });
      },
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: TextStyle(color: Colors.white),
      unselectedLabelStyle: TextStyle(color: Color(0xff222222)),
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            color: Colors.white,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.notifications_sharp,
            color: Colors.white,
          ),
          label: 'Notification',
        ),
        BottomNavigationBarItem(
          icon: GestureDetector(
            onTap: () {
              // Handle click on "Person" icon
              Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ProfilePage(),
                  ));
            },
            child: Icon(
              Icons.person_rounded,
              color: Colors.white,
            ),
          ),
          label: 'Person',
        ),
      ],
    );
  }


  Widget mealCard(Meals meal) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => MealDetails(meal),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Stack(
            children: [
              Image.network(
                meal.urlImg,
                width: double.infinity,
                fit: BoxFit.cover,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  } else {
                    return Container(
                      color: Colors.grey[300],
                      child: Center(
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.green),
                        ),
                      ),
                    );
                  }
                },
                errorBuilder: (BuildContext context, Object exception,
                    StackTrace? stackTrace) {
                  return Icon(Icons.error);
                },
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.7),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      meal.name,
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Icon(
                      Icons.set_meal_sharp,
                      color: Colors.white,
                      size: 16,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
