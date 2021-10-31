import 'package:flutter/material.dart';
import 'package:food_store_app/common/constants.dart';
import 'package:food_store_app/presentation/pages/bookmark_page.dart';
import 'package:food_store_app/presentation/pages/home_page.dart';
import 'package:food_store_app/presentation/pages/profile_page.dart';
import 'package:food_store_app/presentation/provider/page_notifier.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  static const ROUTE_NAME = "/main-page";

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Widget _buildBottomNavBar({required PageNotifier? pageNotifier}) {
    return BottomNavigationBar(
      selectedItemColor: KBlueSecondary,
      unselectedItemColor: kGreySecondary,
      currentIndex: pageNotifier!.currentIndex,
      onTap: (index) {
        pageNotifier.currentIndex = index;
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bookmark_border_outlined),
          label: "Bookmark",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: "Home",
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    PageNotifier _pageNotifier = Provider.of<PageNotifier>(context);

    List _screen = [
      HomePage(),
      BookmarkPage(),
      ProfilePage(),
    ];

    return Scaffold(
      body: _screen[_pageNotifier.currentIndex],
      bottomNavigationBar: _buildBottomNavBar(
        pageNotifier: _pageNotifier,
      ),
    );
  }
}
