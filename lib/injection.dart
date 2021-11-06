import 'package:food_store_app/data/datasource/restaurant_remote_data_source.dart';
import 'package:food_store_app/data/repositories/restaurant_repositroy_impl.dart';
import 'package:food_store_app/domain/repositories/restaurant_repositroy.dart';
import 'package:food_store_app/domain/usecases/get_restaurant.dart';
import 'package:food_store_app/presentation/provider/restaurant_notifer.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void init() {
  /// PROVIDERS
  getIt.registerFactory(() => RestaurantNotifier(getRestaurant: getIt()));

  /// USECASES
  getIt.registerLazySingleton(() => GetRestaurant(getIt()));

  /// RESPOSITORY
  getIt.registerLazySingleton<RestaurantRepository>(
      () => RestaurantRepositoryImpl(restaurantRemoteDataSource: getIt()));

  /// DATASOURCE
  getIt.registerLazySingleton<RestaurantRemoteDataSource>(
      () => RestaurantRemoteDataSourceImpl(client: getIt()));

  /// EXTERNAL
  getIt.registerLazySingleton(() => http.Client());
}
