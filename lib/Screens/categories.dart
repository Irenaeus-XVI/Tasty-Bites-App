import 'package:final_flutter/Screens/profile.dart';
import 'package:flutter/material.dart';

import '../Models/Category.dart';
import 'Meals_List.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({Key? key}) : super(key: key);

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  int _selectedItem = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
        backgroundColor: Color(0xFF008080),
      ),
      appBar: appBar(),
      bottomNavigationBar: bottomNavBar(),
      body: ListView(
        children: Category.initstat().map((category) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                print(category.name);
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => MealsList(selectedCategory: category.name),
                  ),
                );
              },
              child: Container(
                width: size.width,
                height: size.height / 5,
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
                      Image.asset(
                        category.urlPhoto,
                        width: double.infinity,
                        fit: BoxFit.cover,
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
                              category.name,
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4),
                            Icon(
                              Icons.category_sharp,
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
            ),
          );
        }).toList(),
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      title: Text(
        "Category List",
        style: TextStyle(color: Colors.white),
      ),
      centerTitle: true,
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
      ),
      actions: [
        PopupMenuButton(
          itemBuilder: (BuildContext context) => [
            PopupMenuItem(
              child: Text("Option 1"),
              value: 1,
            ),
            PopupMenuItem(
              child: Text("Option 2"),
              value: 2,
            ),
            PopupMenuItem(
              child: Text("Option 3"),
              value: 3,
            ),
          ],
          onSelected: (value) {
            switch (value) {
              case 1:
                // Perform action for Option 1
                break;
              case 2:
                // Perform action for Option 2
                break;
              case 3:
                // Perform action for Option 3
                break;
            }
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          offset: Offset(0, 50),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: Icon(
              Icons.more_vert_outlined,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }

  Widget bottomNavBar() {
    return BottomNavigationBar(
      currentIndex: _selectedItem,
      onTap: (index) {
        setState(() {
          _selectedItem = index;
          if(_selectedItem == 2){
            Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ProfilePage(),
                ));
          }
        });
      },
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: TextStyle(color: Colors.white),
      unselectedLabelStyle: TextStyle(color: Color(0xff222222)),
      items: const [
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
          icon: Icon(
            Icons.person,
            color: Colors.white,
          ),
          label: 'Profile',
        ),
      ],
    );
  }
}
