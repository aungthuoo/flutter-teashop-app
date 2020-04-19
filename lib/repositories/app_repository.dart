
import 'package:http/http.dart' as http;
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

  Future<Post> fetchPost(int id) async {

    Map<String, dynamic> result = await parseJsonFromAssets('assets/data/post.json');
    return Post(
      id: result['id'],
      name: result['name'],
      description: result['description'],
      image: result['image'],
      currency_unit: result['currency_unit'],
      amount_unit: result['amount_unit'],
      price: result['price'],
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
