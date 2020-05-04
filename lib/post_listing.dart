
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './res/assets.dart' as assets;
import 'package:http/http.dart' as http;
import 'bloc/post_bloc.dart';

import 'confirm_order.dart';
import 'menu_item.dart';
import 'model/post.dart';
import 'model/posts.dart';
import 'package:intl/intl.dart';

class PostListingPage extends StatelessWidget {
  final List<Post> cartItems;

  PostListingPage({Key key, this.cartItems}) : super(key: key);


  @override
    Widget build(BuildContext context) {
      return BlocProvider(
        create: (context) =>
            PostBloc(httpClient: http.Client())..add(FetchAllPostsEvent(1, this.cartItems)),
        child: HomePage(),
      ); 
    }
}


class HomePage extends StatefulWidget {


  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final formatter = new NumberFormat("#,###");
  static final String path = "lib/src/pages/ecommerce/ecommerce1.dart";
  final List<String> categories = ['DarazMall', 'Flash Sales', 'Collection', 'Vouchers', 'Categories'];
  final List<String> images = [assets.images[0],assets.images[2],assets.images[1], assets.images[3]];
  final List<String> flashSaleImages = [assets.backgroundImages[0],assets.backgroundImages[2],assets.backgroundImages[1]];


  @override
  void initState() {
    super.initState();
  }

  _getRequests(Post post, List<Post> cartItems, Posts posts) async {
    BlocProvider.of<PostBloc>(context)
        .add(AddCartItemEvent('this is note ', post, cartItems, posts));
  }


  Widget _buildAllFlashItems(Posts posts, List<Post> cartItems){
    
    var size = MediaQuery.of(context).size;
    final double itemHeight = 200;
    final double itemWidth = size.width / 2;



    List<Widget> widgets = new List<Widget>(); 
    for(var i = 0 ; i < posts.items.length; i++){
      widgets.add(
        
        Container(
          height: 200,
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.only(
                top: 0, right: 0, bottom: 0, left: 0),
            child: GestureDetector(
              onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MenuItemPage(id : posts.items[i].id )),
                        ) //.then((menuItem)=>_getRequests(menuItem)
                            .then((menuItem) => (menuItem != null)
                                ? _getRequests(menuItem, cartItems, posts)
                                : null),
              child: Card(
                elevation: 0.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: const Radius.circular(5.0),
                        topRight: const Radius.circular(5.0),
                      ),
                      child: CachedNetworkImage(
                        imageUrl:
                            "${posts.items[i].image}",
                        placeholder: (context, url) => Container(
                          height: 110,
                          width: double.infinity,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        errorWidget: (context, url, error) =>
                            Image.asset(
                          "assets/app-icon.png",
                          fit: BoxFit.fitWidth,
                          height: 110,
                          width: double.infinity,
                        ),
                        fit: BoxFit.fitWidth,
                        height: 110,
                        width: double.infinity,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.0, left: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment:
                           MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            posts.items[i].name,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                              'Ks ${formatter.format( posts.items[i].price) }',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: Colors.orange
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ); 
    }
    return SliverGrid.count(
      crossAxisCount: 2,
      childAspectRatio: (itemWidth / itemHeight),
      children: widgets,
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostBloc, PostState>(
      builder: (context, state) {
        if (state is PostInitial) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is PostError) {
          return Center(
            child: Text('failed to fetch posts'),
          );
        }
        if (state is PostLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is PostsLoaded) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.orange,
              title: Text('Home'),
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white),
                //onPressed: () => Navigator.of(context).pop(),
                onPressed: () => Navigator.pop(context, state.cartItems),
              ), 
              elevation: 0,
              actions: <Widget>[
                
                IconButton(icon: Icon(Icons.search), onPressed: (){
                },),
                IconButton(icon: Icon(Icons.filter_list), onPressed: (){
                  /*
                  Navigator.push(context, MaterialPageRoute(
                            builder: (_) => ConfirmOrderPage(cartItems: state.cartItems)
                          ));
                  */
                },)
              ],
            ),
            body: Container(
              child: CustomScrollView(
                slivers: <Widget>[
                  _buildAllFlashItems(
                        state.items, state.cartItems)
                  /*
                  SliverList(
                    delegate: SliverChildListDelegate(_buildAllFlashItems(
                        state.items.flash_items.items)),
                  ),
                  */
                ],
              ),
            ),
            
            bottomNavigationBar: BottomNavigationBar(
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
                BottomNavigationBarItem(icon: Icon(Icons.message), title: Text('Messages')),
                BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), 
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Cart'),
                      (state.cartItems.length > 0 ) ? 
                      Container(
                        //color: Colors.red,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: Text(' ${state.cartItems.length}' , 
                            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15.0, color: Colors.white),),
                        )
                      ): Container(width: 0 , height: 0 )
                    ],
                  )
                ),
                BottomNavigationBarItem(icon: Icon(Icons.person), title: Text('Account')),
              ],
              currentIndex: 0,
              type: BottomNavigationBarType.fixed,
              fixedColor: Colors.orange,
              onTap: (int index) {
                  //_selectedIndex = index;
                  if(index == 0){
                    BlocProvider.of<PostBloc>(context).add(
                        FetchPostsEvent(1));
                  }else if(index == 2){
                    Navigator.push(context, MaterialPageRoute(
                            builder: (_) => ConfirmOrderPage(cartItems: state.cartItems)
                          ));
                  }
                  
              },
            ),
            
          );
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}