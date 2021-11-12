import 'package:food_store_app/common/exception.dart';
import 'package:food_store_app/data/datasource/db/database_helper.dart';
import 'package:food_store_app/data/model/restaurant_table.dart';

abstract class RestaurantLocalDataSource {
  Future<String> insertFavorite(RestaurantTable restaurant);
  Future<String> removeFavorite(RestaurantTable restaurant);
  Future<RestaurantTable?> getRestaurantById(String id);
  Future<List<RestaurantTable>> getRestaurantRestaurant();
}

class RestaurantLocalDataSourceImpl implements RestaurantLocalDataSource {
  final DatabaseHelper databaseHelper;

  RestaurantLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<String> insertFavorite(RestaurantTable restaurant) async {
    try {
      await databaseHelper.insertFavorite(restaurant);
      return "Added to Favorite";
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
  Future<String> removeFavorite(RestaurantTable restaurant) async {
    try {
      await databaseHelper.removeRestaurant(restaurant);
      return "Removed from Favorite";
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<List<RestaurantTable>> getRestaurantRestaurant() async {
    final result = await databaseHelper.getFavoriteRestaurant();
    return result.map((e) => RestaurantTable.fromMap(e)).toList();
  }
}
