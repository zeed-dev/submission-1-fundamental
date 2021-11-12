import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food_store_app/domain/entities/restaurant.dart';
import 'package:food_store_app/domain/usecases/get_restaurant.dart';
import 'package:mockito/mockito.dart';

import '../../helper/test_helper.mocks.dart';

void main() {
  late GetRestaurant usecase;
  late MockRestaurantRepository mockRestaurantRepository;

  setUp(() {
    mockRestaurantRepository = MockRestaurantRepository();
    usecase = GetRestaurant(mockRestaurantRepository);
  });

  final tRestaurant = <Restaurant>[];

  test('should get list of restaurant from the repository', () async {
    // arrange
    when(mockRestaurantRepository.getRestaurant())
        .thenAnswer((_) async => Right(tRestaurant));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(tRestaurant));
  });
}
