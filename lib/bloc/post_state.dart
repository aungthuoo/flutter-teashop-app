part of 'post_bloc.dart';

abstract class PostState extends Equatable {
  //const OrderState();
  PostState([List props = const <dynamic>[]]) : super(props);
}

class PostInitial extends PostState {
  @override
  List<Object> get props => [];
}

class PostLoading extends PostState {}


class FetchError extends PostState {
  final String text;
  FetchError({this.text}) : super([]);
}



class PostError extends PostState {
  @override
  String toString() => 'PostError';
}



class PostsLoaded extends PostState {
  final Posts items;
  final List<Post> cartItems; 
  final int count; 
  PostsLoaded({this.items, this.cartItems, this.count}) : super([items, cartItems, count]);

  @override
  String toString() => 'PostsLoaded';
}


class FlashPostsLoaded extends PostState {
  final Posts items;
  final List<Post> cartItems; 
  final int count; 
  FlashPostsLoaded({this.items, this.cartItems, this.count}) : super([items, cartItems, count]);

  @override
  String toString() => 'PostsLoaded';
}

class CartLoaded extends PostState {
  final Header cartHeader; 
  final List<Post> cartItems; 
  CartLoaded({this.cartHeader, this.cartItems}) : super([cartHeader, cartItems]);

  @override
  String toString() => 'PostsLoaded';
}

class SearchLoaded extends PostState {
  final List<Post> items; 
  SearchLoaded({this.items}) : super([items]);

  @override
  String toString() => 'SearchLoaded';
}


class PopularListingLoaded extends PostState {
  final List<Post> items; 
  PopularListingLoaded({this.items}) : super([items]);

  @override
  String toString() => 'SearchLoaded';
}



class WishItemsLoaded extends PostState {
  final List<Post> items; 
  WishItemsLoaded({this.items}) : super([items]);

  @override
  String toString() => 'WishItemsLoaded';
}

class PostLoaded extends PostState {
  final Post item;
  final List<Post> cartItems; 
  PostLoaded({this.item, this.cartItems}) : super([item, cartItems]);

  @override
  String toString() => 'PostLoaded';
}