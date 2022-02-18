// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:lah/models/category_models.dart';
import 'package:lah/reusable/custom_card.dart';
import 'package:lah/utils.dart';

class HomePage extends StatefulWidget {
  final Map<String, List> newsData;

  const HomePage({Key key, this.newsData}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  ScrollController _scrollController;
  TabController _tabController;
  int currentIndex = 0;
  Map<String, List> _newsData = Map<String, List>();
  _smoothScrollToTop() {
    _scrollController.animateTo(0,
        duration: Duration(microseconds: 300), curve: Curves.ease);
  }

  void changePage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController = ScrollController();
    _tabController = TabController(length: categories.length, vsync: this);
    _tabController.addListener(_smoothScrollToTop());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _tabController.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (context, value) {
          return [
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(25, 10, 25, 25),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Top News",
                    style: TextStyle(
                      fontFamily: "Timws",
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.only(left: 25),
                alignment: Alignment.centerLeft,
                child: TabBar(
                  labelPadding: EdgeInsets.only(right: 15),
                  indicatorSize: TabBarIndicatorSize.label,
                  controller: _tabController,
                  isScrollable: true,
                  indicator: UnderlineTabIndicator(),
                  labelColor: Colors.black,
                  labelStyle: TextStyle(
                    fontFamily: "Avenir",
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                  unselectedLabelColor: Colors.black45,
                  unselectedLabelStyle: TextStyle(
                      fontFamily: "Avenir",
                      fontSize: 18,
                      fontWeight: FontWeight.normal),
                  tabs: List.generate(categories.length,
                      (index) => Text(categories[index].name)),
                ),
              ),
            )
          ];
        },
        body: Container(
          child: TabBarView(
              controller: _tabController,
              children: List.generate(categories.length, (index) {
                var key = categories[index]
                    .imageUrl
                    .toString()
                    .split('/')[3]
                    .split('_')[0]
                    .replaceAll("_", "-");
                return ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  itemBuilder: (context, i) {
                    String time = widget.newsData[key][i]['pubdata']['_cdata'];
                    DateTime timelist = DateTime.parse(time.split(' ')[3] +
                        "-" +
                        getMonthNumberFromName(month: time.split('')[2]) +
                        " " +
                        time.split(" ")[1] +
                        " " +
                        time.split(" ")[4]);
                    timelist = timelist
                        .add(Duration(hours: 5))
                        .add(Duration(minutes: 30));
                    return HomePageCard(
                      title: _newsData[key][i]['title']['_cdata'],
                      subtitle: _newsData[key][i]['description']['_cdata'],
                      imageurl: _newsData[key][i][r'media$content']['url'],
                      time: timelist.day.toString() +
                          " " +
                          getMonthNumberInWords(month: timelist.month) +
                          " " +
                          timelist.toString().split("")[1].substring(0, 5),
                    );
                  },
                  itemCount: _newsData[key]?.length ?? 0,
                );
              })),
        ));
  }
}
