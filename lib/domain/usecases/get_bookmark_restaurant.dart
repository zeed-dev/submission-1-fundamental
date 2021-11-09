import 'package:dartz/dartz.dart';
import 'package:food_store_app/common/failure.dart';
import 'package:food_store_app/domain/entities/restaurant.dart';
import 'package:food_store_app/domain/repositories/restaurant_repositroy.dart';

class GetBookmarkRestaurant {
  final RestaurantRepository repository;

  GetBookmarkRestaurant(this.repository);

  Future<Either<Failure, List<Restaurant>>> execute() {
    return repository.getBookmarkRestaurant();
  }
}
