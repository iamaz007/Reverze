import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_icons/flutter_icons.dart';
// import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:neon/neon.dart';

class Menu2 extends StatefulWidget {
  @override
  _Menu2State createState() => _Menu2State();
}

class _Menu2State extends State<Menu2> {
  var selectedTool = '';

  
  @override
  void initState() {
    super.initState();

    
    
  }
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
        body: ListView(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  height: 250.0,
                ),
                
                Positioned(
                  top: 4.0,
                  right: 4.0,
                  child: Container(
                    height: 40.0,
                    width: 40.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.white),
                    child: Center(
                      child: Icon(Icons.menu),
                    ),
                  ),
                ),
                
                Positioned(
                    top: 50.0,
                    left: 40.0,
                    child: Column(
                      children: <Widget>[
                        Text('WELCOME TO',
                            style: TextStyle(
                                fontFamily: 'Oswald',
                                fontSize: 32.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.white))
                      ],
                    )),
                Positioned(
                    top: 95.0,
                    left: 40.0,
                    child: Column(
                      children: <Widget>[
                        
                        Row(
                          children: <Widget>[
                            Neon(
                                text: 'REVERZE',
                                color: Colors.blueGrey,
                                fontSize: 50,
                                font: NeonFont.Membra,
                                flickeringText: true,
                                flickeringLetters: [0,4],
                            ),
                            // Text('REVERZE',
                            //     style: TextStyle(
                            //         fontFamily: 'Lightning',
                            //         fontSize: 50.0,
                            //         fontWeight: FontWeight.bold,
                            //         color: Colors.white)),
                          ],
                        )
                      ],
                    )),
                Positioned(
                    top: 170.0,
                    left: 25.0,
                    right: 25.0,
                    child: Container(
                        height: 50.0,
                        decoration: BoxDecoration(
                            color: Color(0xFF262626),
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(15.0),
                                bottomLeft: Radius.circular(15.0),
                                topLeft: Radius.circular(15.0),
                                topRight: Radius.circular(15.0))),
                        child: TextField(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Search Tools',
                              hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontFamily: 'Montserrat',
                                  fontSize: 12.0),
                              contentPadding: EdgeInsets.only(top: 15.0),
                              prefixIcon: Icon(Icons.search, color: Colors.grey)),
                        )))
              ],
            ),
            //Get out of the stack for the options
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              _buildMenuItem('Image Recognition', Icons.image),
              _buildMenuItem('Augmented Reality', FontAwesome.circle),
              _buildMenuItem('Text to Image', MaterialIcons.all_inclusive),
            ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _buildMenuItem('Image to Text', Icons.format_color_text),
                _buildMenuItem('Image Filters', FontAwesome.filter),
                _buildMenuItem('Image Editor', FontAwesome.photo),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _buildMenuItem('Whatsapp Status', FontAwesome.whatsapp),
                _buildMenuItem('Instagram Scrapper', FontAwesome.instagram),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(String toolName, iconData) {
    return InkWell(
        splashColor: Colors.transparent,
        onTap: () {
          selectMenuOption(toolName);
        },
        child: AnimatedContainer(
            curve: Curves.easeIn,
            duration: Duration(milliseconds: 300),
            height: selectedTool == toolName ? 100.0 : 95.0,
            width: selectedTool == toolName ? 100.0 : 95.0,
            color: selectedTool == toolName
                ? Colors.indigo[400]
                : Colors.transparent,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(
                iconData,
                color: selectedTool == toolName ? Colors.white : Colors.grey,
                size: 30.0,
              ),
              SizedBox(height: 12.0),
              Text(toolName,
              textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'Montserrat',
                      color:
                          selectedTool == toolName ? Colors.white : Colors.grey,
                      fontSize: 13.0))
            ])));
  }

  selectMenuOption(String toolName) {
    setState(() {
      selectedTool = toolName;
    });
  }
}