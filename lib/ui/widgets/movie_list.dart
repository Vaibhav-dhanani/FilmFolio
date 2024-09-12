import 'package:filmfolio/models/movie.dart';
import 'package:flutter/material.dart';
import 'package:filmfolio/ui/screens/movie_detail_screen.dart';

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
                movie.thumbnailUrl != null
                    ? Image.network(
                        movie.thumbnailUrl,
                        fit: BoxFit.cover,
                        width: 140.0,
                        height: 160.0,
                      )
                    : Container(
                        color: Colors.grey[800],
                        width: 140.0,
                        height: 160.0,
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
                        movie.name,
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Rating: ${movie.rating?.toStringAsFixed(1)}/10',
                        style: const TextStyle(color: Colors.amber,fontWeight: FontWeight.bold),
                      ),
                      Text(
                        movie.storyline,
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