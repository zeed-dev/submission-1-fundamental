import 'dart:convert';

import 'package:food_store_app/common/exception.dart';
import 'package:food_store_app/data/model/detail_restaurant_model.dart';
import 'package:food_store_app/data/model/restaurant_model.dart';
import 'package:food_store_app/data/model/restaurant_response.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

abstract class RestaurantRemoteDataSource {
  Future<List<RestaurantModel>> getRestaurant();
  Future<RestaurantDetailModel> getDetailRestaurant(String id);
}

class RestaurantRemoteDataSourceImpl implements RestaurantRemoteDataSource {
  static const BASE_URL = "https://restaurant-api.dicoding.dev";

  final http.Client client;

  RestaurantRemoteDataSourceImpl({required this.client});

  Logger _logger = Logger();

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

  @override
  Future<RestaurantDetailModel> getDetailRestaurant(String id) async {
    _logger.d("Fetch detail restaurant...");
    final response = await client.get(Uri.parse("$BASE_URL/detail/$id"));
    _logger.d(response.body);

    if (response.statusCode == 200) {
      return RestaurantDetailResponse.fromJson(json.decode(response.body))
          .restaurant;
    } else {
      throw ServerException();
    }
  }
}
