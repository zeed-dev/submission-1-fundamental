import 'package:flutter_test/flutter_test.dart';
import 'package:food_store_app/common/exception.dart';
import 'package:food_store_app/data/datasource/restaurant_local_data_source.dart';
import '../dummy_data/dummy_data_object.dart';
import '../helper/test_helper.mocks.dart';
import 'package:mockito/mockito.dart';

void main() {
  late RestaurantLocalDataSource dataSource;
  late MockDatabaseHelper mockDatabaseHelper;

  setUp(() {
    mockDatabaseHelper = MockDatabaseHelper();
    dataSource =
        RestaurantLocalDataSourceImpl(databaseHelper: mockDatabaseHelper);
  });

  group('save bookmark', () {
    test('should return success message when insert to database is success',
        () async {
      // arrange
      when(mockDatabaseHelper.insertBookmark(testRestaurantTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSource.insertBookmark(testRestaurantTable);
      // assert
      expect(result, 'Added to Bookmark');
    });

    test('should throw DatabaseException when insert to database is failed',
        () async {
      // arrange
      when(mockDatabaseHelper.insertBookmark(testRestaurantTable))
          .thenThrow(Exception());
      // act
      final call = dataSource.insertBookmark(testRestaurantTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('remove bookmark', () {
    test('should return success message when remove from database is success',
        () async {
      // arrange
      when(mockDatabaseHelper.removeRestaurant(testRestaurantTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSource.removeBookmark(testRestaurantTable);
      // assert
      expect(result, 'Removed from Bookmark');
    });

    test('should throw DatabaseException when remove from database is failed',
        () async {
      // arrange
      when(mockDatabaseHelper.removeRestaurant(testRestaurantTable))
          .thenThrow(Exception());
      // act
      final call = dataSource.removeBookmark(testRestaurantTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('Get Restaurant Detail By Id', () {
    final tId = "rqdv5juczeskfw1e867";

    test('should return Restaurant Detail Table when data is found', () async {
      // arrange
      when(mockDatabaseHelper.getRestaurantById(tId))
          .thenAnswer((_) async => testRestaurantMap);
      // act
      final result = await dataSource.getRestaurantById(tId);
      // assert
      expect(result, testRestaurantTable);
    });

    test('should return null when data is not found', () async {
      // arrange
      when(mockDatabaseHelper.getRestaurantById(tId))
          .thenAnswer((_) async => null);
      // act
      final result = await dataSource.getRestaurantById(tId);
      // assert
      expect(result, null);
    });
  });

  group('get bookmark restaurant', () {
    test('should return list of RestaurantTable from database', () async {
      // arrange
      when(mockDatabaseHelper.getBookmarkRestaurant())
          .thenAnswer((_) async => [testRestaurantMap]);
      // act
      final result = await dataSource.getBookmarkRestaurant();
      // assert
      expect(result, [testRestaurantTable]);
    });
  });
}
