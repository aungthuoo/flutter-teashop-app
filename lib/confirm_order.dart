import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'bloc/post_bloc.dart';
import 'model/post.dart';
class ConfirmOrderPage extends StatelessWidget{
  final formatter = new NumberFormat("#,###");
  static final String path = "lib/src/pages/ecommerce/confirm_order1.dart";
  final String address = "Chabahil, Kathmandu";
  final String phone="9818522122";
  final double total = 500;
  final double delivery = 100;

  final List<Post> cartItems; 
    ConfirmOrderPage(
      {Key key, this.cartItems}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
              PostBloc(httpClient: http.Client())..add(SetCartItemsEvent(this.cartItems)),
        //create: (BuildContext context) {},
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
            if (state is CartLoaded) {
              return new Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.orangeAccent,
                  title: Text('မှာထားသည့်အမယ်များ'),
                  elevation: 0,
                ),
                body: Container(
                    child: Column(children: <Widget>[
                  Expanded(
                    child: MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.cartItems.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: buildOptionItemWidgets(
                                context, state.cartItems[index], index),
                          );
                        },
                      ),
                    ),
                    flex: 9,
                  ),
                  Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: new Container(
                        color: Colors.orange[50],
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            children: <Widget>[
                              
                              new Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Text(''),
                                    flex: 1,
                                  ),
                                  Expanded(
                                    //child: Text('Sub Total', style: TextStyle(color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold)),
                                    child: Text(
                                      'Sub Total',
                                      style: TextStyle(
                                          fontFamily: 'ZawgyiOne',
                                          fontSize: 14.0,
                                          decoration: TextDecoration.none,
                                          //fontWeight: FontWeight.w500,
                                          color: Colors.black),
                                    ),
                                    flex: 4,
                                  ),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        Text(
                                          //formatter.format( double.tryParse (menuItems.totalGross.toString())),
                                          'Ks ${state.cartHeader.sub_total}',

                                          style: TextStyle(
                                              fontFamily: 'ZawgyiOne',
                                              fontSize: 14.0,
                                              decoration: TextDecoration.none,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                    flex: 2,
                                  ),
                                ],
                              ),
                              
                              new Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Text(''),
                                    flex: 1,
                                  ),
                                  Expanded(
                                    //child: Text('Tax (5%)', style: TextStyle(color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold)),
                                    child: Text(
                                      'Tax',
                                      style: TextStyle(
                                          fontFamily: 'ZawgyiOne',
                                          fontSize: 14.0,
                                          decoration: TextDecoration.none,
                                          //fontWeight: FontWeight.w500,
                                          color: Colors.black),
                                    ),
                                    flex: 4,
                                  ),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.end,
                                      children: <Widget>[
                                        Text(
                                          //formatter.format( double.tryParse (state.voucherHeader.totalTax.toString())),

                                          '${state.cartHeader.tax}',
                                          style: TextStyle(
                                              fontFamily: 'ZawgyiOne',
                                              fontSize: 14.0,
                                              decoration:
                                                  TextDecoration.none,
                                              //fontWeight: FontWeight.w500,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                    flex: 2,
                                  ),
                                ],
                              ),
                                  
                              SizedBox(height: 7.0),
                              
                              SizedBox(height: 7.0),
                              new Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Text(''),
                                    flex: 1,
                                  ),
                                  Expanded(
                                    //child: Text('စုစုေပါင္း', style: TextStyle(color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold)),
                                    child: Text(
                                      'Total',
                                      style: TextStyle(
                                          fontFamily: 'ZawgyiOne',
                                          fontSize: 14.0,
                                          decoration: TextDecoration.none,
                                          //fontWeight: FontWeight.w500,
                                          color: Colors.black),
                                    ),
                                    flex: 4,
                                  ),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        Text(
                                          //formatter.format( double.tryParse (state.voucherHeader.totalNet.toString())),
                                          'Ks ${state.cartHeader.total}',
                                          style: TextStyle(
                                              fontFamily: 'ZawgyiOne',
                                              fontSize: 14.0,
                                              decoration: TextDecoration.none,
                                              //fontWeight: FontWeight.w500,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                    flex: 2,
                                  ),
                                ],
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(top: 15.0, bottom: 0.0),
                                child: SizedBox(
                                    width: double.infinity,
                                    // height: double.infinity,
                                    child: FlatButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      color: Colors.orange,
                                      textColor: Colors.white,
                                      disabledColor: Colors.grey,
                                      disabledTextColor: Colors.black,
                                      padding: EdgeInsets.all(8.0),
                                      splashColor: Colors.orangeAccent,
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Text(
                                          "အော်ဒါတင်မည်။",
                                          style: TextStyle(fontSize: 18.0),
                                        ),
                                      ),
                                      
                                    )),
                              ),
                            ],
                          ),
                        ),
                      )),
                ])));
            }
          }
        )
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




  _buildSliverList(BuildContext context, List<Post> items) {
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
  

  _buildCartItems(BuildContext context, List<Post> items){
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
            child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: buildOptionItemWidgets(
                        context, items[index], index),
                  );
                },
              ),
            ),
            flex: 9,
          ),
        ]
      ) 
    );
  }
  
  Widget buildOptionItemWidgets(
      BuildContext context, Post item, int selectedIndex) {
    List<Widget> list = new List<Widget>();

    list.add(
      Row(
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        '${item.qty}x',
                        style: new TextStyle(
                            fontSize: 13.0,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.normal),
                      ),
                    ],
                  ),
                ),
                
              ],
            ),
            flex: 1,
          ),
          Expanded(
            
            child: new RichText(
              text: new TextSpan(
                // Note: Styles for TextSpans must be explicitly defined.
                // Child text spans will inherit styles from parent
                style: new TextStyle(
                    fontSize: 13.0,
                    decoration: TextDecoration.none,
                    color: Colors.black,
                    fontWeight: FontWeight.w700),
                children: <TextSpan>[
                  new TextSpan(
                      text: '${item.name}',
                      style: new TextStyle(fontWeight: FontWeight.bold)),
                  new TextSpan(
                      text: '  Ks ${formatter.format(item.price)}',
                      style: new TextStyle(fontWeight: FontWeight.normal)),
                  
                ],
              ),
            ),
            flex: 5,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                //Text( formatter.format( double.tryParse (orderItem.amount.toString() )),
                //    style: TextStyle(color: Colors.black, fontSize: 17.0, fontWeight: FontWeight.bold) )
                Text(
                  '${item.total}',
                  style: TextStyle(
                      fontFamily: 'ZawgyiOne',
                      fontSize: 13.0,
                      decoration: TextDecoration.none,
                      color: Colors.black,
                      fontWeight: FontWeight.w700),
                ),
              ],
            ),
            flex: 2,
          ),
        ],
      ),
    );

    if (item.options != null) {
      for (var i = 0; i < item.options.length; i++) {
        //radio
        if (item.options[i].type == 'radio') {
          if (item.options[i].children != null) {
            for (var j = 0; j < item.options[i].children.length; j++) {
              if (j == item.options[i].selected_id) {
                list.add(new Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(''),
                      flex: 1,
                    ),
                    Expanded(
                      child: Text(
                        ' + ' +
                            item.options[i].children[j].name +
                            ((item.options[i].children[j].price == 0)
                                ? ''
                                : ' (Ks.' +
                                    formatter.format(item
                                        .options[i].children[j].price) +
                                    ')'),
                        style: TextStyle(
                            fontFamily: 'ZawgyiOne',
                            fontSize: 13.0,
                            decoration: TextDecoration.none,
                            color: Colors.black,
                            fontWeight: FontWeight.w300),
                      ),
                      flex: 6,
                    ),
                  ],
                ));
              }
            }
          }
        }

        //check
        if (item.options[i].type == 'check') {
          if (item.options[i].children != null) {
            for (var j = 0; j < item.options[i].children.length; j++) {
              if (item.options[i].children[j].is_selected)
                list.add(new Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(''),
                      flex: 1,
                    ),
                    Expanded(
                      child: Text(
                        ' + ' +
                            item.options[i].children[j].name +
                            ((item.options[i].children[j].price == 0)
                                ? ''
                                : ' (Ks.' +
                                    formatter.format(item
                                        .options[i].children[j].price) +
                                    ')'),
                        style: TextStyle(
                            fontFamily: 'ZawgyiOne',
                            fontSize: 13.0,
                            decoration: TextDecoration.none,
                            color: Colors.black,
                            fontWeight: FontWeight.w300),
                      ),
                      flex: 6,
                    ),
                  ],
                ));
            }
          }
        }
      }
    }
    // Add comment

    if (item.note != null) {
      list.add(new Row(
        children: <Widget>[
          Expanded(
            child: Text(''),
            flex: 1,
          ),
          Expanded(
            child: Text(
              '   ' + item.note.toString(),
              style: TextStyle(
                  fontFamily: 'ZawgyiOne',
                  fontSize: 12.0,
                  decoration: TextDecoration.none,
                  color: Colors.brown,
                  fontWeight: FontWeight.w300),
            ),
            flex: 6,
          ),
        ],
      ));
    }

    return new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: list)
        ]);
  }
  
}