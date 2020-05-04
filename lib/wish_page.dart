import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'bloc/post_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';

class WishPage extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          PostBloc(httpClient: http.Client())..add(FetchWishPostsEvent('')),
      child: MyHomePage(title: 'Wish List')
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

        if (state is WishItemsLoaded) {
          return new Scaffold(
            appBar: new AppBar(
              title: new Text(widget.title),
            ),
            body: Container(
              child: Column(
                children: <Widget>[
                  
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemExtent: 100.0,
                      itemCount: state.items.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: CachedNetworkImage(
                            imageUrl: '${state.items[index].image}', 
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
                              Text('${state.items[index].name}', 
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text('Ks.${state.items[index].price}' , 
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: Colors.orange
                              ),),
                            ],
                          ),
                          onTap: () {},
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