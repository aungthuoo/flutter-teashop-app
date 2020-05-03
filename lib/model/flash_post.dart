import './post.dart';
import 'package:equatable/equatable.dart';

class FlashPost extends Equatable {
  final String caption;
  final String hour;
  final String minute;
  final String second;
  final List<Post> items; 

  FlashPost(
      {
      this.caption,
      this.hour,
      this.minute,
      this.second,
      this.items});

  @override
  List<Object> get props => [caption, hour, minute, second, items];

  FlashPost copyWith(
      {
      String caption,
      String hour,
      String minute,
      String second,
      List<Post> items}) {
    return FlashPost(
        
        caption: caption ?? this.caption,
        hour: hour ?? this.hour,
        minute: minute ?? this.minute,
        second: second ?? this.second,
        items: items ?? this.items);
  }

  static Post fromJson(dynamic json) {
    final data = json['consolidated_weather'][0];
    return Post(name: data['name'], description: data['name']);
  }
}
