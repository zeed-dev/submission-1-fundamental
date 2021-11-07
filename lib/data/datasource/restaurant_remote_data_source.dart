import 'dart:convert';

import 'package:food_store_app/common/exception.dart';
import 'package:food_store_app/data/model/restaurant_model.dart';
import 'package:food_store_app/data/model/restaurant_response.dart';
import 'package:http/http.dart' as http;

abstract class RestaurantRemoteDataSource {
  Future<List<RestaurantModel>> getRestaurant();
}

class RestaurantRemoteDataSourceImpl implements RestaurantRemoteDataSource {
  static const BASE_URL = "https://restaurant-api.dicoding.dev";

  final http.Client client;

  RestaurantRemoteDataSourceImpl({required this.client});

  @override
  Future<List<RestaurantModel>> getRestaurant() async {
    final response = await client.get(Uri.parse("$BASE_URL/list"));

    if (response.statusCode == 200) {
      return RestaurantResponse.fromJson(
        json.decode(response.body),
      ).restaurants;
    } else {
      throw ServerException();
    }
  }
}
