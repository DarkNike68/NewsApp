// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lah/backend/rss_to_json.dart';
import 'package:lah/screen/home/homePage.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;

  void changePage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  Map<String, List> newsData = Map<String, List>();
  bool isLoading = true;

  getData() async {
    Future.wait([
      rssToJson('topnews'),
      rssToJson('indonesia'),
      rssToJson('world-news'),
      rssToJson('business'),
      rssToJson('sports'),
      rssToJson('bola'),
      rssToJson('education'),
      rssToJson('entertainment'),
      rssToJson('lifestyle'),
      rssToJson('health'),
      rssToJson('books'),
      rssToJson('trending'),
    ]).then((value) {
      value[0] = [];
      for (var element in value) {
        value[0].addAll([...element]);
      }
      value[0].shuffle();
      newsData['topnews'] = value[0].sublist(0, 10);
      newsData['indonesia'] = value[1];
      newsData['world'] = value[2];
      newsData['business'] = value[3];
      newsData['sports'] = value[4];
      newsData['bola'] = value[5];
      newsData['education'] = value[6];
      newsData['entertainment'] = value[7];
      newsData['lifestyle'] = value[8];
      newsData['health-fitness'] = value[9];
      newsData['books'] = value[10];
      newsData['its-viral'] = value[11];
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Builder(
            builder: (context) => IconButton(
              icon: SvgPicture.asset("assets/icons/drawer.svg"),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
        ),
        backgroundColor: currentIndex == 3 ? Color(0xffF7F8FA) : Colors.white,
        elevation: 0,
        centerTitle: false,
        titleSpacing: 0,
      ),
      drawer: Container(
        width: MediaQuery.of(context).size.width / 1.25,
        child: Drawer(
          child: Column(
            children: <Widget>[
              SizedBox(height: 30),
              DrawerHeader(
                child: Container(
                  height: 140,
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset(""),
                ),
                decoration: BoxDecoration(color: Colors.transparent),
              ),
              SizedBox(height: 45),
              Text(
                'Setting',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 45),
              Text(
                'About',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 45),
              Text(
                'Log Out',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 45),
              Material(
                borderRadius: BorderRadius.circular(500),
                child: InkWell(
                  borderRadius: BorderRadius.circular(500),
                  splashColor: Colors.black45,
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.black,
                    child: Icon(Icons.arrow_back_rounded, color: Colors.white),
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 65,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.black,
                    child: Center(
                      child: Text(
                        'Alpha 1.0',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: <Widget>[
        HomePage(
          newsData: newsData,
        ),
        Container(
          color: Colors.red,
        ),
        Container(
          color: Colors.yellow,
        ),
        Container(
          color: Colors.green,
        ),
      ][currentIndex],
      bottomNavigationBar: BubbleBottomBar(
        opacity: 0,
        currentIndex: currentIndex,
        onTap: changePage,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        elevation: 8,
        hasNotch: true,
        hasInk: true,
        inkColor: Colors.black12,
        items: <BubbleBottomBarItem>[
          BubbleBottomBarItem(
              backgroundColor: Colors.red,
              icon: Icon(
                Icons.dashboard_rounded,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.dashboard_rounded,
                color: Colors.red,
              ),
              title: Text("News")),
          BubbleBottomBarItem(
              backgroundColor: Colors.deepPurple,
              icon: Icon(
                Icons.menu_book_rounded,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.menu_book_rounded,
                color: Colors.deepPurple,
              ),
              title: Text("Book")),
          BubbleBottomBarItem(
              backgroundColor: Colors.indigo,
              icon: Icon(
                Icons.monetization_on,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.monetization_on,
                color: Colors.indigo,
              ),
              title: Text("Coin")),
          BubbleBottomBarItem(
              backgroundColor: Colors.green,
              icon: Icon(
                Icons.person_rounded,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.person_rounded,
                color: Colors.green,
              ),
              title: Text("Account")),
        ],
      ),
    );
  }
}
