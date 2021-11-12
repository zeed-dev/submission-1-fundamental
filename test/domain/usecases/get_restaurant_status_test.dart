import 'package:flutter_test/flutter_test.dart';
import 'package:food_store_app/domain/usecases/get_favorite_status.dart';
import 'package:mockito/mockito.dart';

import '../../helper/test_helper.mocks.dart';

void main() {
  late GetFavoriteStatus usecase;
  late MockRestaurantRepository mockRestaurantRepository;

  setUp(() {
    mockRestaurantRepository = MockRestaurantRepository();
    usecase = GetFavoriteStatus(mockRestaurantRepository);
  });

  test('should get favorite status from repository', () async {
    // arrange
    when(mockRestaurantRepository.isAddedToFavorite("rqdv5juczeskfw1e867"))
        .thenAnswer((_) async => true);
    // act
    final result = await usecase.execute("rqdv5juczeskfw1e867");
    // assert
    expect(result, true);
  });
}
