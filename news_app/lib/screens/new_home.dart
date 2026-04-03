import 'package:flutter/material.dart';
import 'package:news_app/widgets/new_tile.dart';
import '../models/news_model.dart';
import '../services/api_service.dart';
import '../widgets/news_tile.dart';
import 'detail_screen.dart';

class HomeScreens extends StatefulWidget {
  @override
  State<HomeScreens> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreens> {
  late Future<List<NewsModel>> newsFuture;
  TextEditingController controller = TextEditingController();

  List<String> categories = ["All", "Tech", "Sports", "Business"];
  String selectedCategory = "All";

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

  void selectCategory(String category) {
    setState(() {
      selectedCategory = category;
      newsFuture = ApiService.fetchNews(query: category);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "📰 NewsApp",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          Icon(Icons.notifications_none, color: Colors.black)
        ],
      ),

      body: Column(
        children: [

          // 🔍 Search Bar
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: "Search news...",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              onSubmitted: (_) => searchNews(),
            ),
          ),

          // 📂 Categories
          Container(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: categories.map((cat) {
                return GestureDetector(
                  onTap: () => selectCategory(cat),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 8),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: selectedCategory == cat
                          ? Colors.blue
                          : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        cat,
                        style: TextStyle(
                          color: selectedCategory == cat
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          // 📰 News List
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
                    return NewsCard(
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