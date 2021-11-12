import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food_store_app/domain/usecases/save_favorite.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_data_object.dart';
import '../../helper/test_helper.mocks.dart';

void main() {
  late SaveRestaurant usecase;
  late MockRestaurantRepository mockRestaurantRepository;

  setUp(() {
    mockRestaurantRepository = MockRestaurantRepository();
    usecase = SaveRestaurant(mockRestaurantRepository);
  });

  test('should save restaurant to the repository', () async {
    // arrange
    when(mockRestaurantRepository.saveFavorite(testRestaurantDetail))
        .thenAnswer((_) async => Right('Added to Favorite'));
    // act
    final result = await usecase.execute(testRestaurantDetail);
    // assert
    verify(mockRestaurantRepository.saveFavorite(testRestaurantDetail));
    expect(result, Right('Added to Favorite'));
  });
}
