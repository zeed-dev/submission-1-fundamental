import 'package:flutter/material.dart';
import 'package:food_store_app/common/constants.dart';
import 'package:food_store_app/external/notification_helper.dart';
import 'package:food_store_app/presentation/pages/favorite_page.dart';
import 'package:food_store_app/presentation/pages/detail_page.dart';
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
  final NotificationHelper _notificationHelper = NotificationHelper();

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
          icon: Icon(Icons.favorite_outline),
          label: "Favorite",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: "Home",
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    _notificationHelper.configureSelectNotificationSubject(
      context,
      DetailPage.ROUTE_NAME,
    );
  }

  @override
  Widget build(BuildContext context) {
    PageNotifier _pageNotifier = Provider.of<PageNotifier>(context);

    List _screen = [
      HomePage(),
      FavoritePage(),
      ProfilePage(),
    ];

    return Scaffold(
      body: _screen[_pageNotifier.currentIndex],
      bottomNavigationBar: _buildBottomNavBar(
        pageNotifier: _pageNotifier,
      ),
    );
  }

  @override
  void dispose() {
    selectNotificationSubject.close();
    super.dispose();
  }
}
