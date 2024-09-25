import 'package:filmfolio/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:filmfolio/models/movie.dart';
import 'package:filmfolio/ui/screens/movie_detail_screen.dart';

class MovieList extends StatelessWidget {
  final List<Movie> movies;
  final UserController _userController = UserController();

  MovieList({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: movies.length,
      itemBuilder: (context, index) {
        final movie = movies[index];

        return Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          color: Colors.grey[900],
          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MovieDetailScreen(movie: movie),
                ),
              );
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                  ),
                  child: movie.thumbnailUrl != null
                      ? Image.network(
                    movie.thumbnailUrl,
                    fit: BoxFit.cover,
                    width: 80.0,
                    height: 120.0,
                  )
                      : Container(
                    color: Colors.grey[800],
                    width: 120.0,
                    height: 180.0,
                    child: const Center(
                      child: Icon(
                        Icons.movie,
                        size: 40,
                        color: Colors.white54,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          movie.name,
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.star, color: Colors.amber, size: 16),
                            const SizedBox(width: 4),
                            Text(
                              '${movie.rating?.toStringAsFixed(1) ?? "N/A"}/10',
                              style: const TextStyle(
                                color: Colors.amber,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          movie.storyline,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 14,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
                PopupMenuButton<String>(
                  onSelected: (value) {
                    _userController.addToWatchlist(movie.id);
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'watchlist',
                      child: Text('Add to Watchlist'),
                    ),
                  ],
                  icon: const Icon(
                    Icons.more_vert,
                    color: Colors.white70,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
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