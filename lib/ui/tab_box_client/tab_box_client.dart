
import 'package:flutter/material.dart';
import 'package:untitled10/ui/tab_box_client/products_client/product_screen.dart';

import '../profile/profile_screen.dart';
import 'basket/basket_screen.dart';
import 'category_client/category.dart';


class TabBoxClient extends StatefulWidget {
  const TabBoxClient({super.key});

  @override
  State<TabBoxClient> createState() => _TabBoxClientState();
}

class _TabBoxClientState extends State<TabBoxClient> {
  List<Widget> activeScreen = [];

  int screenIndex = 0;

  @override
  void initState() {
    activeScreen = [
     ProductScreenClient(),
      CategoryScreenClient(),
      BasketScreen(),
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
            label: 'Favorites',
            icon: Icon(Icons.favorite),
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

