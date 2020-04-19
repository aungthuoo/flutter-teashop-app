/**
 * Author: Damodar Lohani
 * profile: https://github.com/lohanidamodar
  */
  
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teashop/confirm_order.dart';
import 'assets/assets.dart';
import './recipe_details.dart';
import './network_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

import 'bloc/post_bloc.dart';



class RecipeSinglePage extends StatelessWidget {
  static final String path = "lib/src/pages/food/recipe_single.dart";
  final Color icon = Color(0xffEF412D);
  final Color color1 = Color(0xffCF3529);
  final Color color2 = Color(0xffE1372F);
  final Color color3 = Color(0xffFF6C1C);



  List<GroupModel> _group = [
    GroupModel(
      text: "ဘဲဥနဲ့",
      index: 1,
    ),
    GroupModel(
      text: "ပဲသွေးနဲ့",
      index: 2,
    ),
    GroupModel(
      text: "ဗူးသီးကြော်နဲ့",
      index: 3,
    ),
    
  ];



  @override
  Widget build(BuildContext context){
    double screenWidth = (MediaQuery.of(context).size.width / 2)  - 30 ;
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
            if (state is PostLoaded) {





              return Scaffold(
                body: Container(
                  height: double.infinity,
                  child: Stack(
                    children: <Widget>[
                   
                      Positioned(
                        top: 350,
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Container(
                          height: 200,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [color2, color3],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter
                            )
                          ),
                        )
                      ),
                      /*
                      Positioned(
                        top: 350,
                        left: 0,
                        right: 150,
                        bottom: 80,
                        child: Container(
                          height: 200,
                          decoration: BoxDecoration(
                            color: color1,
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(50.0)
                            )
                          ),
                        )
                      ),
                      */
                      
                      Container(
                        decoration: BoxDecoration(
                            color: color1,
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(50.0)
                            )
                          ),
                        child: CustomScrollView(
                          slivers: <Widget>[
                            SliverToBoxAdapter(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                
                                Container(
                                  height: 380,
                                  alignment: Alignment.topCenter,
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black38,
                                        blurRadius: 30.0
                                      )
                                    ]
                                  ),
                                  child: SizedBox(
                                    height: 350,
                                    child: PNetworkImage('https://softwarezay.com/sample_images/teashop/most_orders/mohinga.jpeg', fit: BoxFit.cover,),
                                  ),
                                ),
                              ],
                            )),
                            SliverList(
                              delegate: SliverChildListDelegate(
                                [
                                  Container(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text("မုန့်ဟင်းခါး".toUpperCase(), style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 25.0
                                        ),),
                                        //SizedBox(height: 20.0),
                                        Text("Ks.500", style: TextStyle(color: Colors.white70, fontSize: 20.0),),
                                      
                                        
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
                                    padding: const EdgeInsets.all(0.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        SizedBox(
                                          //height: 30.0,
                                          width: double.infinity,
                                          child: Column(
                                            children: _group
                                                .map((t) => RadioListTile(
                                                      title: Text("${t.text}", style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.w400,
                                                        fontSize: 14.0
                                                      )),
                                                      groupValue: 1,
                                                      value: t.index,
                                                      onChanged: (val) {
                                                        
                                                      },
                                                    ))
                                                .toList(),
                                          )
                                      
                                        )
                                      ],
                                    ),
                                  ),
                                  
                                ],
                              ),
                            ),
                          ]
                        ),
                      ),

                      Positioned(
                        top: 50,
                        right: 20,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 25,
                          child: IconButton(
                            color: icon,
                            onPressed: (){},
                            icon: Icon(Icons.favorite,)),
                        ),
                      ),
                      
                      Positioned(
                        bottom: 10,
                        right: 20,
                        child: RaisedButton(
                          child: Text("ပေါင်းထည့်မည်".toUpperCase()),
                          color: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                          onPressed: (){
                            /*
                            Navigator.push(context, MaterialPageRoute(
                              builder: (_) => RecipeDetailsPage()
                            ));
                            */
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ConfirmOrderPage()));
                          },
                        ),
                      ),
                      Container(height: 70.0, child: AppBar(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                      )),
                            
                      /*
                      Positioned(
                        top: 350,
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Container(
                          height: 200,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [color2, color3],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter
                            )
                          ),
                        )
                      ),
                      Positioned(
                        top: 350,
                        left: 0,
                        right: 150,
                        bottom: 80,
                        child: Container(
                          height: 200,
                          decoration: BoxDecoration(
                            color: color1,
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(50.0)
                            )
                          ),
                        )
                      ),
                      Positioned(
                        top: 350,
                        left: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(height: 40.0),
                              Text("မုန့်ဟင်းခါး".toUpperCase(), style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 30.0
                              ),),
                              //SizedBox(height: 20.0),
                              Text("Ks.500", style: TextStyle(color: Colors.white70, fontSize: 20.0),),
                            
                              SizedBox(
                                //height: 30.0,
                                width: double.infinity,
                                
                                
                                child: Row(
                                  children: <Widget>[
                                    Icon(FontAwesomeIcons.fire, color: Colors.white),
                                    SizedBox(width: 5.0),
                                    Text("65%",style: TextStyle(color: Colors.white,fontSize: 18.0),),
                                    Spacer(),
                                    VerticalDivider(color: Colors.white),
                                    Spacer(),
                                    Text("Vegetarian",style: TextStyle(color: Colors.white, fontSize: 18.0),),
                                    Spacer(),
                                    VerticalDivider(color: Colors.white),
                                    Spacer(),
                                    Icon(FontAwesomeIcons.stopwatch, color: Colors.white),
                                    SizedBox(width: 5.0),
                                    Text("10 min",style: TextStyle(color: Colors.white, fontSize: 18.0),),
                                  ],
                                ),
                              
                              )
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 350,
                        left: screenWidth,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(height: 40.0),
                              
                              SizedBox(
                                //height: 30.0,
                                width: double.infinity,
                                child: Column(
                                  children: _group
                                      .map((t) => RadioListTile(
                                            title: Text("${t.text}", style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14.0
                                            )),
                                            groupValue: 1,
                                            value: t.index,
                                            onChanged: (val) {
                                              
                                            },
                                          ))
                                      .toList(),
                                ),
                              
                                child: Row(
                                  children: <Widget>[
                                    Icon(FontAwesomeIcons.fire, color: Colors.white),
                                    SizedBox(width: 5.0),
                                    Text("65%",style: TextStyle(color: Colors.white,fontSize: 18.0),),
                                    Spacer(),
                                    VerticalDivider(color: Colors.white),
                                    Spacer(),
                                    Text("Vegetarian",style: TextStyle(color: Colors.white, fontSize: 18.0),),
                                    Spacer(),
                                    VerticalDivider(color: Colors.white),
                                    Spacer(),
                                    Icon(FontAwesomeIcons.stopwatch, color: Colors.white),
                                    SizedBox(width: 5.0),
                                    Text("10 min",style: TextStyle(color: Colors.white, fontSize: 18.0),),
                                  ],
                                ),
                            
                              )
                            ],
                          ),
                        ),
                      ),

                      
                      Container(
                        height: 380,
                        alignment: Alignment.topCenter,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black38,
                              blurRadius: 30.0
                            )
                          ]
                        ),
                        child: SizedBox(
                          height: 350,
                          child: PNetworkImage('https://softwarezay.com/sample_images/teashop/most_orders/mohinga.jpeg', fit: BoxFit.cover,),
                        ),
                      ),
                    
                      Positioned(
                        top: 325,
                        left: 20,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 25,
                          child: IconButton(
                            color: icon,
                            onPressed: (){},
                            icon: Icon(Icons.play_arrow,)),
                        ),
                      ),
                      Positioned(
                        top: 325,
                        right: 20,
                        child: RaisedButton(
                          child: Text("Read More".toUpperCase()),
                          color: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(
                              builder: (_) => RecipeDetailsPage()
                            ));
                          },
                        ),
                      ),
                      Container(height: 70.0, child: AppBar(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                      )),
                      */
                    ],
                  ),
                ),
              );
            }
          }
        )
    );



    
    return Scaffold(
      body: Container(
        height: double.infinity,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 350,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [color2, color3],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter
                  )
                ),
              )
            ),
            Positioned(
              top: 350,
              left: 0,
              right: 150,
              bottom: 80,
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  color: color1,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(50.0)
                  )
                ),
              )
            ),
            Positioned(
              top: 350,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 40.0),
                    Text("မုန့်ဟင်းခါး".toUpperCase(), style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 30.0
                    ),),
                    //SizedBox(height: 20.0),
                    Text("Ks.500", style: TextStyle(color: Colors.white70, fontSize: 20.0),),
                   
                    SizedBox(
                      //height: 30.0,
                      width: double.infinity,
                      
                      /*
                      child: Row(
                        children: <Widget>[
                          Icon(FontAwesomeIcons.fire, color: Colors.white),
                          SizedBox(width: 5.0),
                          Text("65%",style: TextStyle(color: Colors.white,fontSize: 18.0),),
                          Spacer(),
                          VerticalDivider(color: Colors.white),
                          Spacer(),
                          Text("Vegetarian",style: TextStyle(color: Colors.white, fontSize: 18.0),),
                          Spacer(),
                          VerticalDivider(color: Colors.white),
                          Spacer(),
                          Icon(FontAwesomeIcons.stopwatch, color: Colors.white),
                          SizedBox(width: 5.0),
                          Text("10 min",style: TextStyle(color: Colors.white, fontSize: 18.0),),
                        ],
                      ),
                      */
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              top: 350,
              left: screenWidth,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 40.0),
                    
                    SizedBox(
                      //height: 30.0,
                      width: double.infinity,
                      child: Column(
                        children: _group
                            .map((t) => RadioListTile(
                                  title: Text("${t.text}", style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14.0
                                  )),
                                  groupValue: 1,
                                  value: t.index,
                                  onChanged: (val) {
                                    
                                  },
                                ))
                            .toList(),
                      ),
                      /*
                      child: Row(
                        children: <Widget>[
                          Icon(FontAwesomeIcons.fire, color: Colors.white),
                          SizedBox(width: 5.0),
                          Text("65%",style: TextStyle(color: Colors.white,fontSize: 18.0),),
                          Spacer(),
                          VerticalDivider(color: Colors.white),
                          Spacer(),
                          Text("Vegetarian",style: TextStyle(color: Colors.white, fontSize: 18.0),),
                          Spacer(),
                          VerticalDivider(color: Colors.white),
                          Spacer(),
                          Icon(FontAwesomeIcons.stopwatch, color: Colors.white),
                          SizedBox(width: 5.0),
                          Text("10 min",style: TextStyle(color: Colors.white, fontSize: 18.0),),
                        ],
                      ),
                      */
                    )
                  ],
                ),
              ),
            ),
            Container(
              height: 380,
              alignment: Alignment.topCenter,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black38,
                    blurRadius: 30.0
                  )
                ]
              ),
              child: SizedBox(
                height: 350,
                child: PNetworkImage('https://softwarezay.com/sample_images/teashop/most_orders/mohinga.jpeg', fit: BoxFit.cover,),
              ),
            ),
            Positioned(
              top: 325,
              left: 20,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 25,
                child: IconButton(
                  color: icon,
                  onPressed: (){},
                  icon: Icon(Icons.play_arrow,)),
              ),
            ),
            Positioned(
              top: 325,
              right: 20,
              child: RaisedButton(
                child: Text("Read More".toUpperCase()),
                color: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(
                    builder: (_) => RecipeDetailsPage()
                  ));
                },
              ),
            ),
            Container(height: 70.0, child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
            )),
          ],
        ),
      ),
    );
  }
}



class GroupModel {
  String text;
  int index;
  GroupModel({this.text, this.index});
}
