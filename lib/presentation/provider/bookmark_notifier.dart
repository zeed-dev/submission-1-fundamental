import 'package:flutter/widgets.dart';
import 'package:food_store_app/common/state_enum.dart';
import 'package:food_store_app/domain/entities/restaurant.dart';
import 'package:food_store_app/domain/usecases/get_bookmark_restaurant.dart';

class BookmarkNotifier extends ChangeNotifier {
  var _bookmarkRestaurant = <Restaurant>[];
  List<Restaurant> get bookmarkRestaurant => _bookmarkRestaurant;

  RequestState _bookmarkRestaurantState = RequestState.Empty;
  RequestState get bookmarkRestaurantState => _bookmarkRestaurantState;

  String _message = '';
  String get message => _message;

  final GetBookmarkRestaurant getBookmarkRestaurant;

  BookmarkNotifier({required this.getBookmarkRestaurant});

  Future<void> fetchBookmarkRestaurant() async {
    _bookmarkRestaurantState = RequestState.Loading;
    notifyListeners();

    final result = await getBookmarkRestaurant.execute();

    result.fold((fail) {
      _bookmarkRestaurantState = RequestState.Error;
      _message = fail.message;
      notifyListeners();
    }, (data) {
      _bookmarkRestaurantState = RequestState.Loaded;
      _bookmarkRestaurant = data;
      notifyListeners();
    });
  }
}
