import 'package:flutter/material.dart';
import 'package:filmfolio/src/models/movie.dart';

class MovieItem extends StatelessWidget {
  final Movie movie;

  const MovieItem({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[900],
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            (movie.images != null && movie.images!.isNotEmpty)
                ? movie.images![0]  // Safely access the first image
                : 'assets/images/placeholder.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: 200.0,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.name ?? 'unknown',
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  'Director: ${movie.director}',
                  style: const TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 4.0),
                Text(
                  'Type: ${movie.type}',
                  style: const TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 4.0),
                Text(
                  'Rating: ${movie.rating}/10',
                  style: const TextStyle(color: Colors.amber),
                ),
                const SizedBox(height: 8.0),
                Text(
                  movie.description ?? 'write',
                  style: const TextStyle(color: Colors.white70),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
