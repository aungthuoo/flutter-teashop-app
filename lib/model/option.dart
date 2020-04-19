import 'package:equatable/equatable.dart';
import 'package:teashop/model/post.dart';

class Option extends Equatable {

  final int id;
  final String type;
  final int index;
  final String title;
  final int max_item;
  final int min_item;
  final int sorting;
  final int selected_id;
  final List<Post> children; 

  Option(
      {this.id,
      this.type,
      this.index,
      this.title,
      this.max_item,
      this.min_item,
      this.sorting,
      this.selected_id, 
      this.children});

  @override
  List<Object> get props => [id, type, index, title, max_item, min_item, sorting, selected_id, children];

  Option copyWith(
      {int id,
      String type,
      int index,
      String title,
      int max_item,
      int min_item,
      int sorting,
      int selected_id,
      List<Post> children}) {
    return Option(
        id: id ?? this.id,
        type: type ?? this.type,
        index: index ?? this.index,
        title: title ?? this.title,
        max_item: max_item ?? this.max_item,
        min_item: min_item ?? this.min_item,
        sorting: sorting ?? this.sorting,
        selected_id: selected_id ?? this.selected_id,
        children: children ?? this.children);
  }

  static Post fromJson(dynamic json) {
    final data = json['consolidated_weather'][0];
    return Post(name: data['name'], description: data['name']);
  }
}
