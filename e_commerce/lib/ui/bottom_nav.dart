import 'package:flutter/material.dart';
import 'package:e_commerce/ui/Bottom_Nav_pages/cart.dart';
import 'package:e_commerce/ui/Bottom_Nav_pages/favourite.dart';
import 'package:e_commerce/ui/Bottom_Nav_pages/home.dart';
import 'package:e_commerce/ui/Bottom_Nav_pages/profle.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  final _pages = [
    Home(),
    Favourite(),
    Cart(),
    Profile(),
  ];
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'Home',
            //backgroundColor: Colors.grey,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite_outline,
              color: Colors.black,
            ),
            label: 'Favourite',
            // backgroundColor: Colors.grey,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.shopping_cart,
              color: Colors.black,
            ),
            label: 'Cart',
            // backgroundColor: Colors.grey,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: Colors.black,
            ),
            label: 'Profile',
            // backgroundColor: Colors.grey,
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      body: _pages[_currentIndex],
    );
  }
}
