// lib/widgets/news_tile.dart
import 'package:flutter/material.dart';
import '../models/news_model.dart';

class NewsTile extends StatelessWidget {
  final NewsModel news;
  final VoidCallback onTap;

  const NewsTile({required this.news, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: ListTile(
        leading: news.imageUrl.isNotEmpty
            ? Image.network(news.imageUrl, width: 80, fit: BoxFit.cover)
            : null,
        title: Text(news.title),
        subtitle: Text(news.description),
        onTap: onTap,
      ),
    );
  }
}