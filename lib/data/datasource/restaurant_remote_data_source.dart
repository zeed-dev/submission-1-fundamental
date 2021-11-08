import 'dart:convert';

import 'package:food_store_app/common/exception.dart';
import 'package:food_store_app/data/model/detail_restaurant_model.dart';
import 'package:food_store_app/data/model/restaurant_model.dart';
import 'package:food_store_app/data/model/restaurant_response.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

abstract class RestaurantRemoteDataSource {
  Future<List<RestaurantModel>?> getRestaurant();
  Future<RestaurantDetailModel> getDetailRestaurant(String id);
  Future<List<RestaurantModel>?> searchRestaurant(String query);
  Future<String> addReview(String reviews, String name, String id);
}

class RestaurantRemoteDataSourceImpl implements RestaurantRemoteDataSource {
  static const BASE_URL = "https://restaurant-api.dicoding.dev";

  final http.Client client;

  RestaurantRemoteDataSourceImpl({required this.client});

  Logger _logger = Logger();

  @override
  Future<List<RestaurantModel>?> getRestaurant() async {
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
    final response = await client.get(Uri.parse("$BASE_URL/detail/$id"));

    if (response.statusCode == 200) {
      return RestaurantDetailResponse.fromJson(json.decode(response.body))
          .restaurant;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<RestaurantModel>?> searchRestaurant(String query) async {
    final response = await client.get(Uri.parse("$BASE_URL/search?q=$query"));

    if (response.statusCode == 200) {
      return RestaurantResponse.fromJson(
        json.decode(response.body),
      ).restaurants;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<String> addReview(
    String reviews,
    String name,
    String id,
  ) async {
    _logger.d("Add reviews...");
    String message = "";

    Map body = {
      "id": "$id",
      "name": "$name",
      "review": "$reviews",
    };

    final response = await client.post(
      Uri.parse("$BASE_URL/review"),
      body: json.encode(body),
      headers: {"Content-Type": "application/json"},
    );
    _logger.d(response.body);

    if (response.statusCode == 200) {
      message = json.decode(response.body)["message"];
      return message;
    } else {
      throw ServerException();
    }
  }
}
