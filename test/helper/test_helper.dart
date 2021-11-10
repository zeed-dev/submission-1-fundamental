import 'package:food_store_app/data/datasource/db/database_helper.dart';
import 'package:food_store_app/data/datasource/restaurant_local_data_source.dart';
import 'package:food_store_app/data/datasource/restaurant_remote_data_source.dart';
import 'package:food_store_app/domain/repositories/restaurant_repositroy.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([
  RestaurantRepository,
  RestaurantRemoteDataSource,
  RestaurantLocalDataSource,
  DatabaseHelper,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
