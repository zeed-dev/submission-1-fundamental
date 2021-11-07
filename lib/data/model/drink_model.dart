import 'package:food_store_app/domain/entities/drink.dart';

class DrinkModel {
  DrinkModel({
    required this.name,
  });

  String name;

  factory DrinkModel.fromJson(Map<String, dynamic> json) => DrinkModel(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };

  Drink toEntity() {
    return Drink(name: name);
  }
}
