import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final int id;
  final String image;
  final String name;
  final String description;
  final String icon;

  Category({this.id, this.image, this.name, this.description, this.icon});

  @override
  List<Object> get props => [id, name, description, image, icon];

  Category copyWith(
      {String image, String name, String description, String icon}) {
    return Category(
        id: id ?? this.id,
        image: image ?? this.image,
        name: name ?? this.name,
        description: description ?? this.description,
        icon: icon ?? this.icon);
  }

  static Category fromJson(dynamic json) {
    final data = json['consolidated_weather'][0];
    return Category(name: data['name'], description: data['name']);
  }
}
