import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_store_app/presentation/pages/detail_page.dart';
import 'package:food_store_app/presentation/pages/main_page.dart';
import 'package:food_store_app/presentation/pages/search_page.dart';
import 'package:food_store_app/presentation/pages/onboarding_page.dart';
import 'package:food_store_app/presentation/pages/splash_page.dart';
import 'package:food_store_app/presentation/provider/page_notifier.dart';
import 'package:food_store_app/presentation/provider/restaurant_detail_notifier.dart';
import 'package:food_store_app/presentation/provider/restaurant_notifer.dart';
import 'package:food_store_app/presentation/provider/search_restaurant_notifier.dart';
import 'package:provider/provider.dart';
import 'injection.dart' as getIt;

void main() {
  runApp(MyApp());
  getIt.init();
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
          create: (_) => RestaurantNotifier(getRestaurant: getIt.getIt()),
        ),
        ChangeNotifierProvider(
          create: (_) => RestaurantDetailNotifier(
            getRestaurantDetail: getIt.getIt(),
            addReview: getIt.getIt(),
            saveRestaurant: getIt.getIt(),
            getBookmarkStatus: getIt.getIt(),
            removeBookmark: getIt.getIt(),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) =>
              SearechRestaurantNotifier(serachRestaurant: getIt.getIt()),
        ),
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
              final id = settings.arguments as String;
              return CupertinoPageRoute(
                builder: (_) => DetailPage(
                  id: id,
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
