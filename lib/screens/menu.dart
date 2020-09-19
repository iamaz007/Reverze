import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:auto_animated/auto_animated.dart';
import 'package:reverze/elements/utils.dart';


class MainMenu extends StatefulWidget {
  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  int itemsCount = 20;
  bool isReady;
  var spinkit = SpinKitDualRing(
    color: Colors.grey,
    size: 50.0,
  );

  void initState(){
    super.initState();
    isReady=false;
    Timer(
      Duration(seconds: 3),
      (){
      setState(() {
        isReady=true;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
            colors: [
              // Colors.transparent,
              Hexcolor("#0d0c0f"),
              Hexcolor("#241d33"),
            ],
          begin: const FractionalOffset(1.0, 2.0),
          end: const FractionalOffset(1.0, 0.0),
          stops: [0.0, 1.0],
          tileMode: TileMode.clamp),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text('REVERZE', style: TextStyle(color: Colors.white, fontFamily: 'Lightning',),),
          actions: <Widget>[
            Icon(Icons.help_outline)
          ],
        ),
        drawer: Drawer(),
        body: isReady==false 
        ? Align(child: spinkit, alignment: Alignment.center,) 
        : LiveGrid(
            padding: EdgeInsets.all(16),
            showItemInterval: Duration(milliseconds: 50),
            showItemDuration: Duration(milliseconds: 150),
            visibleFraction: 0.001,
            itemCount: itemsCount,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemBuilder: animationItemBuilder(
                (index) => HorizontalItem(title: index.toString())),
          ),
      ),
    );
  }
}