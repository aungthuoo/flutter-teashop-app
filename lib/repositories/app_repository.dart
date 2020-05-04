
import 'package:http/http.dart' as http;
import 'package:ecommerce/model/flash_post.dart';
import 'package:ecommerce/model/image.dart';
import 'package:ecommerce/model/option.dart';
import '../model/category.dart';
import '../model/post.dart';
import '../model/posts.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class DBModel {
  final String _url = 'https://softwarezay.com/api/v1/';
  //final String _url = 'https://chectchin.com/api/v1/';
  //final String _url = 'https://fb3db7a6.ngrok.io/api/v1/';
}

class AppRepository extends DBModel {

  Future<Map<String, dynamic>> parseJsonFromAssets(String assetsPath) async {
    print('--- Parse json from: $assetsPath');
    return rootBundle.loadString(assetsPath)
        .then((jsonStr) => jsonDecode(jsonStr));
  }


  Future<Posts> fetchPosts(int id) async {

    Map<String, dynamic> result = await parseJsonFromAssets('assets/data/posts.json');
    return Posts(
        sliders: result['sliders'].map<Category>((item) {
          return Category(
            id: item['id'],
            name: item['name'],
            description: item['description'],
            icon:  item['icon'],
            image: item['image'],
          );
        }).toList(),
        most_orders: result['most_orders'].map<Post>((item) {
          return Post(
            id: item['id'],
            name: item['name'],
            description: item['description'],
            image: item['image'],
          );
        }).toList(),
        categories: result['categories'].map<Category>((item) {
          return Category(
            id: item['id'],
            name: item['name'],
            description: item['description'],
            icon:  item['icon'],
            image: item['image'],
          );
        }).toList(),
        flash_items:  FlashPost(
            caption: 'Flash Sales', 
            hour: "15", 
            minute: "30",
            second: "15",
            items:  result['flash_items'].map<Post>((item) {
              return Post(
                id: item['id'],
                name: item['name'],
                description: item['description'],
                image: item['image'],
                currency_unit: item['currency_unit'],
                amount_unit: item['amount_unit'],
                price: item['price'],
              );
            }).toList(),
          
        ),
        featured_items: result['featured_items'].map<Post>((item) {
          return Post(
            id: item['id'],
            name: item['name'],
            description: item['description'],
            image: item['image'],
            currency_unit: item['currency_unit'],
            amount_unit: item['amount_unit'],
            price: item['price'],
          );
        }).toList(),
      
        items: result['items'].map<Post>((item) {
          return Post(
            id: item['id'],
            name: item['name'],
            description: item['description'],
            image: item['image'],
            currency_unit: item['currency_unit'],
            amount_unit: item['amount_unit'],
            price: item['price'],
          );
        }).toList(),
        
      );


  }



  Future<Posts> fetchFlashPosts(int id) async {
    Map<String, dynamic> result = await parseJsonFromAssets('assets/data/posts.json');
    return Posts(
        
        flash_items:  FlashPost(
            caption: 'Flash Sales', 
            hour: "15", 
            minute: "30",
            second: "15",
            items:  result['flash_items'].map<Post>((item) {
              return Post(
                id: item['id'],
                name: item['name'],
                description: item['description'],
                image: item['image'],
                currency_unit: item['currency_unit'],
                amount_unit: item['amount_unit'],
                price: item['price'],
              );
            }).toList(),
        ),  
      );
  }




  Future<Posts> fetchPostsByCategory(int id) async {
    String fileName = 'category${id}.json'; 
    Map<String, dynamic> result = await parseJsonFromAssets('assets/data/$fileName');

    return Posts(
        flash_items:  FlashPost(
            caption: 'Cagegory - ', 
            items:  result['items'].map<Post>((item) {
              return Post(
                id: item['id'],
                name: item['name'],
                description: item['description'],
                image: item['image'],
                currency_unit: item['currency_unit'],
                amount_unit: item['amount_unit'],
                price: item['price'],
              );
            }).toList(),
        ),  
      );
  }





  Future<List<Post>> fetchSearchPosts(String searchString) async {
    Map<String, dynamic> result = await parseJsonFromAssets('assets/data/search.json');
    return  result['items'].map<Post>((item) {
      return Post(
        id: item['id'],
        name: item['name'],
        description: item['description'],
        image: item['image'],
        currency_unit: item['currency_unit'],
        amount_unit: item['amount_unit'],
        qty: item['qty'],
        price: item['price'],
        
      );
    }).toList();
      
  }



  Future<List<Post>> fetchWishPosts(String searchString) async {
    Map<String, dynamic> result = await parseJsonFromAssets('assets/data/wish_items.json');
    return  result['items'].map<Post>((item) {
      return Post(
        id: item['id'],
        name: item['name'],
        description: item['description'],
        image: item['image'],
        currency_unit: item['currency_unit'],
        amount_unit: item['amount_unit'],
        qty: item['qty'],
        price: item['price'],
        
      );
    }).toList();
      
  }




  Future<Posts> fetchOrderItems(int id) async {
    Map<String, dynamic> result = await parseJsonFromAssets('assets/data/order_items.json');
    return Posts(
        
        items: result['items'].map<Post>((item) {
          return Post(
            id: item['id'],
            name: item['name'],
            description: item['description'],
            image: item['image'],
            currency_unit: item['currency_unit'],
            amount_unit: item['amount_unit'],
            qty: item['qty'],
            price: item['price'],
            options : item['options'].map<Option>((option) {
              return Option(
                id: option['id'],
                type: option['type'],
                index: option['index'],
                title: option['title'],
                max_item: option['max_item'],
                min_item: option['min_item'],
                sorting: option['sorting'],
                selected_id: option['selected_id'],
                children: option['children'].map<Post>((child) {
                  return Post(
                    id: child['id'],
                    name: child['name'],
                    description: child['description'],
                    image: child['image'],
                    currency_unit: child['currency_unit'],
                    amount_unit: child['amount_unit'],
                    price: child['price'],
                    is_selected: child['is_selected'],
                  );
                }).toList(),
              );
            }).toList(),
          );
        }).toList(),
        
      );
  }

  Future<Post> fetchPost(int id) async {
    String fileName = 'post${id}.json'; 
    Map<String, dynamic> item = await parseJsonFromAssets('assets/data/$fileName');
    return Post(
      id: item['id'],
      name: item['name'],
      description: item['description'],
      image: item['image'],
      currency_unit: item['currency_unit'],
      amount_unit: item['amount_unit'],
      qty: item['qty'],
      price: item['price'],

      images : item['images'].map<Image>((option) {
        return Image(
          id: option['id'],
          name: option['name'],
          description: option['description'],
          icon: option['icon'],
          image: option['image']
        );
      }).toList(),
      options : item['options'].map<Option>((option) {
        return Option(
          id: option['id'],
          type: option['type'],
          index: option['index'],
          title: option['title'],
          max_item: option['max_item'],
          min_item: option['min_item'],
          sorting: option['sorting'],
          selected_id: option['selected_id'],
          children: option['children'].map<Post>((child) {
            return Post(
              id: child['id'],
              name: child['name'],
              description: child['description'],
              image: child['image'],
              currency_unit: child['currency_unit'],
              amount_unit: child['amount_unit'],
              price: child['price'],
              is_selected: child['is_selected'],
            );
          }).toList(),
        );
      }).toList(),
    );

  }

  Future<String> getToken() async {
    /// read from keystore/keychain
    //String value = (await storage.read(key: 'loginToken'));
    //await Future.delayed(Duration(seconds: 1));
    String value = '';
    return value ?? '';
  }
}
