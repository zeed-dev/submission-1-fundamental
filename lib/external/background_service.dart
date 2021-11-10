import 'dart:isolate';
import 'dart:ui';
import 'package:food_store_app/data/datasource/db/database_helper.dart';
import 'package:food_store_app/data/datasource/restaurant_local_data_source.dart';
import 'package:food_store_app/data/datasource/restaurant_remote_data_source.dart';
import 'package:food_store_app/data/repositories/restaurant_repositroy_impl.dart';
import 'package:food_store_app/domain/entities/restaurant.dart';
import 'package:food_store_app/domain/usecases/get_restaurant.dart';
import 'package:food_store_app/external/notification_helper.dart';
import 'package:food_store_app/main.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

final ReceivePort port = ReceivePort();

class BackgroundService {
  static BackgroundService? _instance;
  static String _isolateName = 'isolate';
  static SendPort? _uiSendPort;

  BackgroundService._internal() {
    _instance = this;
  }

  factory BackgroundService() => _instance ?? BackgroundService._internal();

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(
      port.sendPort,
      _isolateName,
    );
  }

  static List<Restaurant> _restaurant = <Restaurant>[];
  static List<Restaurant> get restaurant => _restaurant;
  static Logger _logger = Logger();

  static Future<void> callback() async {
    print('Alarm fired!');
    final NotificationHelper _notificationHelper = NotificationHelper();
    var result = await GetRestaurant(
      RestaurantRepositoryImpl(
        restaurantRemoteDataSource: RestaurantRemoteDataSourceImpl(
          client: http.Client(),
        ),
        restaurantLocalDataSource: RestaurantLocalDataSourceImpl(
          databaseHelper: DatabaseHelper(),
        ),
      ),
    ).execute();

    result.fold((failure) {
      _logger.w(failure.message);
    }, (restaurant) {
      _restaurant = restaurant;
    });

    await _notificationHelper.showNotification(
      flutterLocalNotificationsPlugin,
      _restaurant,
    );

    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }
}
