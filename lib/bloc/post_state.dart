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
  PostsLoaded({this.items, this.cartItems}) : super([items, cartItems]);

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

class PostLoaded extends PostState {
  final Post item;
  final List<Post> cartItems; 
  PostLoaded({this.item, this.cartItems}) : super([item, cartItems]);

  @override
  String toString() => 'PostLoaded';
}