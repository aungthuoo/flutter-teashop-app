import 'package:equatable/equatable.dart';

class Post extends Equatable {
  final int id;
  final String image;
  final String name;
  final String description;
  final String currency_unit;
  final String amount_unit;
  final double price;
  final int rating;

  Post(
      {this.id,
      this.image,
      this.name,
      this.description,
      this.currency_unit,
      this.amount_unit,
      this.price,
      this.rating});

  @override
  List<Object> get props => [id, name, description, image, price, rating];

  Post copyWith(
      {int id,
      String image,
      String name,
      String description,
      String currency_unit,
      String amount_unit,
      double price,
      int rating}) {
    return Post(
        id: id ?? this.id,
        image: image ?? this.image,
        name: name ?? this.name,
        description: description ?? this.description,
        currency_unit: currency_unit ?? this.currency_unit,
        amount_unit: amount_unit ?? this.amount_unit,
        price: price ?? this.price,
        rating: rating ?? this.rating);
  }

  static Post fromJson(dynamic json) {
    final data = json['consolidated_weather'][0];
    return Post(name: data['name'], description: data['name']);
  }
}
