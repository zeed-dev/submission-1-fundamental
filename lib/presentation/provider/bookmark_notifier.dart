import 'package:flutter/widgets.dart';
import 'package:food_store_app/data/model/restaurant_model.dart';

class BookmarkNotifer extends ChangeNotifier {
  List<RestaurantModel> _bookmark = [];

  List<RestaurantModel> get bookmark => _bookmark;

  set bookmark(List<RestaurantModel> bookmark) {
    _bookmark = bookmark;
    notifyListeners();
  }

  setRestaurant(RestaurantModel restaurant) {
    if (!isBookmark(restaurant)) {
      _bookmark.add(restaurant);
    } else {
      _bookmark.removeWhere((element) => element.id == restaurant.id);
    }
    notifyListeners();
  }

  isBookmark(RestaurantModel restaurant) {
    var index = _bookmark.indexWhere((element) => element.id == restaurant.id);

    if (index == -1) {
      return false;
    } else {
      return true;
    }
  }
}
