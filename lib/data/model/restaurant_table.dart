import 'package:equatable/equatable.dart';
import 'package:food_store_app/domain/entities/restaurant.dart';
import 'package:food_store_app/domain/entities/restaurant_detail.dart';

class RestaurantTable extends Equatable {
  RestaurantTable({
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

  factory RestaurantTable.fromEntity(RestaurantDetail restaurant) =>
      RestaurantTable(
        id: restaurant.id,
        name: restaurant.name,
        description: restaurant.description,
        pictureId: restaurant.pictureId,
        city: restaurant.city,
        rating: restaurant.rating,
      );

  factory RestaurantTable.fromMap(Map<String, dynamic> map) => RestaurantTable(
        id: map["id"],
        name: map["name"],
        description: map["description"],
        pictureId: map["pictureId"],
        city: map["city"],
        rating: double.tryParse(map["rating"])!,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "pictureId": pictureId,
        "city": city,
        "rating": rating,
      };

  Restaurant toEntity() => Restaurant.bookmark(
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
