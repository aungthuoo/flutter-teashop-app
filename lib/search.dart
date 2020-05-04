import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'bloc/post_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'menu_item.dart';
import 'model/post.dart';
import 'model/posts.dart';

class SearchPage extends StatelessWidget {
  // This widget is the root of your application.
  final List<Post> cartItems;

  SearchPage({Key key, this.cartItems}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          PostBloc(httpClient: http.Client())..add(FetchSearchPostsEvent( '' , this.cartItems)),
      child: MyHomePage(title: 'Search Stock')
    ); 

    //return MyHomePage(title: 'Search Stock');
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController editingController = TextEditingController();

  final duplicateItems = List<String>.generate(10000, (i) => "Item $i");
  var items = List<String>();

  @override
  void initState() {
    items.addAll(duplicateItems);
    super.initState();
  }

  void filterSearchResults(String query) {
    List<String> dummySearchList = List<String>();
    dummySearchList.addAll(duplicateItems);
    if(query.isNotEmpty) {
      List<String> dummyListData = List<String>();
      dummySearchList.forEach((item) {
        if(item.contains(query)) {
          dummyListData.add(item);
        }
      });
      setState(() {
        items.clear();
        items.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        items.clear();
        items.addAll(duplicateItems);
      });
    }

  }


  _getRequests(Post post, List<Post> cartItems, Posts posts) async {
    BlocProvider.of<PostBloc>(context)
        .add(AddCartItemEvent('this is note ', post, cartItems, posts));
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
          return new Scaffold(
            appBar: new AppBar(
              title: new Text(widget.title),
            ),
            body: Container(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      onChanged: (value) {
                        //filterSearchResults(value);
                        BlocProvider.of<PostBloc>(context)
                          .add(SearchPostEvent(editingController.text, state.cartItems));
                      },
                      controller: editingController,
                      decoration: InputDecoration(
                          labelText: "Search",
                          hintText: "Search",
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(0.0)))),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemExtent: 80.0,
                      itemCount: state.items.items.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: CachedNetworkImage(
                            imageUrl: '${state.items.items[index].image}', 
                            placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) => Image.asset('assets/placeholder.jpg',fit: BoxFit.cover,),
                            fit: BoxFit.cover,
                            width: 80,
                            height: 80,
                          ),
                          title: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('${state.items.items[index].name}', 
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,),
                              Text('Ks.${state.items.items[index].price}' , 
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: Colors.orange
                              ),),
                            ],
                          ),
                          onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MenuItemPage(id : state.items.items[index].id )),
                        ) //.then((menuItem)=>_getRequests(menuItem)
                            .then((menuItem) => (menuItem != null)
                                ? _getRequests(menuItem, state.cartItems, state.items)
                                : null),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      }
    );



    
  }

  @override
  void dispose() {
    super.dispose();
  }
}