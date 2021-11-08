import 'package:equatable/equatable.dart';
import 'package:food_store_app/domain/entities/drink.dart';

class DrinkModel extends Equatable {
  DrinkModel({
    required this.name,
  });

  final String name;

  factory DrinkModel.fromJson(Map<String, dynamic> json) => DrinkModel(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };

  Drink toEntity() {
    return Drink(name: name);
  }

  @override
  List<Object?> get props => [name];
}
