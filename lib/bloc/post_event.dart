part of 'post_bloc.dart';

abstract class PostEvent extends Equatable {
  //const OrderEvent();
  PostEvent([List props = const <dynamic>[]]) : super(props);
}

class FetchPostsEvent extends PostEvent {
  final int id;
  FetchPostsEvent(this.id) : super([id]);
}

class FetchDataEvent extends PostEvent {
  FetchDataEvent() : super([]);

  @override
  String toString() => 'FetchDataEvent';
}

class FetchPostEvent extends PostEvent {
  final int id;
  FetchPostEvent({this.id}) : super([]);

  @override
  String toString() => 'FetchPostEvent';
}
