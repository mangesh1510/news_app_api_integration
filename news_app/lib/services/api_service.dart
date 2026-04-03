// lib/services/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/news_model.dart';
import '../utils/constants.dart';

class ApiService {
  static Future<List<NewsModel>> fetchNews({String query = "india"}) async {
    final url = Uri.parse(
      "https://newsapi.org/v2/everything?q=$query&apiKey=$apiKey"
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List articles = data['articles'];

      return articles.map((e) => NewsModel.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load news");
    }
  }
}