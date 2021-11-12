import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food_store_app/domain/usecases/get_restaurant_detail.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_data_object.dart';
import '../../helper/test_helper.mocks.dart';

void main() {
  late GetRestaurantDetail usecase;
  late MockRestaurantRepository mockRestaurantRepository;

  setUp(() {
    mockRestaurantRepository = MockRestaurantRepository();
    usecase = GetRestaurantDetail(mockRestaurantRepository);
  });

  final tId = "rqdv5juczeskfw1e867";

  test('should get restaurant detail from the repository', () async {
    // arrange
    when(mockRestaurantRepository.getDetailRestaurant(tId))
        .thenAnswer((_) async => Right(testRestaurantDetail));
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, Right(testRestaurantDetail));
  });
}
