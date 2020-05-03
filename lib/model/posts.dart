import 'package:equatable/equatable.dart';
import './post.dart';
import 'category.dart';
import 'flash_post.dart';

class Posts extends Equatable {
  final List<Category> sliders;
  final List<Category> categories;
  final List<Post> most_orders;
  final FlashPost flash_items;
  final List<Post> featured_items;
  final List<Post> items;

  Posts({this.sliders, this.categories, this.most_orders, this.flash_items, this.featured_items, this.items});

  @override
  List<Object> get props => [sliders, flash_items, featured_items, categories, most_orders, items];

  Posts copyWith({List<Category> sliders, List<Category> categories, FlashPost flash_items, List<Post> featured_items, List<Post> most_orders, List<Post> items}) {
    return Posts(
      sliders: sliders ?? this.sliders, 
      categories: categories ?? this.categories, 
      featured_items: featured_items ?? this.featured_items, 
      flash_items: flash_items ?? this.flash_items, 
      most_orders: most_orders ?? this.most_orders, 
      items: items ?? this.items);
  }
}
