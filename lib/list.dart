import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:the_lazy_media/gamenews.dart';

const String baseUrl = 'https://the-lazy-media-api.vercel.app/api';

Future<List<GameNews>> fetchGameNews(int page) async {
  return _fetchNews('$baseUrl/games?page=$page');
}

Future<List<GameNews>> searchGameNews(String query) async {
  return _fetchNews('$baseUrl/search?search=$query');
}

Future<List<GameNews>> _fetchNews(String url) async {
  final response = await http.get(Uri.parse(url));
  final Logger logger = Logger();

  if (response.statusCode == 200) {
    final jsonData = json.decode(response.body);
    logger.d(jsonData);

    List<GameNews> gameNewsList = [];
    for (var item in jsonData) {
      final title = item['title'];
      final thumb = item['thumb'];
      const author = Author.teoAriesda;
      const tag = Tag.games;
      final time = item['time'];
      final desc = item['desc'];
      final key = item['key'];

      final gameNews = GameNews(
        title: title,
        thumb: thumb,
        author: author,
        tag: tag,
        time: time,
        desc: desc,
        key: key,
      );

      gameNewsList.add(gameNews);
    }

    return gameNewsList;
  } else {
    logger.e('Failed to load news: ${response.statusCode}');
    throw Exception('Failed to load news');
  }
}
