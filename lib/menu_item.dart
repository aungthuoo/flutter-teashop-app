import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import './network_image.dart';
import 'bloc/post_bloc.dart';
import 'model/option.dart';
import 'model/post.dart';


class MenuItemPage extends StatelessWidget{
  static final String path = "lib/src/pages/ecommerce/confirm_order1.dart";
  final String address = "Chabahil, Kathmandu";
  final String phone="9818522122";
  final double total = 500;
  final double delivery = 100;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
              PostBloc(httpClient: http.Client())..add(FetchPostEvent()),
              child: BlocBuilder<PostBloc, PostState>(
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
            if (state is PostLoaded) {
              
              return Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.orangeAccent,
                  title: Text('${state.item.name}'),
                  elevation: 0,
                ),
                body: CustomScrollView(
                  slivers: <Widget>[
                    /*
                    SliverAppBar(
                      
                      leading: BackButton(color: Colors.black),
                      expandedHeight: 55.0,
                      //floating: true,
                      //pinned: true,
                      //snap: true,
                      elevation: 1.0,
                      backgroundColor: Colors.white,
                      flexibleSpace: FlexibleSpaceBar(
                        centerTitle: true,
                        title: Text('Customize',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                            )),
                      ),
                    ),
                    */
                    SliverToBoxAdapter(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  height: 380,
                                  alignment: Alignment.topCenter,
                                  decoration: BoxDecoration(
                                    /*
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black38,
                                        blurRadius: 30.0
                                      )
                                    ]
                                    */
                                  ),
                                  child: SizedBox(
                                    height: 350,
                                    child: PNetworkImage(state.item.image, fit: BoxFit.cover,),
                                  ),
                                ),
                              ],
                            )),
                    new SliverList(
                        delegate: _buildSliverList(context, state.item)),
                  ]
                ),
              );
            }
          }
        ),
    );
    
  }

  Widget _buildBody(BuildContext context, List<Post> items) {
    return SingleChildScrollView(
          padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 40.0, bottom: 10.0),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Subtotal"),
                  Text("Rs. $total"),
                ],
              ),
              SizedBox(height: 10.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Delivery fee"),
                  Text("Rs. $delivery"),
                ],
              ),
              SizedBox(height: 10.0,),  
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Total", style: Theme.of(context).textTheme.title,),
                  Text("Rs. ${total+delivery}", style: Theme.of(context).textTheme.title),
                ],
              ),
              SizedBox(height: 20.0,),
              //_buildCartItems(items), 
              
              
              Container(
                width: double.infinity,
                child: RaisedButton(
                  color: Theme.of(context).primaryColor,
                  onPressed: ()=> {},
                  child: Text("Confirm Order", style: TextStyle(
                    color: Colors.white
                  ),),
                ),
              )
            ],
          ),
        );
  }




  _buildSliverList(BuildContext context, Post item) {
    List<Widget> list = [];

    //double screenWidth = MediaQuery.of(context).size.width;

    list.add(
      new Column(
        children : _buildOptions(context, item)
      )
    );
    list.add(
      Padding(
        padding: const EdgeInsets.all(15.0),
        child: FlatButton(
                  color: Colors.orange,
                  textColor: Colors.white,
                  disabledColor: Colors.grey,
                  disabledTextColor: Colors.black,
                  padding: EdgeInsets.all(8.0),
                  splashColor: Colors.blueAccent,
                  onPressed: () {
                    //Navigator.of(context).pop();
                    /*
                    BlocProvider.of<PostBloc>(context).add(
                                    AddCartItemEvent( 'hote here '));
                    Navigator.pop(context);
                    */
                    Post post =
                      item.copyWith(note: 'This is note');
                    Navigator.pop(context, post);
           
                  },
                  child: Text(
                    "ပေါင်းထည့်မည်",
                  ),
                ),
      ),
    );
    
    
    return SliverChildListDelegate(list);
  }

  _buildOptions(BuildContext context, Post post) {
    List<Widget> list = [];
    list.add(
      Text('${post.name}', textAlign: TextAlign.left,
        style: new TextStyle(fontSize: 23.0, fontWeight: FontWeight.bold))
    );
    post.options
        .map((optionGroup) => (optionGroup.type == 'radio')
            ? list.add(ExpansionTile(
                //title: Text('${optionGroup.title} '),
                title: new RichText(
                  text: new TextSpan(
                    style: new TextStyle(
                        fontSize: 14.0,
                        decoration: TextDecoration.none,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                    children: <TextSpan>[
                      new TextSpan(
                          text: '${optionGroup.title}',
                          style: new TextStyle(fontWeight: FontWeight.bold)),
                      
                      new TextSpan(
                          text: '   (မဖြစ်မနေရွေးရမည်။)',
                          style: new TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 12.0,
                              color: Colors.blue)),
                      
                    ],
                  ),
                ),
                children: optionGroup.children
                    .asMap()
                    .map((i, optionItem) => MapEntry(
                          i,
                          RadioListTile(
                              value: i,
                              groupValue: optionGroup.selected_id,
                              title: Text('${optionItem.name}'),
                              //subtitle: Text('${optionItem.price ?? ""}'),
                              onChanged: (val) {
                                print("Radio Tile pressed $val");
                                BlocProvider.of<PostBloc>(context).add(
                                    SelectOptionItemEvent(optionGroup.id, i));
                              },
                              activeColor: Colors.red,
                              secondary: Text('Ks.${optionItem.price}')
                              //selected: true,
                              ),
                        ))
                    .values
                    .toList()
                //children: _buildOptionChild(option),
                ))
            : list.add(ExpansionTile(
                //title: Text('${optionGroup.title}'),
                title: new RichText(
                  text: new TextSpan(
                    style: new TextStyle(
                        fontSize: 14.0,
                        decoration: TextDecoration.none,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                    children: <TextSpan>[
                      new TextSpan(
                          text: '${optionGroup.title}',
                          style: new TextStyle(fontWeight: FontWeight.bold)),
                     
                      new TextSpan(
                          text: '    (ကျော်သွားနိုင်သည်။)',
                          style: new TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 12.0,
                              color: Colors.blue)),
                    ],
                  ),
                ),
                children: optionGroup.children
                    .asMap()
                    .map((index, optionItem) {
                      var checkboxListTile = CheckboxListTile(
                          value: optionItem.is_selected,
                          //groupValue: optionGroup.selected_id,
                          title: Text('+ Ks.${optionItem.price}', style: new TextStyle(fontWeight: FontWeight.normal, fontSize: 12.0, color: Colors.red)),
                          //subtitle: Text('${optionItem.price ?? ""}'),
                          onChanged: (bool value) {
                            print("Check Tile pressed $value");
                            if (true ) {
                              BlocProvider.of<PostBloc>(context).add(
                                  SelectCheckOptionItemEvent(optionGroup.id, index, value));
                            } 
                            
                          },
                          activeColor: Colors.red,
                          secondary: Text('${optionItem.name}'));
                      return MapEntry(
                        index,
                        checkboxListTile,
                      );
                    })
                    .values
                    .toList()
                //children: _buildOptionChild(option),
                )))
        .toList();
    return list; 
    //return SliverChildListDelegate(list);
  }
  
}