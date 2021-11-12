import 'package:food_store_app/data/model/restaurant_table.dart';
import 'package:food_store_app/domain/entities/customer_review.dart';
import 'package:food_store_app/domain/entities/drink.dart';
import 'package:food_store_app/domain/entities/menu.dart';
import 'package:food_store_app/domain/entities/restaurant.dart';
import 'package:food_store_app/domain/entities/restaurant_detail.dart';
import 'package:food_store_app/domain/entities/category.dart' as categories;

final testRestaurant = Restaurant(
  id: "dy62fuwe6w8kfw1e867",
  name: "Pangsit Express",
  description:
      "Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc,",
  pictureId: "43",
  city: "Surabaya",
  rating: 4.8,
);

final testRestaurantList = [testRestaurant];

final testRestaurantDetail = RestaurantDetail(
  id: "dy62fuwe6w8kfw1e867",
  name: "name",
  description: "description",
  city: "Medan",
  address: "Jln. Pandeglang no 19",
  pictureId: "14",
  categories: [
    categories.Category(name: "Italia"),
    categories.Category(name: "Modern"),
  ],
  menus: Menus(
    foods: [
      Drink(name: "Paket rosemary"),
      Drink(name: "Toastie salmon"),
      Drink(name: "Bebek crepes"),
      Drink(name: "Salad lengkeng"),
    ],
    drinks: [
      Drink(name: "Es krim"),
      Drink(name: "Sirup"),
      Drink(name: "Jus apel"),
      Drink(name: "Jus jeruk"),
      Drink(name: "Coklat panas"),
      Drink(name: "Air"),
      Drink(name: "Jus alpukat"),
      Drink(name: "Jus mangga"),
      Drink(name: "Teh manis"),
      Drink(name: "Kopi espresso"),
      Drink(name: "Minuman soda"),
      Drink(name: "Jus tomat"),
    ],
  ),
  rating: 4.2,
  customerReviews: [
    CustomerReview(name: "ziad", review: "enak", date: "10 November 2021")
  ],
);

final testBookmarkRestaurant = Restaurant.bookmark(
  id: "dy62fuwe6w8kfw1e867",
  name: "Pangsit Express",
  description:
      "Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc,",
  pictureId: "43",
  city: "Surabaya",
  rating: 4.8,
);

final testRestaurantTable = RestaurantTable(
  id: "dy62fuwe6w8kfw1e867",
  name: "Pangsit Express",
  description:
      "Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc,",
  pictureId: "43",
  city: "Surabaya",
  rating: 4.8,
);

final testRestaurantMap = {
  "id": "dy62fuwe6w8kfw1e867",
  "name": "Pangsit Express",
  "description":
      "Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc,",
  "pictureId": "43",
  "city": "Surabaya",
  "rating": "4.8",
};
