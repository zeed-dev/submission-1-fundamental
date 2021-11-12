import 'package:food_store_app/data/datasource/db/database_helper.dart';
import 'package:food_store_app/data/datasource/restaurant_local_data_source.dart';
import 'package:food_store_app/data/datasource/restaurant_remote_data_source.dart';
import 'package:food_store_app/data/repositories/restaurant_repositroy_impl.dart';
import 'package:food_store_app/domain/repositories/restaurant_repositroy.dart';
import 'package:food_store_app/domain/usecases/add_review.dart';
import 'package:food_store_app/domain/usecases/get_favorite_restaurant.dart';
import 'package:food_store_app/domain/usecases/get_favorite_status.dart';
import 'package:food_store_app/domain/usecases/get_restaurant.dart';
import 'package:food_store_app/domain/usecases/get_restaurant_detail.dart';
import 'package:food_store_app/domain/usecases/remove_favorite.dart';
import 'package:food_store_app/domain/usecases/save_favorite.dart';
import 'package:food_store_app/domain/usecases/search_restaurant.dart';
import 'package:food_store_app/presentation/provider/favorite_notifier.dart';
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
      getFavoriteStatus: getIt(),
      removeFavorite: getIt(),
    ),
  );
  getIt.registerFactory(
    () => SearechRestaurantNotifier(
      serachRestaurant: getIt(),
    ),
  );
  getIt.registerFactory(
    () => FavoriteNotifier(
      getFavoriteRestaurant: getIt(),
    ),
  );

  getIt.registerLazySingleton(() => GetRestaurant(getIt()));
  getIt.registerLazySingleton(() => GetRestaurantDetail(getIt()));
  getIt.registerLazySingleton(() => SerachRestaurant(getIt()));
  getIt.registerLazySingleton(() => AddReview(getIt()));
  getIt.registerLazySingleton(() => SaveRestaurant(getIt()));
  getIt.registerLazySingleton(() => GetFavoriteStatus(getIt()));
  getIt.registerLazySingleton(() => RemoveFavorite(getIt()));
  getIt.registerLazySingleton(() => GetFavoriteRestaurant(getIt()));

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
