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

class SelectOptionItemEvent extends PostEvent {
  final int groupId;
  final int index;
  SelectOptionItemEvent(
      this.groupId, this.index)
      : super([groupId, index]);
}



class SelectCheckOptionItemEvent extends PostEvent {
  final int optionGroupId;
  final int optionItemIndex;
  final bool isSelected;
  SelectCheckOptionItemEvent(this.optionGroupId, this.optionItemIndex,
      this.isSelected)
      : super([optionGroupId, optionItemIndex, isSelected]);
}

class AddCartItemEvent extends PostEvent {
  final String note;
  final Post post; 
  AddCartItemEvent(this.note, this.post)
      : super([note, post]);
}

class SetCartItemsEvent extends PostEvent {
  final List<Post> cartItems;
  SetCartItemsEvent(this.cartItems)
      : super([cartItems]);
}


class FetchOrderItemsEvent extends PostEvent {
  final int id;
  FetchOrderItemsEvent({this.id}) : super([]);

  @override
  String toString() => 'FetchPostEvent';
}
