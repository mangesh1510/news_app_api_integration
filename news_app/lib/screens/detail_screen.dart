import 'package:flutter/material.dart';
import '../models/news_model.dart';
import 'webview_screen.dart';

class DetailScreen extends StatelessWidget {
  final NewsModel news;

  const DetailScreen({required this.news});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("News Detail")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (news.imageUrl.isNotEmpty)
              Image.network(news.imageUrl),

            Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                news.title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.all(16),
              child: Text(news.description),
            ),

            SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => WebViewScreen(url: news.url),
                  ),
                );
              },
              child: Text("Read Full Article"),
            ),
          ],
        ),
      ),
    );
  }
}