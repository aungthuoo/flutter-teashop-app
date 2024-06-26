import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cart.dart';
import 'widgets/network_image.dart';
import 'bloc/post_bloc.dart';
import 'package:intl/intl.dart';

class PostDetail extends StatelessWidget {
  final int id;

  PostDetail({Key key, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          PostBloc(httpClient: http.Client())..add(FetchPostEvent(id: 1)),
      child: DetailPage(),
    );
  }
}

class DetailPage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<DetailPage> {
  final formatter = new NumberFormat("#,###");
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
        if (state is PostLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is PostError) {
          return Center(
            child: Text('failed to fetch posts'),
          );
        }
        if (state is PostLoaded) {
          return Scaffold(
            appBar: AppBar(
                            iconTheme: IconThemeData(
                              color: Colors.black
                            ),
                            brightness: Brightness.light,
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                            title: Text("Back to Shopping", style: TextStyle(color: Colors.black),),
                            actions: <Widget>[
                              IconButton(icon: Icon(Icons.favorite_border), onPressed: (){},)
                            ],
                          ),
            body:  CustomScrollView(
              slivers: <Widget>[
                
                
                SliverFixedExtentList(
                  itemExtent: 250.0,
                  delegate: SliverChildListDelegate(
                    [
                      PNetworkImage(state.item.image),
                    ],
                  ),
                ),
                SliverFixedExtentList(
                  itemExtent: 150.0,
                  delegate: SliverChildListDelegate(
                    [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: buildDropdownButton(['Black','Blue','Red'],'Black')
                            ),
                            Expanded(
                              child: buildDropdownButton(['S','M','XL','XXL'],'XXL')
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Container(
                        padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
                        child: Text("${state.item.name}", style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.w500
                        ),),
                      ),
                    ],
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: Row(
                              children: <Widget>[
                                SizedBox(width: 20.0,),
                                Icon(Icons.star, color: Colors.yellow),
                                Icon(Icons.star, color: Colors.yellow),
                                Icon(Icons.star, color: Colors.yellow),
                                Icon(Icons.star, color: Colors.yellow),
                                Icon(Icons.star, color: Colors.yellow),
                                SizedBox(width: 5.0,),
                                Text("5.0 stars", style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14.0
                                ))
                              ],
                            )
                          ),
                          Text("Ks.${ formatter.format( state.item.price) }", style: TextStyle(
                            color: Colors.red,
                            fontSize: 20.0,
                          )),
                          SizedBox(width: 20.0,),
                        ],
                      ),
                    ],
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0) ,
                            child: Text("Description",style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w400
                          ))),
                          
                          Container(
                            padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
                            child: Text("${state.item.description}",
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                  color: Colors.grey.shade600
                                ),
                              ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Expanded(
                                child: MaterialButton(
                                  color: Colors.orangeAccent,
                                  elevation: 0,
                                  onPressed: (){},
                                  child: Container(
                                    padding: EdgeInsets.all(15.0),
                                    child: Text("Buy", textAlign: TextAlign.center,style: TextStyle(
                                      fontSize: 20.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500
                                    ),),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: MaterialButton(
                                  color: Colors.black54,
                                  elevation: 0,
                                  onPressed: (){
                                    Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => CartPage(),
                                    ));
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(15.0),
                                    child: Text("Add to cart", textAlign: TextAlign.center,style: TextStyle(
                                      fontSize: 20.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500
                                    ),),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
                
              ]
            )

          );
          return Scaffold(
                body: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    ListView(
                      children: <Widget>[
                        PNetworkImage(state.item.image),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: buildDropdownButton(['Black','Blue','Red'],'Black')
                              ),
                              Expanded(
                                child: buildDropdownButton(['S','M','XL','XXL'],'XXL')
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
                          child: Text("${state.item.name}", style: TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.w500
                          ),),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              child: Row(
                                children: <Widget>[
                                  SizedBox(width: 20.0,),
                                  Icon(Icons.star, color: Colors.yellow),
                                  Icon(Icons.star, color: Colors.yellow),
                                  Icon(Icons.star, color: Colors.yellow),
                                  Icon(Icons.star, color: Colors.yellow),
                                  Icon(Icons.star, color: Colors.yellow),
                                  SizedBox(width: 5.0,),
                                  Text("5.0 stars", style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14.0
                                  ))
                                ],
                              )
                            ),
                            Text("Ks.${state.item.price}", style: TextStyle(
                              color: Colors.red,
                              fontSize: 27.0,
                            )),
                            SizedBox(width: 20.0,),
                          ],
                        ),
                        Container(padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0) ,
                          child: Text("Description",style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w400
                        ))),
                        
                        Container(
                          padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
                          child: Text("${state.item.description}",
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                color: Colors.grey.shade600
                              ),
                            ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        AppBar(
                          iconTheme: IconThemeData(
                            color: Colors.black
                          ),
                          brightness: Brightness.light,
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                          title: Text("Back to Shopping", style: TextStyle(color: Colors.black),),
                          actions: <Widget>[
                            IconButton(icon: Icon(Icons.favorite_border), onPressed: (){},)
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Expanded(
                              child: MaterialButton(
                                color: Colors.deepOrange,
                                elevation: 0,
                                onPressed: (){},
                                child: Container(
                                  padding: EdgeInsets.all(15.0),
                                  child: Text("Buy", textAlign: TextAlign.center,style: TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500
                                  ),),
                                ),
                              ),
                            ),
                            Expanded(
                              child: MaterialButton(
                                color: Colors.black54,
                                elevation: 0,
                                onPressed: (){},
                                child: Container(
                                  padding: EdgeInsets.all(15.0),
                                  child: Text("Add a bag", textAlign: TextAlign.center,style: TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500
                                  ),),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              );
        }
      },
    );
  }


  Widget buildDropdownButton(List<String> items, String selectedValue) {
    return DropdownButton<String>(
      isExpanded: true,
      value: selectedValue,
      onChanged: (_) {},
      items: items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
  

  @override
  void dispose() {
    super.dispose();
  }

}
