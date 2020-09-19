import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reverze/elements/quotes.dart';
import 'package:reverze/screens/menu.dart';
import 'package:video_player/video_player.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:shimmer/shimmer.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  VideoPlayerController _controller;
  bool _visible=false;
  int quoteIndex=0;
  Random rand = new Random();
  @override
  void initState() {
    _controller = VideoPlayerController.asset("assets/splash/bg.mp4");
    _controller.initialize().then((_) {
      _controller.setLooping(true);
      Timer(Duration(milliseconds: 100), () {
        setState(() {
          _controller.play();
          _visible = true;
        });
      });
    });

    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    // print(quotes.length);
    quoteIndex=rand.nextInt(300);
    Timer(
        Duration(seconds: 7),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => MainMenu())));
  }

  @override
  void dispose() {
  super.dispose();
  if (_controller != null) {
    _controller.dispose();
    _controller = null;
  }
}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: <Widget>[
            _getVideoBackground(),
            _getBackgroundColor(),
            _getContent(),
          ],
        ),
      ),
    );
  }

  _getVideoBackground() {
    return Container(
      // height: MediaQuery.of(context).size.height/2,
      child: AnimatedOpacity(
        opacity: _visible ? 1.0 : 0.0,
        duration: Duration(milliseconds: 1000),
        child: VideoPlayer(_controller),
      ),
    );
  }

  _getBackgroundColor() {
    return Container(
      decoration: new BoxDecoration(
            gradient: new LinearGradient(
                colors: [
                  // Colors.transparent,
                  Hexcolor("#35225c"),
                  Hexcolor("#210038").withAlpha(200),
                ],
              begin: const FractionalOffset(1.0, 1.0),
              end: const FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp),
          ),
    );
  }

  _getContent() {
    return Stack(
      // crossAxisAlignment: CrossAxisAlignment.center,
      // mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: 50.0,
        ),
        new Align(
          alignment: FractionalOffset.center,
          child: Shimmer.fromColors(
            baseColor: Colors.white,
            highlightColor: Hexcolor('#1d0030'),
            child: GlowText(
            'REVERZE',
              style: TextStyle(color: Colors.white,  fontSize: 50, fontFamily: 'Lightning',),
            ),
          )
        ),

        Container(
          margin: const EdgeInsets.only(top: 100.0),
          child: new Align(
            alignment: FractionalOffset.center,
            child: Text( "A TOOL FOR IMAGE MANIPULATION",
          style: TextStyle(color: Colors.grey, fontSize: 15, fontFamily: 'Montserrat'),
              ),
            ),
        ),

        Container(
          margin: const EdgeInsets.only(bottom: 70.0),
          child: new Align(
            alignment: FractionalOffset.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text( "“${quotes[quoteIndex]['text']}”",
                    style: TextStyle(color: Colors.grey, fontSize: 18, fontFamily: 'Montserrat'),
                    textAlign: TextAlign.center,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text( "- ${quotes[quoteIndex]['from']}",
                        style: TextStyle(color: Colors.grey, fontSize: 15, fontFamily: 'Montserrat'),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        )

      ],
    );
  }
}

class LoginWidget extends StatelessWidget {
  const LoginWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Container(),
        Container(
          padding: EdgeInsets.all(16),
          width: 300,
          height: 200,
          color: Colors.grey.withAlpha(200),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                  hintText: 'Username',
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Password',
                ),
              ),
              RaisedButton(
                child: Text('Login'),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}