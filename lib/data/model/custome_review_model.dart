import 'package:equatable/equatable.dart';
import 'package:food_store_app/domain/entities/customer_review.dart';

class CustomerReviewModel extends Equatable {
  CustomerReviewModel({
    required this.name,
    required this.review,
    required this.date,
  });

  final String name;
  final String review;
  final String date;

  factory CustomerReviewModel.fromJson(Map<String, dynamic> json) =>
      CustomerReviewModel(
        name: json["name"],
        review: json["review"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "review": review,
        "date": date,
      };

  CustomerReview toEntity() {
    return CustomerReview(
      name: name,
      review: review,
      date: date,
    );
  }

  @override
  List<Object?> get props => [
        name,
        review,
        date,
      ];
}
