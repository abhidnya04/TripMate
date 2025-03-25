import 'package:flutter/material.dart';
import '../models/articles.dart';

class ArticlesWidget extends StatelessWidget {
  final List<ArticleModel> articles;

  const ArticlesWidget({Key? key, required this.articles}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // const Padding(
        //   padding: EdgeInsets.only(left: 20),
        //   child: Text(
        //     'Articles & Tips',
        //     style: TextStyle(
        //         color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
        //   ),
        // ),
        const SizedBox(height: 15),
        SizedBox(
          height: 250,
          child: ListView.separated(
            itemCount: articles.length,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            separatorBuilder: (context, index) => const SizedBox(width: 20),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => articles[index].route),
  );
                },
                child: Container(
                  width: 300,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    // boxShadow: [
                    //   BoxShadow(
                    //     color: Colors.grey.withOpacity(0.3),
                    //     blurRadius: 8,
                    //     offset: const Offset(0, 4),
                    //   ),
                    // ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                        child: SizedBox(
                          height: 150,
                          width: double.infinity,
                          child: articles[index].thumbnail,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          articles[index].title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
