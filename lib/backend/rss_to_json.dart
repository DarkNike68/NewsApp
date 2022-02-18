import 'dart:convert';

import 'package:xml2json/xml2json.dart';
import 'package:http/http.dart' as http;

Future<List> rssToJson(String category,
    {String baseUrl = 'https://www.cnnindonesia.com/nasional/rss'}) async {
  var client = http.Client();
  final myTranformer = Xml2Json();
  return await client
      .get(Uri.parse(baseUrl + category + '/rssfeed.xml'))
      .then((Response) {
    return Response.body;
  }).then((bodyString) {
    myTranformer.parse(bodyString);
    var json = myTranformer.toGData();
    return jsonDecode(json)['rss']['channel']['item'];
  });
}
