import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'bloc/post_bloc.dart';
import 'model/option.dart';
import 'model/post.dart';
class ConfirmOrderPage extends StatelessWidget{
  static final String path = "lib/src/pages/ecommerce/confirm_order1.dart";
  final String address = "Chabahil, Kathmandu";
  final String phone="9818522122";
  final double total = 500;
  final double delivery = 100;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
              PostBloc(httpClient: http.Client())..add(FetchOrderItemsEvent()),
              child: BlocBuilder<PostBloc, PostState>(
          builder: (context, state) {
            if (state is PostInitial) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is PostsLoaded) {
              return Scaffold(
                body: CustomScrollView(
                  slivers: <Widget>[
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
                    new SliverList(
                        delegate: _buildSliverList(state.items.items)),
                  ]
                ),
              );
              /*
              return Scaffold(
                appBar: AppBar(
                  title: Text("Confirm Order"),
                ),
                body: _buildBody(context, state.items.items),
                
              );
              */
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




  _buildSliverList(List<Post> items) {
    List<Widget> list = [];

    //double screenWidth = MediaQuery.of(context).size.width;
    items.map((post) => list.add(
      new Column(
        children : _buildOptions(post)
      )
    )).toList();  
    
    
    return SliverChildListDelegate(list);
  }

  _buildOptions(Post post) {
    List<Widget> list = [];
    list.add(
      Text('${post.name}', textAlign: TextAlign.left,
        style: new TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold))
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
                          text: '    Select 1',
                          style: new TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 14.0,
                          )),
                      new TextSpan(
                          text: '    REQUIRE',
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
                              },
                              activeColor: Colors.red,
                              secondary: Text('secondary')

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
                          text:
                              '    Select up to ${optionGroup.max_item} (optional)',
                          style: new TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 14.0,
                          )),
                      new TextSpan(
                          text: '    OPTIONAL',
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
                          title: Text('${optionItem.price}' ),
                          //subtitle: Text('${optionItem.price ?? ""}'),
                          onChanged: (bool value) {
                            print("Check Tile pressed $value");
                            
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
  /*
  _buildCartItems(List<Post> items){
    List<Widget> widgets = new List<Widget>(); 
    
    for(var i = 0; i < items.length; i++){
      List<Widget> _children = new List<Widget>(); 
      widgets.add(
        Container(
            color: Colors.grey.shade200,
            padding: EdgeInsets.all(8.0),
            width: double.infinity,
            child: Text("${items[i].name}".toUpperCase())
          ),
      );
        
      
      if(items[i].radio_options.length > 0 ){
        for(var j = 0; j < items[i].radio_options.length; j++){
          _children.add(
              RadioListTile(
                selected: false,
                value: items[i].radio_options[j].id,
                groupValue: items[i].id,
                title: Text(items[i].radio_options[j].name),
                onChanged: (value){},
              ),
          ); 
        }
      }
      if(items[i].check_options.length > 0 ){
        for(var j = 0; j < items[i].check_options.length; j++){
          _children.add(
            CheckboxListTile(
              title: Text(items[i].check_options[j].name),
              value: false,
              onChanged: (bool value) {
                //setState(() { timeDilation = value ? 10.0 : 1.0; });
              },
            )
          );
        }
      }
      widgets.add(
        Column(
          children: _children
        )
      );
    }
      
      

    return Column(
      children: widgets
    );
  }
  */

}