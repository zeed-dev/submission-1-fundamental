import 'dart:io';

import 'package:food_store_app/common/exception.dart';
import 'package:food_store_app/data/datasource/restaurant_local_data_source.dart';
import 'package:food_store_app/data/datasource/restaurant_remote_data_source.dart';
import 'package:food_store_app/data/model/restaurant_table.dart';
import 'package:food_store_app/domain/entities/restaurant.dart';
import 'package:food_store_app/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:food_store_app/domain/entities/restaurant_detail.dart';
import 'package:food_store_app/domain/repositories/restaurant_repositroy.dart';
import 'package:logger/logger.dart';

class RestaurantRepositoryImpl implements RestaurantRepository {
  final RestaurantRemoteDataSource restaurantRemoteDataSource;
  final RestaurantLocalDataSource restaurantLocalDataSource;

  RestaurantRepositoryImpl({
    required this.restaurantRemoteDataSource,
    required this.restaurantLocalDataSource,
  });

  @override
  Future<Either<Failure, List<Restaurant>>> getRestaurant() async {
    try {
      final result = await restaurantRemoteDataSource.getRestaurant();

      return Right(result!.map((e) => e.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, RestaurantDetail>> getDetailRestaurant(
    String id,
  ) async {
    try {
      final result = await restaurantRemoteDataSource.getDetailRestaurant(id);

      return Right(result.toEntity());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<Restaurant>>> searchRestaurant(
    String query,
  ) async {
    try {
      final result = await restaurantRemoteDataSource.searchRestaurant(query);

      return Right(result!.map((e) => e.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, String>> addReview(
    String reviews,
    String name,
    String id,
  ) async {
    try {
      final result = await restaurantRemoteDataSource.addReview(
        reviews,
        name,
        id,
      );

      return Right(result);
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  Logger _logger = Logger();

  @override
  Future<Either<Failure, String>> saveBookmark(
      RestaurantDetail restaurant) async {
    try {
      final result = await restaurantLocalDataSource
          .insertBookmark(RestaurantTable.fromEntity(restaurant));

      _logger.d(result);

      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.toString()));
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<bool> isAddedToBookmark(String id) async {
    final result = await restaurantLocalDataSource.getRestaurantById(id);
    return result != null;
  }

  @override
  Future<Either<Failure, String>> removeBookmark(
      RestaurantDetail restaurant) async {
    try {
      final result = await restaurantLocalDataSource.removeBookmark(
        RestaurantTable.fromEntity(restaurant),
      );

      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Restaurant>>> getBookmarkRestaurant() async {
    final result = await restaurantLocalDataSource.getBookmarkRestaurant();
    return Right(result.map((e) => e.toEntity()).toList());
  }
}
