import 'dart:io';
import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:food_store_app/external/background_service.dart';
import 'package:food_store_app/external/notification_helper.dart';
import 'package:food_store_app/presentation/pages/detail_page.dart';
import 'package:food_store_app/presentation/pages/main_page.dart';
import 'package:food_store_app/presentation/pages/search_page.dart';
import 'package:food_store_app/presentation/pages/onboarding_page.dart';
import 'package:food_store_app/presentation/pages/splash_page.dart';
import 'package:food_store_app/presentation/provider/bookmark_notifier.dart';
import 'package:food_store_app/presentation/provider/page_notifier.dart';
import 'package:food_store_app/presentation/provider/restaurant_detail_notifier.dart';
import 'package:food_store_app/presentation/provider/restaurant_notifer.dart';
import 'package:food_store_app/presentation/provider/scheduling_notifier.dart';
import 'package:food_store_app/presentation/provider/search_restaurant_notifier.dart';
import 'package:provider/provider.dart';
import 'injection.dart' as getIt;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();

  _service.initializeIsolate();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

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
        ChangeNotifierProvider(
          create: (_) => BookmarkNotifier(getBookmarkRestaurant: getIt.getIt()),
        ),
        ChangeNotifierProvider(
          create: (_) => SchedulingNotifier(),
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
