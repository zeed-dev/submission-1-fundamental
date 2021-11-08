import 'package:flutter/widgets.dart';
import 'package:food_store_app/common/state_enum.dart';
import 'package:food_store_app/domain/entities/restaurant.dart';
import 'package:food_store_app/domain/usecases/search_restaurant.dart';

class SearechRestaurantNotifier extends ChangeNotifier {
  var _serach = <Restaurant>[];
  List<Restaurant> get serach => _serach;

  RequestState _serachState = RequestState.Empty;
  RequestState get serachState => _serachState;

  String _message = '';
  String get message => _message;

  final SerachRestaurant serachRestaurant;

  SearechRestaurantNotifier({required this.serachRestaurant});

  Future<void> fetchSearchRestaurant(String query) async {
    final result = await serachRestaurant.execute(query);

    result.fold((failure) {
      _serachState = RequestState.Error;
      _message = failure.message;
      notifyListeners();
    }, (data) {
      _serachState = RequestState.Loaded;
      _serach = data;
      notifyListeners();
    });
  }
}
