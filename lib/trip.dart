import 'package:appdev/components/logoutalert.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'components/articles_widget.dart';
import 'components/saved_thumbnails.dart';
import 'models/articles.dart';
import 'models/saved.dart';
// import 'saved_itineraries.dart';

class Trip extends StatefulWidget {
  const Trip({Key? key}) : super(key: key);

  @override
  State<Trip> createState() => _TripState();
}

class _TripState extends State<Trip> {
  late List<SavedModel> categories;
  late List<ArticleModel> articles;

  @override
  void initState() {
    super.initState();
    categories = SavedModel.getCategories();
    articles = ArticleModel.getArticles();
  }
  
    final supabase = Supabase.instance.client;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(size: 30),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        actions: const [Icon(Icons.notifications_on)],
        centerTitle: true,
        title: const Text("Trip"),
        leading: GestureDetector(
            onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => logotalert(),
                        );
                      },
            child: const Icon(Icons.power_settings_new)),
      ),
      body: ListView(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: SearchBar(
                  // backgroundColor: ,
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                  leading: const Icon(Icons.search),
                  // backgroundColor: MaterialStateProperty.all(Colors.white),
                  hintText: "Where can we take you?",
                ),
              ),
            ],
          ),
          SavedItineraries(categories: categories),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Travel Stories",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  "Top stories from around the world!",
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w300),
                ),
                ArticlesWidget(articles: articles),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
