import 'package:equatable/equatable.dart';
import 'package:food_store_app/domain/entities/drink.dart';

class Menus extends Equatable {
  Menus({
    required this.foods,
    required this.drinks,
  });

  final List<Drink> foods;
  final List<Drink> drinks;

  factory Menus.fromJson(Map<String, dynamic> json) => Menus(
        foods: List<Drink>.from(json["foods"].map((x) => Drink.fromJson(x))),
        drinks: List<Drink>.from(json["drinks"].map((x) => Drink.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "foods": List<dynamic>.from(foods.map((x) => x.toJson())),
        "drinks": List<dynamic>.from(drinks.map((x) => x.toJson())),
      };

  @override
  List<Object?> get props => [
        foods,
        drinks,
      ];
}
