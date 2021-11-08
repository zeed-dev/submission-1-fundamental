import 'package:flutter/widgets.dart';
import 'package:food_store_app/common/state_enum.dart';
import 'package:food_store_app/domain/entities/restaurant_detail.dart';
import 'package:food_store_app/domain/usecases/add_review.dart';
import 'package:food_store_app/domain/usecases/get_restaurant_detail.dart';

class RestaurantDetailNotifier extends ChangeNotifier {
  late RestaurantDetail _restaurantDetail;
  RestaurantDetail get restaurantDetail => _restaurantDetail;

  RequestState _restauranDetailtState = RequestState.Empty;
  RequestState get restaurantDetailState => _restauranDetailtState;

  String _message = '';
  String get message => _message;

  final GetRestaurantDetail getRestaurantDetail;
  final AddReview addReview;

  RestaurantDetailNotifier({
    required this.getRestaurantDetail,
    required this.addReview,
  });

  Future<void> fetchDetailRestaurant(String id) async {
    _restauranDetailtState = RequestState.Loading;
    notifyListeners();

    final result = await getRestaurantDetail.execute(id);

    result.fold((failure) {
      _restauranDetailtState = RequestState.Error;
      _message = failure.message;
      notifyListeners();
    }, (data) {
      _restauranDetailtState = RequestState.Loaded;
      _restaurantDetail = data;
      notifyListeners();
    });
  }

  String _reviewMessage = '';
  String get reviewMessage => _reviewMessage;

  RequestState _reviewMessageState = RequestState.Empty;
  RequestState get reviewMessageState => _reviewMessageState;

  Future<void> postAddReview(String reviews, String name, String id) async {
    _reviewMessageState = RequestState.Loading;
    notifyListeners();

    final result = await addReview.execute(reviews, name, id);

    result.fold((failure) {
      _reviewMessageState = RequestState.Error;
      _message = failure.message;
      notifyListeners();
    }, (message) {
      _reviewMessageState = RequestState.Loaded;
      _reviewMessage = message;
      notifyListeners();
    });
  }
}
