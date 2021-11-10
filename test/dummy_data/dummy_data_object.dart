import 'package:food_store_app/data/model/restaurant_table.dart';
import 'package:food_store_app/domain/entities/restaurant.dart';

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

// final testMovieDetail = MovieDetail(
//   adult: false,
//   backdropPath: 'backdropPath',
//   genres: [Genre(id: 1, name: 'Action')],
//   id: 1,
//   originalTitle: 'originalTitle',
//   overview: 'overview',
//   posterPath: 'posterPath',
//   releaseDate: 'releaseDate',
//   runtime: 120,
//   title: 'title',
//   voteAverage: 1,
//   voteCount: 1,
// );

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

// final testRestaurantMap = {
//   "id": "dy62fuwe6w8kfw1e867",
//   "name": "name",
//   "description": "description",
//   "pictureId": "pictureId",
//   "city": "city",
//   "rating": "rating",
// };
