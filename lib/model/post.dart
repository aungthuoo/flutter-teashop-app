import 'package:equatable/equatable.dart';

import 'image.dart';
import 'option.dart';

class Post extends Equatable {
  final int id;
  final String image;
  final String name;
  final String description;
  final String currency_unit;
  final String amount_unit;
  final int qty; 
  final double price;
  final double total; 
  final int rating;
  final bool is_selected; 
  final String note; 
  final List<Image> images;  
  final List<Option> options;  

  Post(
      {this.id,
      this.image,
      this.name,
      this.description,
      this.currency_unit,
      this.amount_unit,
      this.qty, 
      this.price,
      this.total,
      this.note, 
      this.images,
      this.rating, this.is_selected, this.options});

  @override
  List<Object> get props => [id, name, description, image, qty, price, total, rating, note, options, images, is_selected];

  Post copyWith(
      {int qty,
      double tax,
      int stock_id,
      int type,
      String name,
      int optionGroupId,
      int optionGroupSelectedId,
      double total,
      double amount,
      List<Image> images, 
      String note,
      int index}) {
    return Post(
        id: this.id,
        image: this.image,
        name: this.name,
        description: this.description,
        currency_unit: this.currency_unit,
        amount_unit: this.amount_unit,
        qty: this.qty,
        price: this.price,
        is_selected:  this.is_selected,
        rating:  this.rating,
        total:  total ?? this.total,
        note: note ?? this.note,
        images: this.images.map<Image>((item) {
          return Image(
              id: item.id,
              name: item.name,
              description: item.description,
              icon: item.icon,
              image: item.image
          );
        }).toList(),
        options: this.options.map<Option>((rawOptionGroup) {
          return Option(
              id: rawOptionGroup.id,
              type: rawOptionGroup.type,
              title: rawOptionGroup.title,
              max_item: rawOptionGroup.max_item,
              min_item: rawOptionGroup.min_item,
              sorting: rawOptionGroup.sorting,
              selected_id: (rawOptionGroup.id == optionGroupId)
                  ? optionGroupSelectedId
                  : rawOptionGroup.selected_id,
              children:
                  rawOptionGroup.children.map<Post>((rawOptionGroup) {
                return Post(
                  id: rawOptionGroup.id,
                  name: rawOptionGroup.name,
                  qty: rawOptionGroup.qty,
                  price: rawOptionGroup.price,
                  total: rawOptionGroup.total,
                  description: rawOptionGroup.description,
                  is_selected: rawOptionGroup.is_selected,
                );
              }).toList());
        }).toList());
  }

  Post copyChildItemWith(
      {int optionGroupId,
      int optionItemIndex, 
      bool isSelected}) {
    return Post(
        id: this.id,
        image: this.image,
        name: this.name,
        description: this.description,
        currency_unit: this.currency_unit,
        amount_unit: this.amount_unit,
        qty: this.qty,
        price: this.price,
        is_selected:  this.is_selected,
        rating:  this.rating,
        total:  this.total,
        note: note ?? this.note,
        images: this.images,
        options: this.options.map<Option>((rawOptionGroup) {
          return Option(
              id: rawOptionGroup.id,
              type: rawOptionGroup.type,
              title: rawOptionGroup.title,
              max_item: rawOptionGroup.max_item,
              min_item: rawOptionGroup.min_item,
              sorting: rawOptionGroup.sorting,
              selected_id: rawOptionGroup.selected_id,
              
              children: rawOptionGroup.children
                  .asMap()
                  .map((i, element) => MapEntry(
                      i,
                      i == optionItemIndex
                          ? Post(
                              id: element.id,
                              image: element.image,
                              name: element.name,
                              description: element.description,
                              currency_unit: element.currency_unit,
                              amount_unit: element.amount_unit,
                              qty: element.qty,
                              price: element.price,
                              rating: element.rating,
                              total: element.total,
                              note: element.note,
                              is_selected: (rawOptionGroup.id == optionGroupId)
                                  ? isSelected
                                  : element.is_selected,
                              
                            )
                          : element))
                  .values
                  .toList()
              
              );
        }).toList());
  }


  static Post fromJson(dynamic json) {
    final data = json['consolidated_weather'][0];
    return Post(name: data['name'], description: data['name']);
  }
}
