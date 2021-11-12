import 'package:flutter/widgets.dart';
import 'package:food_store_app/common/state_enum.dart';
import 'package:food_store_app/domain/entities/restaurant_detail.dart';
import 'package:food_store_app/domain/usecases/add_review.dart';
import 'package:food_store_app/domain/usecases/get_favorite_status.dart';
import 'package:food_store_app/domain/usecases/get_restaurant_detail.dart';
import 'package:food_store_app/domain/usecases/remove_favorite.dart';
import 'package:food_store_app/domain/usecases/save_favorite.dart';

class RestaurantDetailNotifier extends ChangeNotifier {
  static const restaurantAddSuccessMessage = "Added to Favorite";
  static const restaurantRemoveSuccessMessage = "Removed from Favorite";

  late RestaurantDetail _restaurantDetail;
  RestaurantDetail get restaurantDetail => _restaurantDetail;

  RequestState _restauranDetailtState = RequestState.Empty;
  RequestState get restaurantDetailState => _restauranDetailtState;

  String _message = '';
  String get message => _message;

  final GetRestaurantDetail getRestaurantDetail;
  final AddReview addReview;
  final SaveRestaurant saveRestaurant;
  final GetFavoriteStatus getFavoriteStatus;
  final RemoveFavorite removeFavorite;

  RestaurantDetailNotifier({
    required this.getRestaurantDetail,
    required this.addReview,
    required this.saveRestaurant,
    required this.getFavoriteStatus,
    required this.removeFavorite,
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

  String _bookmarkMessage = '';
  String get bookmarkMessage => _bookmarkMessage;

  Future<void> addBookmark(RestaurantDetail restaurant) async {
    final result = await saveRestaurant.execute(restaurant);

    result.fold((failure) {
      _bookmarkMessage = failure.message;
    }, (successMsg) {
      _bookmarkMessage = successMsg;
    });

    await loadBookmarkStatus(restaurant.id);
  }

  bool _isAddedtoFavorite = false;
  bool get isAddedtoFavorite => _isAddedtoFavorite;

  Future<void> loadBookmarkStatus(String id) async {
    final result = await getFavoriteStatus.execute(id);
    _isAddedtoFavorite = result;
    notifyListeners();
  }

  Future<void> removeFromBookmark(RestaurantDetail restaurant) async {
    final result = await removeFavorite.execute(restaurant);

    result.fold((failure) async {
      _bookmarkMessage = failure.message;
    }, (successMsg) {
      _bookmarkMessage = successMsg;
    });

    await loadBookmarkStatus(restaurant.id);
  }
}
