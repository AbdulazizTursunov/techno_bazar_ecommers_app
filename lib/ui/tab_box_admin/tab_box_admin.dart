
import 'package:flutter/material.dart';
import 'package:untitled10/ui/tab_box_admin/products/product_screen_admin.dart';
import '../profile/profile_screen.dart';
import 'category/category_admin.dart';

class TabBoxAdmin extends StatefulWidget {
  const TabBoxAdmin({super.key});

  @override
  State<TabBoxAdmin> createState() => _TabBoxAdminState();
}

class _TabBoxAdminState extends State<TabBoxAdmin> {
  List<Widget> activeScreen = [];

  int screenIndex = 0;

  @override
  void initState() {
    activeScreen = [
     ProductScreenAdmin(),
      CategoryScreenAdmin(),
      ProfileScreen(),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: activeScreen[screenIndex],
      bottomNavigationBar:  BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        fixedColor: Colors.teal,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        currentIndex: screenIndex,
        onTap: (v){
          setState(() {
            screenIndex = v;
          });
        },
        items:const [
          BottomNavigationBarItem(
            label: 'Product',
            icon: Icon(Icons.shop_2),
          ),
          BottomNavigationBarItem(
            label: 'category',
            icon: Icon(Icons.category),
          ),
          BottomNavigationBarItem(
            label: 'Profile',
            icon: Icon(Icons.person),
          ),
        ],
      ),
    );
  }
}