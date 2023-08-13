import 'package:flutter/material.dart';
import 'package:the_lazy_media/gamenews.dart';

class GameNewsDetail extends StatelessWidget {
  final GameNews gameNews;

  const GameNewsDetail({super.key, required this.gameNews});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(gameNews.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.network(
                  gameNews.thumb,
                  fit: BoxFit.fitWidth,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              const SizedBox(height: 16.0),
              Text(
                gameNews.title,
                style: const TextStyle(
                    fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),
              Text(
                gameNews.desc,
                style: const TextStyle(fontSize: 16.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
