import 'package:food_store_app/domain/repositories/restaurant_repositroy.dart';

class GetBookmarkStatus {
  final RestaurantRepository repository;

  GetBookmarkStatus(this.repository);

  Future<bool> execute(String id) {
    return repository.isAddedToBookmark(id);
  }
}
