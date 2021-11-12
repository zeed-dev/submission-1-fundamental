import 'package:dartz/dartz.dart';
import 'package:food_store_app/common/failure.dart';
import 'package:food_store_app/domain/entities/restaurant_detail.dart';
import 'package:food_store_app/domain/repositories/restaurant_repositroy.dart';

class RemoveFavorite {
  final RestaurantRepository repository;

  RemoveFavorite(this.repository);

  Future<Either<Failure, String>> execute(RestaurantDetail restaurant) {
    return repository.removeFavorite(restaurant);
  }
}
