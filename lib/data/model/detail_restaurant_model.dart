import 'package:equatable/equatable.dart';
import 'package:food_store_app/data/model/categories_model.dart';
import 'package:food_store_app/data/model/custome_review_model.dart';
import 'package:food_store_app/data/model/menu_model.dart';
import 'package:food_store_app/domain/entities/restaurant_detail.dart';

class RestaurantDetailResponse extends Equatable {
  RestaurantDetailResponse({
    required this.error,
    required this.message,
    required this.restaurant,
  });

  final bool error;
  final String message;
  final RestaurantDetailModel restaurant;

  factory RestaurantDetailResponse.fromJson(Map<String, dynamic> json) =>
      RestaurantDetailResponse(
        error: json["error"],
        message: json["message"],
        restaurant: RestaurantDetailModel.fromJson(json["restaurant"]),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "restaurant": restaurant.toJson(),
      };

  @override
  List<Object?> get props => [
        error,
        message,
        restaurant,
      ];
}

class RestaurantDetailModel extends Equatable {
  RestaurantDetailModel({
    required this.id,
    required this.name,
    required this.description,
    required this.city,
    required this.address,
    required this.pictureId,
    required this.categories,
    required this.menus,
    required this.rating,
    required this.customerReviews,
  });

  final String id;
  final String name;
  final String description;
  final String city;
  final String address;
  final String pictureId;
  final List<CategoryModel> categories;
  final MenusModel menus;
  final double rating;
  final List<CustomerReviewModel> customerReviews;

  factory RestaurantDetailModel.fromJson(Map<String, dynamic> json) =>
      RestaurantDetailModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        city: json["city"],
        address: json["address"],
        pictureId: json["pictureId"],
        categories: List<CategoryModel>.from(
            json["categories"].map((x) => CategoryModel.fromJson(x))),
        menus: MenusModel.fromJson(json["menus"]),
        rating: json["rating"].toDouble(),
        customerReviews: List<CustomerReviewModel>.from(json["customerReviews"]
            .map((x) => CustomerReviewModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "city": city,
        "address": address,
        "pictureId": pictureId,
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
        "menus": menus.toJson(),
        "rating": rating,
        "customerReviews":
            List<dynamic>.from(customerReviews.map((x) => x.toJson())),
      };

  RestaurantDetail toEntity() => RestaurantDetail(
        id: id,
        name: name,
        description: description,
        city: city,
        address: address,
        pictureId: pictureId,
        categories: categories.map((e) => e.toEntity()).toList(),
        menus: menus.toEntity(),
        rating: rating,
        customerReviews: customerReviews.map((e) => e.toEntity()).toList(),
      );

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        city,
        address,
        pictureId,
        categories,
        menus,
        rating,
        customerReviews,
      ];
}
