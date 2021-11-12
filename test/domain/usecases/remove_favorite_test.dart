import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food_store_app/domain/usecases/remove_favorite.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_data_object.dart';
import '../../helper/test_helper.mocks.dart';

void main() {
  late RemoveFavorite usecase;
  late MockRestaurantRepository mockRestaurantRepository;

  setUp(() {
    mockRestaurantRepository = MockRestaurantRepository();
    usecase = RemoveFavorite(mockRestaurantRepository);
  });

  test('should remove favorite restaurant from repository', () async {
    // arrange
    when(mockRestaurantRepository.removeFavorite(testRestaurantDetail))
        .thenAnswer((_) async => Right('Removed from Favorite'));
    // act
    final result = await usecase.execute(testRestaurantDetail);
    // assert
    verify(mockRestaurantRepository.removeFavorite(testRestaurantDetail));
    expect(result, Right('Removed from Favorite'));
  });
}
