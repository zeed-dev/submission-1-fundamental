import 'package:food_store_app/data/datasource/db/database_helper.dart';
import 'package:food_store_app/data/datasource/restaurant_local_data_source.dart';
import 'package:food_store_app/data/datasource/restaurant_remote_data_source.dart';
import 'package:food_store_app/data/repositories/restaurant_repositroy_impl.dart';
import 'package:food_store_app/domain/repositories/restaurant_repositroy.dart';
import 'package:food_store_app/domain/usecases/add_review.dart';
import 'package:food_store_app/domain/usecases/get_bookmark_restaurant.dart';
import 'package:food_store_app/domain/usecases/get_bookmark_status.dart';
import 'package:food_store_app/domain/usecases/get_restaurant.dart';
import 'package:food_store_app/domain/usecases/get_restaurant_detail.dart';
import 'package:food_store_app/domain/usecases/remove_bookmark.dart';
import 'package:food_store_app/domain/usecases/save_bookmark.dart';
import 'package:food_store_app/domain/usecases/search_restaurant.dart';
import 'package:food_store_app/presentation/provider/bookmark_notifier.dart';
import 'package:food_store_app/presentation/provider/restaurant_detail_notifier.dart';
import 'package:food_store_app/presentation/provider/restaurant_notifer.dart';
import 'package:food_store_app/presentation/provider/search_restaurant_notifier.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void init() {
  getIt.registerFactory(
    () => RestaurantNotifier(
      getRestaurant: getIt(),
    ),
  );
  getIt.registerFactory(
    () => RestaurantDetailNotifier(
      getRestaurantDetail: getIt(),
      addReview: getIt(),
      saveRestaurant: getIt(),
      getBookmarkStatus: getIt(),
      removeBookmark: getIt(),
    ),
  );
  getIt.registerFactory(
    () => SearechRestaurantNotifier(
      serachRestaurant: getIt(),
    ),
  );
  getIt.registerFactory(
    () => BookmarkNotifier(
      getBookmarkRestaurant: getIt(),
    ),
  );

  getIt.registerLazySingleton(() => GetRestaurant(getIt()));
  getIt.registerLazySingleton(() => GetRestaurantDetail(getIt()));
  getIt.registerLazySingleton(() => SerachRestaurant(getIt()));
  getIt.registerLazySingleton(() => AddReview(getIt()));
  getIt.registerLazySingleton(() => SaveRestaurant(getIt()));
  getIt.registerLazySingleton(() => GetBookmarkStatus(getIt()));
  getIt.registerLazySingleton(() => RemoveBookmark(getIt()));
  getIt.registerLazySingleton(() => GetBookmarkRestaurant(getIt()));

  getIt.registerLazySingleton<RestaurantRepository>(
    () => RestaurantRepositoryImpl(
      restaurantRemoteDataSource: getIt(),
      restaurantLocalDataSource: getIt(),
    ),
  );

  getIt.registerLazySingleton<RestaurantRemoteDataSource>(
    () => RestaurantRemoteDataSourceImpl(
      client: getIt(),
    ),
  );

  getIt.registerLazySingleton<RestaurantLocalDataSource>(
    () => RestaurantLocalDataSourceImpl(
      databaseHelper: getIt(),
    ),
  );

  getIt.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  getIt.registerLazySingleton(() => http.Client());
}
