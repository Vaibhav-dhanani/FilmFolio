import 'package:filmfolio/src/models/movie.dart';
import 'package:flutter/material.dart';
import 'package:filmfolio/src/ui/screens/movie_detail_screen.dart';

class MovieList extends StatelessWidget {
  final List<Movie> movies;

  const MovieList({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: movies.length,
      itemBuilder: (context, index) {
        final movie = movies[index];

        return Card(
          color: Colors.grey[900],
          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MovieDetailScreen(movie: movie),
                ),
              );
            },
            child: Row(
              children: [
                (movie.images != null && movie.images!.isNotEmpty)
                    ? Image.asset(
                       movie.images![0],  // Access the first image safely
                       fit: BoxFit.cover,
                       width: 120.0,
                       height: 180.0,
                    )
                    : Container(
                        color: Colors.grey[800],
                        width: 120.0,
                        height: 180.0,
                        child: const Center(
                          child: Text(
                            'No Image',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                const SizedBox(width: 16.0),
                
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
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
                        movie.rating != null
                            ? 'Rating: ${movie.rating!.toStringAsFixed(1)}/10'
                            : 'Rating: N/A',  // Fallback in case rating is null
                        style: const TextStyle(color: Colors.amber),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        movie.description ?? 'write',
                        style: const TextStyle(
                          color: Colors.white70,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}