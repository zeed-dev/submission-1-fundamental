import 'package:food_store_app/domain/repositories/restaurant_repositroy.dart';

class GetFavoriteStatus {
  final RestaurantRepository repository;

  GetFavoriteStatus(this.repository);

  Future<bool> execute(String id) {
    return repository.isAddedToFavorite(id);
  }
}
