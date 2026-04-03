// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import '../models/news_model.dart';
import '../services/api_service.dart';
import '../widgets/news_tile.dart';
import 'detail_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<NewsModel>> newsFuture;
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    newsFuture = ApiService.fetchNews();
  }

  void searchNews() {
    setState(() {
      newsFuture = ApiService.fetchNews(
        query: controller.text.isEmpty ? "india" : controller.text,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("News App")),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      hintText: "Search news...",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: searchNews,
                )
              ],
            ),
          ),

          Expanded(
            child: FutureBuilder<List<NewsModel>>(
              future: newsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text("Error loading news"));
                }

                final news = snapshot.data!;

                return ListView.builder(
                  itemCount: news.length,
                  itemBuilder: (context, index) {
                    return NewsTile(
                      news: news[index],
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => DetailScreen(news: news[index]),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}