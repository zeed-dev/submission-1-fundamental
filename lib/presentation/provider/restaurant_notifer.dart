import 'package:flutter/widgets.dart';
import 'package:food_store_app/common/state_enum.dart';
import 'package:food_store_app/domain/entities/restaurant.dart';
import 'package:food_store_app/domain/usecases/get_restaurant.dart';

class RestaurantNotifier extends ChangeNotifier {
  var _restaurant = <Restaurant>[];
  List<Restaurant> get restaurant => _restaurant;

  RequestState _restaurantState = RequestState.Empty;
  RequestState get restaurantState => _restaurantState;

  String _message = '';
  String get message => _message;

  RestaurantNotifier({
    required this.getRestaurant,
  });

  final GetRestaurant getRestaurant;

  Future<void> fetchRestaurant() async {
    _restaurantState = RequestState.Loading;
    notifyListeners();

    final result = await getRestaurant.execute();

    result.fold((failure) {
      _restaurantState = RequestState.Error;
      _message = failure.message;
      notifyListeners();
    }, (restaurant) {
      _restaurantState = RequestState.Loaded;
      _restaurant = restaurant;
      notifyListeners();
    });
  }
}
