import 'package:flutter/material.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final List<String> _categories = [
    "Anime",
    "Horror",
    "Romantic",
    "Science-fiction",
    "Action",
    "Comedy",
    "Documentary",
    "Drama",
    "Fantasy",
    "Mystery",
    "Thriller",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Categories",
          style: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: ListView.builder(
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              _categories[index],
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
            trailing: const Icon(Icons.arrow_circle_right_outlined,
                color: Colors.amber),
            onTap: () {},
          );
        },
        padding: const EdgeInsets.all(8.0),
        itemExtent: 60.0,
      ),
      backgroundColor: Colors.black87,
    );
  }
}
