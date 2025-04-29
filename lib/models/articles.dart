import 'package:appdev/pages/articles/bali.dart';
import 'package:appdev/pages/articles/kyoto_article.dart';
import 'package:appdev/pages/articles/maldives.dart';
import 'package:appdev/pages/articles/ny.dart';
import 'package:flutter/material.dart';

class ArticleModel {
  final String title;
  final Image thumbnail;
  final Widget route;

  ArticleModel({required this.title, required this.thumbnail, required this.route});

  static List<ArticleModel> getArticles() {
    return [
      ArticleModel(
        title: "Exploring the Ancient Temples of Kyoto, Japan",
        thumbnail: Image.asset('assets/kyoto.jpg', fit: BoxFit.cover),
        route: KyotoArticle()
      ),
      ArticleModel(
        title: "New York: The City That Never Sleeps",
        thumbnail: Image.asset('assets/lombok.jpg', fit: BoxFit.cover),
        route: NewYorkArticle()

      ),
      ArticleModel(
        title: "Art and Tradition: Exploring Bali's Cultural Scene",
        thumbnail: Image.asset('assets/bali.jpg', fit: BoxFit.cover),
        route: BaliArticle()

      ),
      ArticleModel(
        title: "Discover the Serenity of Maldives: A Paradise Unveiled",
        thumbnail: Image.asset('assets/maldives.jpg', fit: BoxFit.cover),
        route: MaldivesArticle()

      ),
    ];
  }
}
