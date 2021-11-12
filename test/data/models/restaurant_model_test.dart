import 'package:flutter_test/flutter_test.dart';
import 'package:food_store_app/data/model/restaurant_model.dart';
import 'package:food_store_app/domain/entities/restaurant.dart';

void main() {
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

  test('should be a subclass of Restaurant entity', () async {
    final result = tRestaurantModel.toEntity();
    expect(result, tRestaurant);
  });
}
