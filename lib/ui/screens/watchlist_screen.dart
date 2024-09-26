import 'package:filmfolio/controllers/user_controller.dart';
import 'package:filmfolio/models/movie.dart';
import 'package:filmfolio/ui/screens/movie_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // date formatting

class WatchlistScreen extends StatefulWidget {
  const WatchlistScreen({super.key});

  @override
  State<WatchlistScreen> createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen> {
  List<Movie> movies = [];
  final UserController _userController = UserController();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUserContent();
  }

  Future<void> fetchUserContent() async {
    try {
      final fetchedMovies = await _userController.fetchUserShows();
      setState(() {
        movies = fetchedMovies;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching watchlist: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('My Watchlist'),
        ),
        body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : movies.isEmpty
                ? const Center(
                    child: Text(
                    'Your watchlist is empty',
                    style: TextStyle(color: Colors.white),
                  ))
                : ListView.builder(
                    itemCount: movies.length,
                    itemBuilder: (context, index) {
                      final movie = movies[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.network(
                                movie.thumbnailUrl,
                                width: 100,
                                height: 150,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    Container(
                                  width: 100,
                                  height: 150,
                                  color: Colors.grey[300],
                                  child: const Icon(Icons.movie,
                                      size: 50, color: Colors.grey),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    movie.name,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                          color: Colors.amber,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    DateFormat.yMMMd()
                                        .format(movie.releaseDate),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                          color: Colors.amber[200],
                                        ),
                                  ),
                                  const SizedBox(height: 8),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              MovieDetailScreen(movie: movie),
                                        ),
                                      );
                                    },
                                    child: Text('View Details'),
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.amber,
                                      backgroundColor: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            PopupMenuButton<String>(
                              onSelected: (value) async {
                                await _userController
                                    .removeFromWatchlist(movie.id);
                                await fetchUserContent();
                              },
                              itemBuilder: (context) => [
                                const PopupMenuItem(
                                  value: 'remove',
                                  child: Text('Remove',
                                      style: TextStyle(color: Colors.amber)),
                                ),
                              ],
                              icon: const Icon(
                                Icons.more_vert,
                                color: Colors.amber,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ));
  }
}
