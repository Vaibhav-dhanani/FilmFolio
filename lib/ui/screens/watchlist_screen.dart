import 'package:filmfolio/controllers/user_controller.dart';
import 'package:filmfolio/models/movie.dart';
import 'package:filmfolio/ui/screens/movie_detail_screen.dart';
import 'package:flutter/material.dart';

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
          ? const Center(child: Text('Your watchlist is empty',style: TextStyle(color: Colors.white),))
          : ListView.builder(
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return ListTile(
            leading: movie.thumbnailUrl != null
                ? Image.network(
              movie.thumbnailUrl!,
              width: 50,
              height: 75,
              fit: BoxFit.cover,
            )
                : const Icon(Icons.movie),
            title: Text(movie.name,style: TextStyle(color: Colors.amber),),
            subtitle: Text(movie.releaseDate.toString(),style: TextStyle(color: Colors.amber),),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MovieDetailScreen(movie: movie),
                ),
              );
            },
            trailing: PopupMenuButton<String>(
              onSelected: (value) {
                _userController.removeFromWatchlist(movie.id);
                fetchUserContent();
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'watchlist',
                  child: Text('Remove'),
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
          );
        },
      ),
    );
  }
}