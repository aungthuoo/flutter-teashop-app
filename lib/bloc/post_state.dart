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
  PostsLoaded({this.items}) : super([items]);

  @override
  String toString() => 'PostsLoaded';
}


class PostLoaded extends PostState {
  final Post item;
  PostLoaded({this.item}) : super([item]);

  @override
  String toString() => 'PostLoaded';
}