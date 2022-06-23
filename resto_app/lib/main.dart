// ignore_for_file: prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lee-Food',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

var bannerItems = ["Riz", "poulet", "Poisson braisé", "Saucise", "Riz assaisonné", "Poulet DG", "Cuisses poulets", "maitre d'oeurvre"];
var bannerImage = [
  "images/slide6.jpg",
  "images/slide4.jpg",
  "images/slide3.jpg",
  "images/slide2.jpg",
  "images/slide5.jpg",
  "images/slide1.jpg",
  "images/slide7.jpg",
  "images/slide8.jpg"
];

class MyHomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    var screenHeigth =MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    // ignore: unused_element

    return Scaffold(
      body: Container(
        height: screenHeigth,
        width: screenWidth,
        child: SafeArea(
          child: SingleChildScrollView(
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.center,
             children: <Widget>[
               Padding(
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                 child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: <Widget>[
                       IconButton(icon: Icon(Icons.menu), onPressed: (){}),
                       Text("Lee-Food", style: TextStyle(fontSize: 25),),
                       IconButton(icon: Icon(Icons.person),onPressed: (){}),
                ],
               ),
               ),
               BannerWidgetArea(),
               Container(
                 child: FutureBuilder(
                   future: DefaultAssetBundle.of(context)
                       .loadString('assets/data.json'),
                   builder: (context, snapshot) {
                     var dataN = jsonDecode(snapshot.data.toString());
                     if (snapshot.hasData) {



                       return ListView.builder(

                         shrinkWrap: true,
                         itemBuilder: (context, index) {
                           String finalString= "";
                           List<dynamic> dataList = dataN[index]["placeItems"];
                           dataList.forEach((item){
                             finalString = finalString + item + " | ";
                           });
                           return Card(
                             child: Column(
                                 crossAxisAlignment:
                                 CrossAxisAlignment.stretch,
                                 children: <Widget>[
                                   Padding(
                                     padding: EdgeInsets.all(8.0),
                                     child: Container(
                                       decoration: BoxDecoration(
                                         color: Colors.white,
                                         borderRadius: BorderRadius.all(
                                             Radius.circular(15)),
                                         boxShadow: [
                                           BoxShadow(
                                             color: Colors.white24,
                                             spreadRadius: 1.0,
                                             blurRadius: 3.0,
                                           )
                                         ],
                                       ),
                                       child: Row(
                                         mainAxisSize: MainAxisSize.max,
                                         crossAxisAlignment: CrossAxisAlignment.start,
                                         children: [
                                           ClipRRect(
                                             borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0),bottomLeft: Radius.circular(10.0)),
                                             child: Image.asset(dataN[index]['placeImage'], width: 100, height: 100, fit: BoxFit.cover,),
                                           ),
                                           SizedBox(
                                             width: 250,
                                             child: Padding(
                                               padding: const EdgeInsets.all(8.0),
                                               child: Column(
                                                 children: <Widget>[
                                                   Text(dataN[index]['placeName'], style: TextStyle(fontSize: 15.0,color: Colors.black87)),
                                                   Text(finalString, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 12.0,color: Colors.black54), maxLines: 1,),
                                                   Text("Prix: ${dataN[index]["Prix"]} Fcfa", style: TextStyle(fontSize: 12.0,color: Colors.black54),)
                                                 ],
                                               ),
                                             ),
                                           )
                                         ],
                                       ),
                                     ),
                                   ),
                                 ]),
                           );
                         },
                         itemCount: dataN == null ? 0 : dataN.length,
                       );
                     } else {
                       return CircularProgressIndicator(
                         color: Colors.black,
                       );
                     }
                   },
                 ),
               )
             ],
           ),
          )),

      ),
      floatingActionButton: FloatingActionButton(onPressed: (){},
          backgroundColor: Colors.black,
      child: Icon(MdiIcons.food,color: Colors.white,)),
    );
  }
}

class BannerWidgetArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    PageController controller = PageController(viewportFraction:0.8,initialPage: 1);

    List<Widget> banners = <Widget>[];

    for(int x=0;x<bannerItems.length;x++){
      var bannerView =
      Padding(padding: EdgeInsets.all(10.0),
      child: Container(
        child: Stack(
        fit: StackFit.expand,
        children: <Widget>[

          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              boxShadow: const [
                BoxShadow(
             color: Colors.black,
             offset: Offset(1.0,1.0),
             blurRadius: 5.0,
             spreadRadius: 1.0
                )
              ]
            ),
          ),

          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            child: Image.asset(
              bannerImage[x],
              fit: BoxFit.cover,
              ),
            ),

          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: const [Colors.transparent,Colors.black])
            ),
          ),
          
          Padding(padding: EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                bannerItems[x],
                style: TextStyle(fontSize: 25.0,color: Colors.white),
              ),
              Text(
                "Nos délices du jour",
                style: TextStyle(fontSize: 12.0, color: Colors.white),
              )
            ],
          ),
          )
          ],
        ),
       ),
      );
      banners.add(bannerView);

    }

    return Container(
      width: screenWidth,
      height: screenWidth*9/16,
      child: PageView(
        controller: controller,
        scrollDirection: Axis.horizontal,
        children: banners,
      ),

    );
  }
}
