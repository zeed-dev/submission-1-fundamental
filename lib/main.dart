import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_store_app/data/model/restaurant_model.dart';
import 'package:food_store_app/presentation/pages/detail_page.dart';
import 'package:food_store_app/presentation/pages/main_page.dart';
import 'package:food_store_app/presentation/pages/search_page.dart';
import 'package:food_store_app/presentation/pages/onboarding_page.dart';
import 'package:food_store_app/presentation/pages/splash_page.dart';
import 'package:food_store_app/presentation/provider/bookmark_notifier.dart';
import 'package:food_store_app/presentation/provider/page_notifier.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => PageNotifier(),
        ),
        ChangeNotifierProvider(
          create: (_) => BookmarkNotifer(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashPage(),
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case "/splash":
              return MaterialPageRoute(builder: (_) => SplashPage());
            case MainPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => MainPage());
            case OnboardingPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => OnboardingPage());
            case DetailPage.ROUTE_NAME:
              final restaurant = settings.arguments as RestaurantModel;
              return CupertinoPageRoute(
                builder: (_) => DetailPage(
                  restaurant: restaurant,
                ),
              );
            case SearchPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchPage());
            default:
          }
        },
      ),
    );
  }
}
