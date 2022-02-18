import 'package:flutter/material.dart';

class HomePageCard extends StatelessWidget {
  final imageurl, time, subtitle, title;

  const HomePageCard(
      {Key key,
      this.imageurl = "assets/image/cardimage.png",
      this.title =
          "Watch: Gameplay for the first 13 games optimised for Xbox Series X",
      this.time = "07 Mar  07:19",
      this.subtitle =
          "Microsoft showcased 13 games, with their gameplay trailers, that will come to Xbox Series X with optimisations.",
      imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 203,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Color(0xff707070),
                width: 1,
              ),
              image: DecorationImage(
                  image: NetworkImage(imageurl), fit: BoxFit.fill),
            ),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(11),
                      color: Colors.black.withOpacity(0.33),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Center(
                      // ignore: prefer_const_constructors
                      child: Text(
                        title,
                        style: TextStyle(
                            fontFamily: "Avenir",
                            fontSize: 16,
                            color: Colors.white),
                        maxLines: 3,
                        overflow: TextOverflow.fade,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    time,
                    style: TextStyle(
                        fontFamily: "Times", color: Color(0xff8a8989)),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Text(
                    title,
                    style: TextStyle(
                      fontFamily: "Legacy",
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
