import 'dart:io';

import 'package:food_store_app/common/exception.dart';
import 'package:food_store_app/data/datasource/restaurant_remote_data_source.dart';
import 'package:food_store_app/domain/entities/restaurant.dart';
import 'package:food_store_app/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:food_store_app/domain/repositories/restaurant_repositroy.dart';

class RestaurantRepositoryImpl implements RestaurantRepository {
  final RestaurantRemoteDataSource restaurantRemoteDataSource;

  RestaurantRepositoryImpl({
    required this.restaurantRemoteDataSource,
  });

  @override
  Future<Either<Failure, List<Restaurant>>> getRestaurant() async {
    try {
      final result = await restaurantRemoteDataSource.getRestaurant();

      return Right(result.map((e) => e.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}
