import 'package:flutter/widgets.dart';
import 'package:food_store_app/common/state_enum.dart';
import 'package:food_store_app/domain/entities/restaurant_detail.dart';
import 'package:food_store_app/domain/usecases/add_review.dart';
import 'package:food_store_app/domain/usecases/get_bookmark_status.dart';
import 'package:food_store_app/domain/usecases/get_restaurant_detail.dart';
import 'package:food_store_app/domain/usecases/remove_bookmark.dart';
import 'package:food_store_app/domain/usecases/save_bookmark.dart';

class RestaurantDetailNotifier extends ChangeNotifier {
  static const bookmarkAddSuccessMessage = "Added to Bookmark";
  static const bookmarkRemoveSuccessMessage = "Removed from Bookmark";

  late RestaurantDetail _restaurantDetail;
  RestaurantDetail get restaurantDetail => _restaurantDetail;

  RequestState _restauranDetailtState = RequestState.Empty;
  RequestState get restaurantDetailState => _restauranDetailtState;

  String _message = '';
  String get message => _message;

  final GetRestaurantDetail getRestaurantDetail;
  final AddReview addReview;
  final SaveRestaurant saveRestaurant;
  final GetBookmarkStatus getBookmarkStatus;
  final RemoveBookmark removeBookmark;

  RestaurantDetailNotifier({
    required this.getRestaurantDetail,
    required this.addReview,
    required this.saveRestaurant,
    required this.getBookmarkStatus,
    required this.removeBookmark,
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

  bool _isAddedtoBookmark = false;
  bool get isAddedToBookmark => _isAddedtoBookmark;

  Future<void> loadBookmarkStatus(String id) async {
    final result = await getBookmarkStatus.execute(id);
    _isAddedtoBookmark = result;
    notifyListeners();
  }

  Future<void> removeFromBookmark(RestaurantDetail restaurant) async {
    final result = await removeBookmark.execute(restaurant);

    result.fold((failure) async {
      _bookmarkMessage = failure.message;
    }, (successMsg) {
      _bookmarkMessage = successMsg;
    });

    await loadBookmarkStatus(restaurant.id);
  }
}
