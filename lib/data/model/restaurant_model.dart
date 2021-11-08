import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:food_store_app/domain/entities/restaurant.dart';

class RestaurantModel extends Equatable {
  RestaurantModel({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
  });

  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final double rating;

  factory RestaurantModel.fromJson(Map<String, dynamic> json) =>
      RestaurantModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        pictureId: json["pictureId"],
        city: json["city"],
        rating: json["rating"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "pictureId": pictureId,
        "city": city,
        "rating": rating,
      };

  Restaurant toEntity() => Restaurant(
        id: id,
        name: name,
        description: description,
        pictureId: pictureId,
        city: city,
        rating: rating,
      );

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        pictureId,
        city,
        rating,
      ];
}

List<Restaurant> restaurantsParse(String? data) {
  if (data == null) {
    return [];
  }

  final List restaurant = json.decode(data)["restaurants"];
  return restaurant.map((e) => Restaurant.fromJson(e)).toList();
}
