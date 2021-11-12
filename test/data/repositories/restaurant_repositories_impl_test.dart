import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food_store_app/common/exception.dart';
import 'package:food_store_app/common/failure.dart';
import 'package:food_store_app/data/model/restaurant_model.dart';
import 'package:food_store_app/data/repositories/restaurant_repositroy_impl.dart';
import 'package:food_store_app/domain/entities/restaurant.dart';
import 'package:mockito/mockito.dart';

import '../../helper/test_helper.mocks.dart';

void main() {
  late RestaurantRepositoryImpl repository;
  late MockRestaurantRemoteDataSource mockRemoteDataSource;
  late MockRestaurantLocalDataSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockRestaurantRemoteDataSource();
    mockLocalDataSource = MockRestaurantLocalDataSource();
    repository = RestaurantRepositoryImpl(
      restaurantRemoteDataSource: mockRemoteDataSource,
      restaurantLocalDataSource: mockLocalDataSource,
    );
  });

  final tRestaurantModel = RestaurantModel(
    id: "dy62fuwe6w8kfw1e867",
    name: "Pangsit Express",
    description:
        "Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc,",
    pictureId: "43",
    city: "Surabaya",
    rating: 4.8,
  );

  final tRestaurant = Restaurant(
    id: "dy62fuwe6w8kfw1e867",
    name: "Pangsit Express",
    description:
        "Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc,",
    pictureId: "43",
    city: "Surabaya",
    rating: 4.8,
  );

  final tRestaurantModelList = <RestaurantModel>[tRestaurantModel];
  final tRestaurantList = <Restaurant>[tRestaurant];

  group('Restaurant', () {
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getRestaurant())
          .thenAnswer((_) async => tRestaurantModelList);
      // act
      final result = await repository.getRestaurant();
      // assert
      verify(mockRemoteDataSource.getRestaurant());
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tRestaurantList);
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getRestaurant()).thenThrow(ServerException());
      // act
      final result = await repository.getRestaurant();
      // assert
      verify(mockRemoteDataSource.getRestaurant());
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getRestaurant())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getRestaurant();
      // assert
      verify(mockRemoteDataSource.getRestaurant());
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });
}
