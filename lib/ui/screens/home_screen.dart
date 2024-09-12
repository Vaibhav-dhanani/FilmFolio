import 'package:flutter/material.dart';
import 'package:filmfolio/controllers/content_controller.dart';
import 'package:filmfolio/models/movie.dart';
import 'package:filmfolio/ui/widgets/movie_list.dart';

import '../widgets/add_movie_form.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ContentController _contentController = ContentController();
  final List<Movie> _movies = [];

  final _searchController = TextEditingController();
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _fetchMovies();
  }

  void _fetchMovies() async {
    List<Movie> movies = await _contentController.getAllMovies();
    // await _contentController.addMovie();
    setState(() {
      _movies.addAll(movies);
    });
  }

  void _addMovie(Movie movie) {
    setState(() {
      _movies.add(movie);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _isSearching
            ? TextField(
          controller: _searchController,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            hintText: 'Search...',
            hintStyle: TextStyle(color: Colors.white70),
            border: InputBorder.none,
          ),
          onChanged: (value) {
            setState(() {});
          },
        )
            : const Text(
          'FILMFOLIO',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
            color: Colors.amber,
          ),
        ),
        backgroundColor: Colors.black,
        elevation: 0.0,
        actions: [
          IconButton(
            icon: Icon(_isSearching ? Icons.close : Icons.search),
            onPressed: () {
              setState(() {
                if (_isSearching) {
                  _searchController.clear();
                }
                _isSearching = !_isSearching;
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              // Menu action
            },
          ),
        ],
      ),
      body: MovieList(
        movies: _movies.where((movie) {
          final query = _searchController.text.toLowerCase();
          return movie.name.toLowerCase().contains(query) ||
              movie.director.toLowerCase().contains(query);
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddMoviePage(
                onMovieAdded: _addMovie,
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
