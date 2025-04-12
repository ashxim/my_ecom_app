import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:my_ecom_app/features/product/presentation/screens/my_home_page.dart';
import 'package:my_ecom_app/features/product/presentation/screens/search_screen.dart';
import 'package:my_ecom_app/features/product/presentation/screens/user_profile.dart';
import 'package:my_ecom_app/features/product/presentation/screens/wishlist.dart';

class BtmNavBar extends StatefulWidget {
  const BtmNavBar({super.key});

  @override
  State<BtmNavBar> createState() => _BtmNavBarState();
}

class _BtmNavBarState extends State<BtmNavBar> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  void _handleIndexChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: const [
          MyHomePage(),
          WishlistScreen(),
          SearchScreen(),
          UserProfileWidget()
        ],
      ),
      bottomNavigationBar: CrystalNavigationBar(
        currentIndex: _selectedIndex,
        unselectedItemColor: Colors.white70,
        backgroundColor: Colors.black.withOpacity(0.2),
        onTap: _handleIndexChanged,
        items: [
          CrystalNavigationBarItem(
            icon: IconlyBold.home,
            unselectedIcon: IconlyLight.home,
            selectedColor: Colors.white,
          ),
          CrystalNavigationBarItem(
            icon: IconlyBold.heart,
            unselectedIcon: IconlyLight.heart,
            selectedColor: Colors.red,
          ),
          CrystalNavigationBarItem(
            icon: IconlyBold.search,
            unselectedIcon: IconlyLight.search,
            selectedColor: Colors.black,
          ),
          CrystalNavigationBarItem(
            icon: IconlyBold.user_2,
            unselectedIcon: IconlyLight.user,
            selectedColor: Colors.blue,
          ),
        ],
      ),
    );
  }
}
