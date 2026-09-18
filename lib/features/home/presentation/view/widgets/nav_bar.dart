import 'package:flutter/material.dart';
import 'package:marketi/core/routing/app_routes.dart';
import 'package:marketi/core/themes/app_colors.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
 int currentIndex = 0;

  void onItemTapped(int index) {
    if (index == 1) {
      _openRoute(AppRoutes.cart);
      return;
    }
    if (index == 2) {
      _openRoute(AppRoutes.favourite);
      return;
    }
    if (index == 3) {
      _openRoute(AppRoutes.profile);
      return;
    }

    setState(() {
      currentIndex = index;
    });
  }
   void _openRoute(String route, {Object? arguments}) {
    Navigator.pushNamed(context, route, arguments: arguments);
  }


  @override
  Widget build(BuildContext context) {
    return  BottomNavigationBar(
      onTap: onItemTapped,
      currentIndex: currentIndex,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.grey,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart_outlined),
          label: 'Cart',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_border),
          label: 'Favorites',
        ),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
    );
  }
}
