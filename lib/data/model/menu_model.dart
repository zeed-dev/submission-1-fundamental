import 'package:food_store_app/data/model/drink_model.dart';
import 'package:food_store_app/domain/entities/menu.dart';

class MenusModel {
  MenusModel({
    required this.foods,
    required this.drinks,
  });

  List<DrinkModel> foods;
  List<DrinkModel> drinks;

  factory MenusModel.fromJson(Map<String, dynamic> json) => MenusModel(
        foods: List<DrinkModel>.from(
            json["foods"].map((x) => DrinkModel.fromJson(x))),
        drinks: List<DrinkModel>.from(
            json["drinks"].map((x) => DrinkModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "foods": List<dynamic>.from(foods.map((x) => x.toJson())),
        "drinks": List<dynamic>.from(drinks.map((x) => x.toJson())),
      };

  Menus toEntity() {
    return Menus(
      foods: foods.map((e) => e.toEntity()).toList(),
      drinks: foods.map((e) => e.toEntity()).toList(),
    );
  }
}
