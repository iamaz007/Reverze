import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:flutter_insta/flutter_insta.dart';


class InstaProfileGet extends StatefulWidget {
  @override
  _InstaProfileGetState createState() => _InstaProfileGetState();
}

class _InstaProfileGetState extends State<InstaProfileGet>
    with SingleTickerProviderStateMixin {
  FlutterInsta flutterInsta =
      FlutterInsta(); // create instance of FlutterInsta class
  TextEditingController usernameController = TextEditingController();
  TextEditingController reelController = TextEditingController();
  TabController tabController;

  String username, followers = " ", following, bio, website, profileImage;
  bool pressed = false;
  bool downloading = false;

  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, initialIndex: 1, length: 2);
    // downloadReels();
  }


  void downloadReels() async {
    var s = await flutterInsta
        .downloadReels("https://www.instagram.com/p/CDlGkdZgB2y");
    print(s);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Package example app'),
        bottom: TabBar(
          controller: tabController,
          tabs: [
            Tab(
              text: "Home",
            ),
            Tab(
              text: "Reels",
            )
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          homePage(), // home screen
          reelPage()
        ],
      ),
    );
  }

//get data from api
  Future printDetails(String username) async {
    await flutterInsta.getProfileData(username);
    setState(() {
      this.username = flutterInsta.username; //username
      this.followers = flutterInsta.followers; //number of followers
      this.following = flutterInsta.following; // number of following
      this.website = flutterInsta.website; // bio link
      this.bio = flutterInsta.bio; // Bio
      this.profileImage = flutterInsta.imgurl; // Profile picture URL
      print("profile url: ${this.profileImage}");
      download(this.profileImage);
    });
  }

  Widget homePage() {
    return Center(
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(contentPadding: EdgeInsets.all(10)),
            controller: usernameController,
          ),
          RaisedButton(
            child: Text("Print Details"),
            onPressed: () async {
              setState(() {
                pressed = true;
              });
              printDetails(usernameController.text); //get Data
            },
          ),
          pressed
              ? SingleChildScrollView(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Card(
                      child: Container(
                        margin: EdgeInsets.all(15),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 10),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.network(
                                "$profileImage",
                                width: 120,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10),
                            ),
                            Text(
                              "$username",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  "$followers\nFollowers",
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                                Text(
                                  "$following\nFollowing",
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10),
                            ),
                            Text(
                              "$bio",
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                            Padding(padding: EdgeInsets.only(top: 10)),
                            Text(
                              "$website",
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

//Reel Downloader page
  Widget reelPage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        TextField(
          controller: reelController,
        ),
        RaisedButton(
          onPressed: () {
            setState(() {
              downloading = true; //set to true to show Progress indicator
            });
            // download();
          },
          child: Text("Download"),
        ),
        downloading
            ? Center(
                child:
                    CircularProgressIndicator(), //if downloading is true show Progress Indicator
              )
            : Container()
      ],
    );
  }

//Download reel video on button clickl
  void download(link) async {
    try {
      // Saved with this method.
      var imageId = await ImageDownloader.downloadImage(link);
      if (imageId == null) {
        return;
      }

      // Below is a method of obtaining saved image information.
      var fileName = await ImageDownloader.findName(imageId);
      var path = await ImageDownloader.findPath(imageId);
      var size = await ImageDownloader.findByteSize(imageId);
      var mimeType = await ImageDownloader.findMimeType(imageId);
    } on PlatformException catch (error) {
      print(error);
    }
  }
}