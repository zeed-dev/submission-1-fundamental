import 'package:dartz/dartz.dart';
import 'package:food_store_app/common/failure.dart';
import 'package:food_store_app/domain/entities/restaurant_detail.dart';
import 'package:food_store_app/domain/repositories/restaurant_repositroy.dart';

class GetRestaurantDetail {
  final RestaurantRepository repository;

  GetRestaurantDetail(this.repository);

  Future<Either<Failure, RestaurantDetail>> execute(String id) {
    return repository.getDetailRestaurant(id);
  }
}
