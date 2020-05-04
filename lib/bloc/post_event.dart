part of 'post_bloc.dart';

abstract class PostEvent extends Equatable {
  //const OrderEvent();
  PostEvent([List props = const <dynamic>[]]) : super(props);
}

class FetchPostsEvent extends PostEvent {
  final int id;
  FetchPostsEvent(this.id) : super([id]);
}

class FetchFlashPostsEvent extends PostEvent {
  final int type; 
  final int id;
  final String caption; 
  final List<Post> cartItems; 
  FetchFlashPostsEvent(this.type, this.id, this.caption, this.cartItems) : super([type, id, caption, cartItems]);
}

class FetchPostsByCategoryEvent extends PostEvent {
  final int id;
  final String caption; 
  final List<Post> cartItems; 
  FetchPostsByCategoryEvent(this.id, this.caption, this.cartItems) : super([id, caption, cartItems]);
}

class FetchSearchPostsEvent extends PostEvent {
  final String searchString; 
  FetchSearchPostsEvent(this.searchString) : super([searchString]);
}



class FetchWishPostsEvent extends PostEvent {
  final String searchString; 
  FetchWishPostsEvent(this.searchString) : super([searchString]);
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
  final List<Post> cartItems; 
  final Posts posts; 
  AddCartItemEvent(this.note, this.post, this.cartItems, this.posts)
      : super([note, post, cartItems, posts]);
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
