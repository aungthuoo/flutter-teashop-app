import 'package:flutter/material.dart';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './assets/assets.dart';
import './recipe_single.dart';
import 'bloc/post_bloc.dart';
import 'package:http/http.dart' as http;
import 'confirm_order.dart';
import 'menu_item.dart';
import 'model/post.dart';


//void main() => runApp(MyApp());


class HomePage extends StatelessWidget {

  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  @override
    Widget build(BuildContext context) {
      return MaterialApp(
      title: 'teashop',
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
      home:  Scaffold(
        key: _drawerKey,

        drawer: Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              /*
              DrawerHeader(
                child: Text('Drawer Header'),
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                ),
              ),
              */
              DrawerHeader(
                child: Text('Tea Shop',
                    style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w700,
                        color: Colors.white)),
                decoration: BoxDecoration(
                    color: Colors.blue,
                    image: DecorationImage(
                        image: AssetImage("assets/banner.jpg"),
                        fit: BoxFit.cover)),
              ),
              ListTile(
                leading: Icon(Icons.person),
                title: Text('My Profile'),
                onTap: () {
                  print('My Profile');

                },
              ),
              ListTile(
                leading: Icon(Icons.location_on),
                title: Text('My Address'),
                onTap: () async {
                  
                },
              ),
              ListTile(
                leading: Icon(Icons.message),
                title: Text('Inbox'),
                onTap: () async {
                  //Navigator.of(context).pop();
                  
                },
              ),
              ListTile(
                leading: Icon(Icons.tab),
                title: Text('v1.0.1'),
                onTap: () {},
              ),
            ],
          ),
        ),
        /*
        appBar: AppBar(
          backgroundColor: Colors.orangeAccent,
          leading: IconButton(
            icon: Icon(
              Icons.menu,
              color: Colors.white,
              size: 30.0,
            ),
            tooltip: 'User profile',
            onPressed: () {
              
              //https://stackoverflow.com/questions/57748170/flutter-how-to-open-drawer-programmatically
              _drawerKey.currentState.openDrawer();
            },
          ),
          title: Text('Tea Shop'),
          elevation: 0,
        ),
        */
        /*
        body: SafeArea(
          child: ListView.builder(
            itemBuilder: _buildListView,
            itemCount: 10,
          )
        ),
        */
        body: BlocProvider(
          create: (context) =>
              PostBloc(httpClient: http.Client())..add(FetchPostsEvent(1)),
          child: HomePageState(),
        ),
        /*
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
            BottomNavigationBarItem(icon: Icon(Icons.message), title: Text('Messages')),
            BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), title: Text('Cart')),
            BottomNavigationBarItem(icon: Icon(Icons.person), title: Text('Account')),
          ],
          currentIndex: 0,
          type: BottomNavigationBarType.fixed,
          fixedColor: Colors.orange,
        ),
        */
      ),
      debugShowCheckedModeBanner: false,
    );
      
    }
}



class HomePageState extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePageState> {
  static final String path = "lib/src/pages/food/recipe_list.dart";
  final Color color1 = Color(0xffB5192F);
  final Color color2 = Color(0xffE21F3D);
  final Color color3 = Color(0xffFE1949);
  final Color color4 = Color(0xffF0631C);

  @override
  void initState() {
    super.initState();
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
            body: Stack(
              children: <Widget>[
             
                Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [color3, color4],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter)),
                ),
                Container(
                  height: 450,
                  width: 300,
                  decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.only(bottomRight: Radius.circular(30)),
                      color: color2),
                ),
                
                Container(
                  height: 450,
                  width: 80,
                  decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.only(bottomRight: Radius.circular(30)),
                      color: color1),
                ),

                Container(
                  child: CustomScrollView(
                    slivers: <Widget>[
                      SliverToBoxAdapter(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 30.0),
                          _buildHeader(context),
                          SizedBox(height: 10.0),
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Text(
                              "အမှာအများဆုံး".toUpperCase(),
                              style: TextStyle(color: Colors.white, fontSize: 18.0),
                            ),
                          ),
                          SizedBox(height: 20.0),
                        ],
                      )),
                      /*
                      SliverToBoxAdapter(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            height: 200,
                            child: ListView.builder(
                              padding: const EdgeInsets.only(left: 16.0),
                              scrollDirection: Axis.horizontal,
                              itemBuilder: _buildItem,
                            ),
                          ),
                        ],
                      )),
                      */
                      SliverPadding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                        sliver: SliverToBoxAdapter(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              height: 150,
                              child: ListView.builder(
                                itemExtent: (MediaQuery.of(context).size.width / 3),
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) => Padding(
                                      padding: const EdgeInsets.only(left: 4.0),
                                      child: GestureDetector(
                                        onTap: (){
                                          Navigator.push(context, MaterialPageRoute(
                                            builder: (_) => RecipeSinglePage()
                                          ));
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(right: 20),
                                          width: false ? 150 : 100,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(15.0),
                                                    image: DecorationImage(
                                                      image: CachedNetworkImageProvider(
                                                        state.items.most_orders[index].image,
                                                      ),
                                                      fit: BoxFit.cover,
                                                    )),
                                                height: false ? 180 : 100,
                                              ),
                                              SizedBox(height: 10.0),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 8.0),
                                                child: Text(
                                                  "${state.items.most_orders[index].name}".toUpperCase(),
                                                  style: TextStyle(color: Colors.white, fontSize: 14.0),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    ),
                                itemCount: state.items.most_orders.length),                          ),
                          ],
                        )),
                      ),

                      SliverToBoxAdapter(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 10.0),
                          _buildMenuHeader(context),
                          SizedBox(height: 10.0),
                         
                        ],
                      )),
                      SliverPadding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                        sliver: SliverToBoxAdapter(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              height: 170,
                              child: ListView.builder(
                                itemExtent: (MediaQuery.of(context).size.width / 3),
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) => Padding(
                                      padding: const EdgeInsets.only(left: 4.0),
                                      child: GestureDetector(
                                        onTap: (){
                                          /*
                                          Navigator.push(context, MaterialPageRoute(
                                            builder: (_) => MenuItemPage()
                                          ));
                                          */
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(right: 20),
                                          width: false ? 150 : 120,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(15.0),
                                                    image: DecorationImage(
                                                      image: CachedNetworkImageProvider(
                                                        state.items.categories[index].image,
                                                      ),
                                                      fit: BoxFit.cover,
                                                    )),
                                                height: false ? 180 : 90,
                                              ),
                                              SizedBox(height: 10.0),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 8.0),
                                                child: Text(
                                                  "${state.items.categories[index].name}".toUpperCase(),
                                                  style: TextStyle(color: Colors.white, fontSize: 14.0),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    ),
                                itemCount: state.items.categories.length),                          ),
                          ],
                        )),
                      ),
                      /*
                      SliverList(
                        delegate: SliverChildListDelegate(_buildItemsWidget(context, state.items.daily_needs)),
                      ),
                      */
                      SliverToBoxAdapter(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 10.0),
                          _buildSelectedHeader(context),
                          SizedBox(height: 10.0),
                         
                        ],
                      )),
                      _buildItems(state.items.items),
                      SliverToBoxAdapter(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 60.0),
                         
                        ],
                      )),
                      
                    ],
                  ),
                ),
                
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  
                  child: GestureDetector(
                    onTap: (){
                      print("Container clicked");
                      Navigator.push(context, MaterialPageRoute(
                        builder: (_) => ConfirmOrderPage(cartItems: state.cartItems)
                      ));
                    },
                    child: Container(
                      color: Colors.black54,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("${state.cartItems.length  } Items.", style: TextStyle(
                              color: Colors.white
                            ),),
                            Icon(Icons.shopping_cart, color: Colors.white70,),
                          ],
                        ),
                      ),
                    ),
                  )
                  /*

                  child: TextField(
                    decoration: InputDecoration(
                      fillColor: Colors.black87,
                      suffixIcon: Icon(Icons.shopping_cart, color: Colors.white70,),
                      filled: true,
                      hintText: "3 Items",
                      hintStyle: TextStyle(color: Colors.white70)
                    ),
                  ),
                  */
                )
                
              ],
            ));
          
        
        }
      },
    );
  }


  _getRequests(Post post) async {
    BlocProvider.of<PostBloc>(context)
        .add(AddCartItemEvent('this is note ', post));
  }

  Widget _buildItems(List<Post> items){
    List<Widget> widgets = List<Widget>();
    if (items.length > 0) {
      /*
      Navigator.push(context, MaterialPageRoute(
          builder: (_) => MenuItemPage()
        ));
      */
      for (var i = 0; i < items.length; i++) {
        widgets.add(
          GestureDetector(
            onTap: (){
              /*
              Navigator.push(context, MaterialPageRoute(
                builder: (_) => MenuItemPage()
              ));
              */
              Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MenuItemPage()),
                        ) //.then((menuItem)=>_getRequests(menuItem)
                            .then((menuItem) => (menuItem != null)
                                ? _getRequests(menuItem)
                                : null);
            },
            child: Container(
              margin: EdgeInsets.only(right: 20),
              width: false ? 150 : 120,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(
                            items[i].image,
                          ),
                          fit: BoxFit.cover,
                        )),
                    height: false ? 180 : 80,
                  ),
                  SizedBox(height: 10.0),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      "${items[i].name}".toUpperCase(),
                      style: TextStyle(color: Colors.white, fontSize: 14.0),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }
    }

    
    return SliverPadding(
      padding: const EdgeInsets.only(left : 15.0, right: 15.0),
      sliver: SliverGrid.count(
        crossAxisCount: 3,
        children: widgets 
      ),
    );
    
  }

  Widget _buildItem(BuildContext context, index, {bool large = false}) {
    return GestureDetector(
      onTap: (){
        /*
        Navigator.push(context, MaterialPageRoute(
          builder: (_) => RecipeSinglePage()
        ));
        */
        Navigator.push(context, MaterialPageRoute(
          builder: (_) => MenuItemPage()
        ));
      },
      child: Container(
        margin: EdgeInsets.only(right: 20),
        width: large ? 150 : 120,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(
                      images[index % images.length],
                    ),
                    fit: BoxFit.cover,
                  )),
              height: large ? 180 : 150,
            ),
            SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                "French\nToast".toUpperCase(),
                style: TextStyle(color: Colors.white, fontSize: 14.0),
              ),
            )
          ],
        ),
      ),
    );
  }

  Row _buildHeader(BuildContext context) {
    return Row(
      children: <Widget>[
        
        IconButton(
          color: Colors.white,
          iconSize: 40.0,
          icon: Icon(Platform.isIOS ? Icons.menu : Icons.menu),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        
        SizedBox(width: 15.0),
        
        Expanded(
          child: TextField(
            autofocus: false,
            style: TextStyle(fontSize: 18.0, color: Color(0xFFbdc6cf)),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: 'Search menu',
              contentPadding:
                  const EdgeInsets.only(left: 14.0, bottom: 0.0, top: 0.0),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(10.7),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(0.2),
              ),
            ),
            onChanged: (String keyword) {
              print(keyword);
              
            },
          ),
        ),
        
        /*
        OutlineButton(
          color: Colors.white,
          textColor: Colors.white,
          borderSide: BorderSide(color: Colors.white),
          child: Text("Filter".toUpperCase()),
          onPressed: () {},
        ),
        */
        SizedBox(width: 10.0),
      ],
    );
  }

  Row _buildSelectedHeader(BuildContext context) {
    return Row(
      children: <Widget>[
        
        SizedBox(width: 15.0),
        
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              
              Text(
                "မနက်စာ".toUpperCase(),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
        OutlineButton(
          color: Colors.white,
          textColor: Colors.white,
          borderSide: BorderSide(color: Colors.white),
          child: Text("Sort".toUpperCase()),
          onPressed: () {

          },
        ),
        SizedBox(width: 16.0),
      ],
    );
  }

  Row _buildMenuHeader(BuildContext context) {
    return Row(
      children: <Widget>[
        
        SizedBox(width: 15.0),
        
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              
              Text(
                "အစားအစာ အမျိုးအစား".toUpperCase(),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
        OutlineButton(
          color: Colors.white,
          textColor: Colors.white,
          borderSide: BorderSide(color: Colors.white),
          child: Text("Show All".toUpperCase()),
          onPressed: () {},
        ),
        SizedBox(width: 16.0),
      ],
    );
  }


  @override
  void dispose() {
    super.dispose();
  }

}
