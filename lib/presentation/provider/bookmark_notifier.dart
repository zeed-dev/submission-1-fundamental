import 'package:flutter/widgets.dart';
import 'package:food_store_app/domain/entities/restaurant_detail.dart';

class BookmarkNotifer extends ChangeNotifier {
  List<RestaurantDetail> _bookmark = [];

  List<RestaurantDetail> get bookmark => _bookmark;

  set bookmark(List<RestaurantDetail> bookmark) {
    _bookmark = bookmark;
    notifyListeners();
  }

  setRestaurant(RestaurantDetail restaurant) {
    if (!isBookmark(restaurant)) {
      _bookmark.add(restaurant);
    } else {
      _bookmark.removeWhere((element) => element.id == restaurant.id);
    }
    notifyListeners();
  }

  isBookmark(RestaurantDetail restaurant) {
    var index = _bookmark.indexWhere((element) => element.id == restaurant.id);

    if (index == -1) {
      return false;
    } else {
      return true;
    }
  }
}
