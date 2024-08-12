import 'package:filmfolio/src/models/movie.dart';
import 'package:flutter/material.dart';

class MovieDetailScreen extends StatelessWidget {
  final Movie movie;

  const MovieDetailScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          movie.name,
          style: const TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black.withOpacity(0.8),
        elevation: 4.0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.amber,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset(
                        movie.images.isNotEmpty
                            ? movie.images[0]
                            : 'assets/images/placeholder.png',
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 250.0,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      movie.name,
                      style: const TextStyle(
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Director: ${movie.director}',
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Type: ${movie.type}',
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Rating: ${movie.rating}/10',
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Colors.amber,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      movie.description,
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 24.0),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
