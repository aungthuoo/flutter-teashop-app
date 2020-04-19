import 'dart:async';

import 'package:bloc/bloc.dart';
import '../model/post.dart';
import '../model/posts.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../repositories/app_repository.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  AppRepository appRepository = new AppRepository();
  final http.Client httpClient;
  PostBloc({@required this.httpClient});


  @override
  PostState get initialState => PostInitial();

  @override
  Stream<PostState> mapEventToState(
    PostEvent event,
  ) async* {
    if (event is PostInitial) {
      // Outputting a state from the asynchronous generator
      yield PostLoading();

      //final orders = await restaurantRepository.fetchNewOrders(0, 20);
      //final tempOrders = await restaurantRepository.exchageHeaders(orders);
      //yield OrdersLoaded(id : 0, name: 'အော်ဒါအသစ်များ', orders: tempOrders);
    
    }else if (event is FetchPostsEvent) {
      print('FetchPostEvent fire');
      yield PostLoading();
      final items = await appRepository.fetchPosts(1);
      yield PostsLoaded(items: items);
    }else if (event is FetchPostEvent) {
      print('FetchDataEvent fire');
      yield PostLoading();
      final item = await appRepository.fetchPost(1);
      yield PostLoaded(item: item);
    
    
    }
  }
}
