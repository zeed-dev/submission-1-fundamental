import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food_store_app/domain/usecases/get_favorite_restaurant.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_data_object.dart';
import '../../helper/test_helper.mocks.dart';

void main() {
  late GetFavoriteRestaurant usecase;
  late MockRestaurantRepository mockRestaurantRepository;

  setUp(() {
    mockRestaurantRepository = MockRestaurantRepository();
    usecase = GetFavoriteRestaurant(mockRestaurantRepository);
  });

  test('should get list of restaurant from the repository', () async {
    // arrange
    when(mockRestaurantRepository.getFavoriteRestaurant())
        .thenAnswer((_) async => Right(testRestaurantList));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(testRestaurantList));
  });
}
