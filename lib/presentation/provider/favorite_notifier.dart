import 'package:flutter/widgets.dart';
import 'package:food_store_app/common/state_enum.dart';
import 'package:food_store_app/domain/entities/restaurant.dart';
import 'package:food_store_app/domain/usecases/get_favorite_restaurant.dart';

class FavoriteNotifier extends ChangeNotifier {
  var _favoriteRestaurant = <Restaurant>[];
  List<Restaurant> get bookmarkRestaurant => _favoriteRestaurant;

  RequestState _favoriteRestaurantState = RequestState.Empty;
  RequestState get favoriteRestaurantState => _favoriteRestaurantState;

  String _message = '';
  String get message => _message;

  final GetFavoriteRestaurant getFavoriteRestaurant;

  FavoriteNotifier({required this.getFavoriteRestaurant});

  Future<void> fetchFavoriteRestaurant() async {
    _favoriteRestaurantState = RequestState.Loading;
    notifyListeners();

    final result = await getFavoriteRestaurant.execute();

    result.fold((fail) {
      _favoriteRestaurantState = RequestState.Error;
      _message = fail.message;
      notifyListeners();
    }, (data) {
      _favoriteRestaurantState = RequestState.Loaded;
      _favoriteRestaurant = data;
      notifyListeners();
    });
  }
}
