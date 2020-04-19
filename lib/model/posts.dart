import 'package:equatable/equatable.dart';
import './post.dart';
import 'category.dart';

class Posts extends Equatable {
  final List<Category> categories;
  final List<Post> most_orders;
  final List<Post> featured_items;
  final List<Post> items;

  Posts({this.categories, this.most_orders, this.featured_items, this.items});

  @override
  List<Object> get props => [categories, most_orders, items];

  Posts copyWith({List<Category> sliders, List<Category> categories, List<Post> featured_items, List<Post> most_orders, List<Post> items}) {
    return Posts(
        categories: categories ?? this.categories, featured_items: featured_items ?? this.featured_items, most_orders: most_orders ?? this.most_orders, items: items ?? this.items);
  }
}
