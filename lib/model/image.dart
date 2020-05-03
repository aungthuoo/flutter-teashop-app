import 'package:equatable/equatable.dart';

class Image extends Equatable {
  final int id;
  final String name;
  final String description;
  final String icon;
  final String image;

  Image(
      {this.id,
      this.name,
      this.description,
      this.icon,
      this.image});

  @override
  List<Object> get props => [id, name, description, icon, image];

  Image copyWith(
      {int id,
      String name,
      String description,
      String icon,
      String image}) {
    return Image(
        id: this.id,
        name: this.name,
        description: this.description,
        icon: this.icon, 
        image: this.image, 
    );
  }

  Image copyChildItemWith(
      {int id,
      String name,
      String description,
      String icon,
      String image}) {
    return Image(
        id: id ??  this.id,
        name: name ??  this.name,
        description: description ??  this.description,
        icon: icon ?? this.icon, 
        image: image ?? this.image, 
    );
  }


  static Image fromJson(dynamic json) {
    final data = json['consolidated_weather'][0];
    return Image(name: data['name'], description: data['name']);
  }
}
