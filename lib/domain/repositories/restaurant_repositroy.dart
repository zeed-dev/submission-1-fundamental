import 'package:dartz/dartz.dart';
import 'package:food_store_app/common/failure.dart';
import 'package:food_store_app/domain/entities/restaurant.dart';
import 'package:food_store_app/domain/entities/restaurant_detail.dart';

abstract class RestaurantRepository {
  Future<Either<Failure, List<Restaurant>>> getRestaurant();
  Future<Either<Failure, RestaurantDetail>> getDetailRestaurant(String id);
  Future<Either<Failure, List<Restaurant>>> searchRestaurant(String query);
  Future<Either<Failure, String>> addReview(
    String reviews,
    String name,
    String id,
  );
  Future<Either<Failure, String>> saveFavorite(RestaurantDetail restaurant);
  Future<Either<Failure, String>> removeFavorite(RestaurantDetail restaurant);
  Future<bool> isAddedToFavorite(String id);
  Future<Either<Failure, List<Restaurant>>> getFavoriteRestaurant();
}
