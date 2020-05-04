import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ecommerce/model/header.dart';
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
      yield PostsLoaded(items: items, cartItems: [] );
    }else if (event is FetchFlashPostsEvent) {
      print('FetchFlashPostsEvent fire');
      yield PostLoading();
      final items = await appRepository.fetchFlashPosts(1);
      //yield FlashPostsLoaded(items: items, cartItems: event.cartItems );
      yield PostsLoaded(items: items, cartItems: event.cartItems );
    }else if (event is FetchPopularListingEvent) {
      print('FetchFlashPostsEvent fire');
      yield PostLoading();
      final items = await appRepository.fetchPopularListing(1);
      //yield FlashPostsLoaded(items: items, cartItems: event.cartItems );
      yield PostsLoaded(items: items, cartItems: event.cartItems );

    }else if (event is FetchAllPostsEvent) {
      print('FetchPostEvent fire');
      yield PostLoading();
      final items = await appRepository.fetchAllPosts(1);
      yield PostsLoaded(items: items, cartItems: event.cartItems );


    }else if (event is FetchPostsByCategoryEvent) {
      print('FetchPostsByCategoryEvent fire');
      yield PostLoading();
      final items = await appRepository.fetchPostsByCategory(event.id);
      //yield FlashPostsLoaded(items: items, cartItems: event.cartItems );
      yield PostsLoaded(items: items, cartItems: event.cartItems );
    }else if (event is FetchSearchPostsEvent) {
      print('FetchPostEvent fire');
      yield PostLoading();
      final items = await appRepository.fetchSearchPosts(event.searchString);
      //yield SearchLoaded(items: items);
      yield PostsLoaded(items: items, cartItems: event.cartItems );
    }else if (event is FetchWishPostsEvent) {
      print('FetchPostEvent fire');
      yield PostLoading();
      final items = await appRepository.fetchWishPosts(event.searchString);
      yield WishItemsLoaded(items: items);



    }else if (event is FetchOrderItemsEvent) {
      print('FetchPostEvent fire');
      yield PostLoading();
      final items = await appRepository.fetchOrderItems(1);
      yield PostsLoaded(items: items);
    } else if (event is SelectCheckOptionItemEvent) {
      //event.optionGroup.option_item.where((f) => f.id == event.index )

      Post item = (state as PostLoaded).item.copyChildItemWith(
          optionGroupId: event.optionGroupId,
          optionItemIndex: event.optionItemIndex,
          isSelected: event.isSelected);
 
      yield PostLoaded(item: item);
    } else if (event is SelectOptionItemEvent) {
      //event.optionGroup.option_item.where((f) => f.id == event.index )
 
      final item = (state as PostLoaded).item.copyWith(
          optionGroupId: event.groupId,
          optionGroupSelectedId: event.index);
      yield PostLoaded(item: item);
    } else if (event is AddCartItemEvent) {

      //Post item = (state as PostLoaded).item;
      double total = _calculateItemTotal(event.post);
      List<Post> cartItems = event.cartItems ?? []; 
      final menuItem = event.post.copyWith(total: total, index: cartItems.length);

      cartItems.add(
        menuItem
      ); 
      yield PostsLoaded(items: event.posts, cartItems: cartItems, count: cartItems.length);
    } else if (event is UpdateCartItemEvent) {

      //Post item = (state as PostLoaded).item;
      //double total = _calculateItemTotal(event.post);
      List<Post> cartItems = event.cartItems ?? []; 
      
      yield PostsLoaded(items: event.posts, cartItems: cartItems, count: cartItems.length);
    } else if (event is SetCartItemsEvent) {
      Header header = _calculateCartTotal(event.cartItems); 
      yield CartLoaded(cartHeader : header, cartItems: event.cartItems);
    }else if (event is FetchPostEvent) {
      print('FetchDataEvent fire');
      yield PostLoading();
      final item = await appRepository.fetchPost(event.id );
      yield PostLoaded(item: item);
    }else if (event is SearchPostEvent) {
      print('FetchPostEvent fire');
      yield PostLoading();
      final items = await appRepository.searchPosts(event.searchString);
      //yield SearchLoaded(items: items);
      yield PostsLoaded(items: items, cartItems: event.cartItems );
    } else if (event is RemoveCartItemEvent) {
      //Header header = _calculateCartTotal(event.index); 

      final tempMenuItems = (state as CartLoaded)
            .cartItems
            .where((item) => item.index != event.index)
            .toList();

        Header header = _calculateCartTotal(tempMenuItems); 
      yield CartLoaded(cartHeader : header, cartItems: tempMenuItems);
    }
  }


  Header _calculateCartTotal(
      List<Post> items) {
    double subTotal = 0;

    //items = items.where((i) => i.isSelected).toList();
    items.map((item) {
      subTotal += item.total;
    }).toList();

    double tax = (subTotal / 100) * (5 ?? 0);
    double deliveryFee =  0.0;

    deliveryFee = (subTotal == 0) ? 0 : deliveryFee;
    double total = subTotal + tax + deliveryFee;
    //header.totalNet = (totalGross + header.totalTax)  - header.totalDiscount;
    Header header = new Header(
        id: 0,
        tax: tax,
        sub_total: subTotal,
        total: total);
    return header;
  }

  double _calculateItemTotal(Post item) {
    double extraAmount = 0;
    int selectedId = 0;
    //print(item);

    //final List<VoucherOption> tempItems = item.options.where((i) => i.selectedId).toList();
    int i = 0;
    item.options.map((option) {
      if (option.type == 'radio') {
        selectedId = option.selected_id;
        print('Selected id : ${selectedId}');
        option.children.map((child) {
          print(child.price);

          if (child.price != 0 && selectedId == i) {
            extraAmount += child.price;
          }
          i++;
        }).toList();
      } else if (option.type == 'check') {
        option.children.map((child) {
          if (child.price != 0 && child.is_selected == true) {
            extraAmount += child.price;
          }
          i++;
        }).toList();
      }
    }).toList();

    return item.qty * (item.price + extraAmount );
  }
}
