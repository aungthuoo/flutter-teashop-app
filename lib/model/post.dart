import 'package:equatable/equatable.dart';

import 'option.dart';

class Post extends Equatable {
  final int id;
  final String image;
  final String name;
  final String description;
  final String currency_unit;
  final String amount_unit;
  final double price;
  final int rating;
  final bool is_selected; 
  final List<Option> options;  

  Post(
      {this.id,
      this.image,
      this.name,
      this.description,
      this.currency_unit,
      this.amount_unit,
      this.price,
      this.rating, this.is_selected, this.options});

  @override
  List<Object> get props => [id, name, description, image, price, rating, options];

  Post copyWith(
      {int id,
      String image,
      String name,
      String description,
      String currency_unit,
      String amount_unit,
      double price,
      int rating,
      bool is_selected, 
      List<Option> options }) {
    return Post(
        id: id ?? this.id,
        image: image ?? this.image,
        name: name ?? this.name,
        description: description ?? this.description,
        currency_unit: currency_unit ?? this.currency_unit,
        amount_unit: amount_unit ?? this.amount_unit,
        price: price ?? this.price,
        is_selected: is_selected ?? this.is_selected,
        rating: rating ?? this.rating,
        options: options ?? this.options);
  }

  static Post fromJson(dynamic json) {
    final data = json['consolidated_weather'][0];
    return Post(name: data['name'], description: data['name']);
  }
}
