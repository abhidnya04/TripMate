import 'package:flutter/material.dart';

class ArticleModel {
  final String title;
  final Image thumbnail;

  ArticleModel({required this.title, required this.thumbnail});

  static List<ArticleModel> getArticles() {
    return [
      ArticleModel(
        title: "Exploring the Ancient Temples of Kyoto, Japan",
        thumbnail: Image.asset('assets/kyoto.jpg', fit: BoxFit.cover),
      ),
      ArticleModel(
        title: "Art and Tradition: Exploring Bali's Cultural Scene",
        thumbnail: Image.asset('assets/bali.jpg', fit: BoxFit.cover),
      ),
      ArticleModel(
        title: "Essential Tips for Exploring Lombok Like a Local",
        thumbnail: Image.asset('assets/lombok.jpg', fit: BoxFit.cover),
      ),
      ArticleModel(
        title: "Discover the Serenity of Maldives: A Paradise Unveiled",
        thumbnail: Image.asset('assets/maldives.jpg', fit: BoxFit.cover),
      ),
    ];
  }
}
