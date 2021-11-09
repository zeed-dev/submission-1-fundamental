import 'package:food_store_app/common/exception.dart';
import 'package:food_store_app/data/datasource/db/database_helper.dart';
import 'package:food_store_app/data/model/restaurant_table.dart';

abstract class RestaurantLocalDataSource {
  Future<String> insertBookmark(RestaurantTable restaurant);
  Future<String> removeBookmark(RestaurantTable restaurant);
  Future<RestaurantTable?> getRestaurantById(String id);
  Future<List<RestaurantTable>> getBookmarkRestaurant();
}

class RestaurantLocalDataSourceImpl implements RestaurantLocalDataSource {
  final DatabaseHelper databaseHelper;

  RestaurantLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<String> insertBookmark(RestaurantTable restaurant) async {
    try {
      await databaseHelper.insertBookmark(restaurant);
      return "Added to Bookmark";
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  Future<RestaurantTable?> getRestaurantById(String id) async {
    final result = await databaseHelper.getRestaurantById(id);
    if (result != null) {
      return RestaurantTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<String> removeBookmark(RestaurantTable restaurant) async {
    try {
      await databaseHelper.removeRestaurant(restaurant);
      return "Removed from Bookmark";
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<List<RestaurantTable>> getBookmarkRestaurant() async {
    final result = await databaseHelper.getBookmarkRestaurant();
    return result.map((e) => RestaurantTable.fromMap(e)).toList();
  }
}
