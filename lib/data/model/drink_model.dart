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
}
