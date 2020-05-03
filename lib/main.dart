
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import './res/assets.dart' as assets;
import 'package:http/http.dart' as http;
import 'bloc/post_bloc.dart';

import 'confirm_order.dart';
import 'listing.dart';
import 'menu_item.dart';
import 'model/category.dart';
import 'model/post.dart';
import 'model/posts.dart';
import 'profile.dart';
import 'search.dart';
import 'widgets/network_image.dart';
import 'package:intl/intl.dart';
import 'package:countdown_flutter/countdown_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
    Widget build(BuildContext context) {
      return MaterialApp(
        title: 'eCommerce',
        theme: ThemeData(
          // Define the default brightness and colors.
          brightness: Brightness.light,
          primaryColor: Colors.orange[800],
          accentColor: Colors.orange[600],

          // Define the default font family.
          fontFamily: 'Georgia',

          // Define the default TextTheme. Use this to specify the default
          // text styling for headlines, titles, bodies of text, and more.
          textTheme: TextTheme(
            headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
            title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
            body1: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
          ),
        ),
        home:  BlocProvider(
          create: (context) =>
              PostBloc(httpClient: http.Client())..add(FetchPostsEvent(1)),
          child: HomePage(),
        ),
        debugShowCheckedModeBanner: false,
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

  Widget _buildPopular(Posts posts) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = 100;
    final double itemWidth = size.width / 2;



    List<Widget> widgets = new List<Widget>(); 

    
    for(var i = 0 ; i < posts.featured_items.length; i++){
      widgets.add(
        Container(
            padding: EdgeInsets.all(5.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      border: Border(left: BorderSide(
                        color: Colors.orange.shade400,
                        style: BorderStyle.solid,
                        width: 5

                      ))
                    ),
                    child: ListTile(
                      onTap: (){},
                      title: Text("${posts.featured_items[i].name}", style: TextStyle(color: Colors.black, fontSize: 13.0), ),
                      subtitle: Text('Ks.${ formatter.format(posts.featured_items[i].price)}'),
                      trailing: Container(width: 50, child: PNetworkImage(posts.featured_items[i].image, fit: BoxFit.cover,)),
                    ),
                  ),
                )
              ],
            ),
          )
      ); 
    }
    return SliverGrid.count(
      crossAxisCount: 2,
      childAspectRatio: (itemWidth / itemHeight),
      children: widgets,
    );
  }

  Widget _buildFlashSales(Posts posts, List<Post> cartItems) {
    return Container(
      height: 240,
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top : 4.0, left:4.0, bottom: 0.0),
                child: Row(
                  children: <Widget>[
                    Text('${posts.flash_items.caption}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),),
                    SizedBox(width: 10.0,),
                    Container(
                      color: Colors.black,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                        child: CountdownFormatted(
                          duration: Duration(hours: 2),
                          builder: (BuildContext ctx, String remaining) {
                            return Text(
                              remaining,
                              style: TextStyle(fontSize: 15, color: Colors.white, letterSpacing: 5.0),
                            ); // 01:00:00
                          },
                        ),
                      ),
                    ),
                    
                  ],
                ),
              ),
              //Text('SHOP MORE >>', style: TextStyle(color: Colors.red),)
              InkWell(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text("Show All", style: TextStyle(color: Colors.orange),),
                  ),
                  onTap: () {
                    /*
                    BlocProvider.of<PostBloc>(context).add(
                        FetchFlashPostsEvent(2, 1, 'Flash Sales'));
                    */
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ListingPage(cartItems: cartItems,)),
                    ); 
                  },
              ),
              
            ],
          ),
          //SizedBox(height: 10,),
          SizedBox(
            height: 160,
            child: ListView.builder(
                itemExtent: (MediaQuery.of(context).size.width / 3),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.only(left: 0.0),
                      child: Card(
                        elevation: 0.5,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.white70, width: 1),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Padding(
                          padding:
                              EdgeInsets.only(top: 0, right: 0, bottom: 5, left: 0),
                          child: GestureDetector(
                            onTap: () {
                              
                            },
                            child: Container(
                              height: 170,
                              width: double.infinity,
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: 0, right: 0, bottom: 0, left: 0),
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
                                            "${posts.flash_items.items[index].image}",
                                        placeholder: (context, url) => Container(
                                          height: 90,
                                          width: double.infinity,
                                          child: Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Image.asset(
                                          "assets/app-icon.png",
                                          fit: BoxFit.cover,
                                          height: 100,
                                          width: double.infinity,
                                        ),
                                        fit: BoxFit.fitWidth,
                                        height: 90,
                                        width: double.infinity,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 10.0, left: 10.0),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Expanded(
                                            child: Text(
                                              posts.flash_items.items[index].name,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
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
                      ),
                    ),
                itemCount: posts.flash_items.items.length),
          ),
          /*
          Row(
            children: <Widget>[
              _buildFlashSaleItem(0),
              _buildFlashSaleItem(1),
              _buildFlashSaleItem(2),
            ],
          )
          */
        ],
      ),
    );
  }

  Widget _buildSlider(List<Category> items) {
    return Container(
      height: 120.0,
      child: Stack(
        children: <Widget>[
          ClipPath(
            clipper: DiagonalPathClipperOne(),
            child: Container(
              height: 110,
              color: Colors.orange,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Swiper(
              autoplay: true,
              itemBuilder: (BuildContext context,int index){
                return new PNetworkImage(items[index].image,fit: BoxFit.cover,);
              },
              itemCount: items.length,
              pagination: new SwiperPagination(),
            ),
          ),
        ],
      ),
    );
  }


  _getRequests(Post post, List<Post> cartItems, Posts posts) async {
    BlocProvider.of<PostBloc>(context)
        .add(AddCartItemEvent('this is note ', post, cartItems, posts));
  }


  Widget _buildAllItems(Posts posts, List<Post> cartItems){
    
    var size = MediaQuery.of(context).size;
    final double itemHeight = 220;
    final double itemWidth = size.width / 2;



    List<Widget> widgets = new List<Widget>(); 
    for(var i = 0 ; i < posts.items.length; i++){
      widgets.add(
        /*
        Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              PNetworkImage(items[i].image),
              SizedBox(height: 10.0,),
              Text('Top Quality fashion item', softWrap: true,),
              SizedBox(height: 10.0,),
              Text('Ks.1,254', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.red),)
            ],
          ),
        ),
        */
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
                              builder: (context) => MenuItemPage()),
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
                          fit: BoxFit.cover,
                          height: 110,
                          width: double.infinity,
                        ),
                        fit: BoxFit.cover,
                        height: 130,
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
                          Row(

                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  posts.items[i].name,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              IconButton(icon: Icon(Icons.favorite_border), onPressed: (){
                                /*
                                Navigator.push(context, MaterialPageRoute(
                                          builder: (_) => SearchPage()
                                        ));
                                */
                              },),
                            ],
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




  Widget _buildAllFlashItems(Posts posts, List<Post> cartItems){
    
    var size = MediaQuery.of(context).size;
    final double itemHeight = 200;
    final double itemWidth = size.width / 2;



    List<Widget> widgets = new List<Widget>(); 
    for(var i = 0 ; i < posts.flash_items.items.length; i++){
      widgets.add(
        /*
        Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              PNetworkImage(items[i].image),
              SizedBox(height: 10.0,),
              Text('Top Quality fashion item', softWrap: true,),
              SizedBox(height: 10.0,),
              Text('Ks.1,254', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.red),)
            ],
          ),
        ),
        */
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
                              builder: (context) => MenuItemPage()),
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
                            "${posts.flash_items.items[i].image}",
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
                            posts.flash_items.items[i].name,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                              'Ks ${formatter.format( posts.flash_items.items[i].price) }',
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
  Widget _buildCategoryIcon(String icon ){
    if(icon == 'dirves')
      return Icon(Icons.phonelink,color: Colors.white,); 
    else if(icon == 'weekend')
      return Icon(Icons.weekend,color: Colors.white,); 
    
    else if(icon == 'local_hospital')
      return Icon(Icons.local_hospital,color: Colors.white,); 
    else if(icon == 'directions_walk')
      return Icon(Icons.directions_walk,color: Colors.white,); 
    else if(icon == 'pregnant_woman')
      return Icon(Icons.pregnant_woman,color: Colors.white,); 
    else 
      return Icon(Icons.drive_eta,color: Colors.white,); 

  }

  Widget _buildCategoriesGrid(List<Category> categories, List<Post> cartItems) {
    return Container(
      height: 125.0,
      child: GridView.builder(
        padding: EdgeInsets.all(10.0),
        scrollDirection: Axis.horizontal,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          mainAxisSpacing: 10.0,

        ),
        itemBuilder: (_, int index){
          return GestureDetector(
            onTap: (){
              print(categories[index]);
              /*
              BlocProvider.of<PostBloc>(context).add(
                        FetchFlashPostsEvent(2, categories[index].id, 'Category', cartItems)); 
              */
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ListingPage(cartItems: cartItems,)),
              ); 
            },
            child: Column(
              children: <Widget>[
                CircleAvatar(
                  backgroundColor: Colors.orange,
                  maxRadius: 30.0,
                  child: _buildCategoryIcon(categories[index].icon),
                ),
                SizedBox(height: 8.0,),
                Text(categories[index].name, 
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 12,
                ))
              ],
            ),
          );
        },
        itemCount: categories.length,

      ),
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
              title: Text('eCommerce'),
              elevation: 0,
              actions: <Widget>[
                
                IconButton(icon: Icon(Icons.search), onPressed: (){
                  
                  Navigator.push(context, MaterialPageRoute(
                            builder: (_) => SearchPage()
                          ));
                  
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
            body : Container(
              child: CustomScrollView(
                slivers: <Widget>[
                  //_buildSlider(state.items.sliders),
                  SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          _buildSlider(state.items.sliders),
                        ]
                      ),
                  ),
                  SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          _buildCategoriesGrid(state.items.categories, state.cartItems),
                        ]
                      ),
                  ),
                  SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          
                          _buildFlashSales(state.items, state.cartItems),
                        ]
                      ),
                  ),
                  
                  SliverToBoxAdapter(
                    //child: Center(child: Text('Popular Items',   style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20.0),)),
                    child: Padding(
                      padding: const EdgeInsets.only(top : 8.0, bottom: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(flex : 1, child: Text('')), 
                          Expanded(
                            flex : 2, 
                            child: Center(child: Text('Popular Items',   style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20.0),))
                          ), 
                          Expanded(
                            flex : 1, 
                            child: InkWell(
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text("Show All", style: TextStyle(color: Colors.orange),),
                                ),
                                onTap: () {
                                  /*
                                  BlocProvider.of<PostBloc>(context).add(
                                      FetchFlashPostsEvent(3, 1, 'Popular Sales'));
                                  */
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ListingPage(cartItems: state.cartItems,)),
                                  ); 
                                },
                            ),
                          ), 

                        ],
                      ),
                    )
                    
                  ),
                  
                  
                  _buildPopular(state.items),
                  
                  SliverToBoxAdapter(
                      child: Center(child: Padding(
                        padding: const EdgeInsets.only(top : 20.0, bottom: 15.0),
                        child: Text('Just for You', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20.0),),
                      )),
                  ),
                  _buildAllItems(state.items, state.cartItems),
                  
                ],
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
                BottomNavigationBarItem(icon: Icon(Icons.favorite_border), title: Text('Wish List')),
                BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), title: Text('Cart')),
                BottomNavigationBarItem(icon: Icon(Icons.person), title: Text('Account')),
              ],
              currentIndex: 0,
              type: BottomNavigationBarType.fixed,
              fixedColor: Colors.orange,
              onTap: (int index) {
                  //_selectedIndex = index;
                  if(index == 2){
                    Navigator.push(context, MaterialPageRoute(
                            builder: (_) => ConfirmOrderPage(cartItems: state.cartItems)
                          ));
                  }else if(index == 3){
                    Navigator.push(context, MaterialPageRoute(
                            builder: (_) => ProfilePage()
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