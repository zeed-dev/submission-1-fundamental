import 'package:dartz/dartz.dart';
import 'package:food_store_app/common/failure.dart';
import 'package:food_store_app/domain/repositories/restaurant_repositroy.dart';

class AddReview {
  final RestaurantRepository repository;

  AddReview(this.repository);

  Future<Either<Failure, String>> execute(
    String reviews,
    String name,
    String id,
  ) {
    return repository.addReview(reviews, name, id);
  }
}
