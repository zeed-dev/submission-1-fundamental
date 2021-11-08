import 'package:dartz/dartz.dart';
import 'package:food_store_app/common/failure.dart';
import 'package:food_store_app/domain/entities/restaurant.dart';
import 'package:food_store_app/domain/repositories/restaurant_repositroy.dart';

class SerachRestaurant {
  final RestaurantRepository repository;

  SerachRestaurant(this.repository);

  Future<Either<Failure, List<Restaurant>>> execute(String query) {
    return repository.searchRestaurant(query);
  }
}
