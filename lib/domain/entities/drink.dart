import 'package:equatable/equatable.dart';

class Drink extends Equatable {
  Drink({
    required this.name,
  });

  final String name;

  factory Drink.fromJson(Map<String, dynamic> json) => Drink(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };

  @override
  List<Object?> get props => [name];
}
