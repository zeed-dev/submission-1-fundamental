import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:food_store_app/common/exception.dart';
import 'package:food_store_app/data/datasource/restaurant_remote_data_source.dart';
import 'package:food_store_app/data/model/detail_restaurant_model.dart';
import 'package:food_store_app/data/model/restaurant_response.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../helper/test_helper.mocks.dart';
import '../json_reader.dart';

void main() {
  const BASE_URL = 'https://restaurant-api.dicoding.dev';

  late RestaurantRemoteDataSource dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = RestaurantRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('get restaurant', () {
    final tRestaurantList = RestaurantResponse.fromJson(
            json.decode(readJson('dummy_data/restaurant.json')))
        .restaurants;

    test('should return list of Restaurant Model when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/list'))).thenAnswer(
          (_) async =>
              http.Response(readJson('dummy_data/restaurant.json'), 200));
      // act
      final result = await dataSource.getRestaurant();
      // assert
      expect(result, equals(tRestaurantList));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/list')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getRestaurant();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get restaurant detail', () {
    final tId = "rqdv5juczeskfw1e867";
    final tRestaurantDetail = RestaurantDetailResponse.fromJson(
            json.decode(readJson('dummy_data/restaurant_detail.json')))
        .restaurant;

    test('should return restaurant detail when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/detail/$tId'))).thenAnswer(
          (_) async => http.Response(
              readJson('dummy_data/restaurant_detail.json'), 200));
      // act
      final result = await dataSource.getDetailRestaurant(tId);
      // assert
      expect(result, equals(tRestaurantDetail));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/detail/$tId')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getDetailRestaurant(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('search restaurant', () {
    final tSearchResult = RestaurantResponse.fromJson(json
            .decode(readJson('dummy_data/search_restaurant_melting_pot.json')))
        .restaurants;
    final tQuery = 'Melting Pot';

    test('should return list of restaurant when response code is 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/search?q=$tQuery')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/search_restaurant_melting_pot.json'), 200));
      // act
      final result = await dataSource.searchRestaurant(tQuery);
      // assert
      expect(result, tSearchResult);
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/search?q=$tQuery')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.searchRestaurant(tQuery);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}
