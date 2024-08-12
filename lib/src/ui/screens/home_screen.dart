import 'package:filmfolio/src/models/movie.dart';
import 'package:filmfolio/src/ui/widgets/add_movie_form.dart';
import 'package:filmfolio/src/ui/widgets/movie_list.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Movie> _movies = [
    Movie(
      name: 'Inception',
      description:
          "Inception is a mind-bending science fiction thriller directed by Christopher Nolan. The film follows Dom Cobb, a skilled thief who specializes in extracting secrets from within the subconscious during dreams...",
      images: ['assets/images/inception.jpg'],
      rating: 8.8,
      type: 'Hollywood',
      director: 'Christopher Nolan',
    ),
    Movie(
      name: 'Demon Slayer',
      description:
          'Demon Slayer (Kimetsu no Yaiba) is a visually stunning anime series set in Taisho-era Japan...',
      images: ['assets/images/demon_slayer.jpg'],
      rating: 8.9,
      type: 'Hollywood',
      director: 'Koyoharu Gotouge',
    ),
    Movie(
      name: 'The Dark Knight',
      description:
          "The Dark Knight is a critically acclaimed superhero film directed by Christopher Nolan...",
      images: ['assets/images/the_dark_knight.jpg'],
      rating: 8.9,
      type: 'Hollywood',
      director: 'Christopher Nolan',
    ),
    Movie(
      name: 'Interstellar',
      description:
          "Interstellar is a science fiction epic directed by Christopher Nolan. The film explores the journey of a team of astronauts who travel through a wormhole in search of a new home for humanity. As Earth faces an environmental collapse, Cooper, a former NASA pilot, is recruited to lead the mission, leaving behind his family. The film delves into themes of love, sacrifice, and the survival of the human species, while offering breathtaking visuals and a thought-provoking narrative. The movie is also known for its accurate depiction of theoretical physics, particularly black holes and time dilation.",
      images: ['assets/images/interstellar.jpg'],
      rating: 8.6,
      type: 'Hollywood',
      director: 'Christopher Nolan',
    ),
  ];

  bool _isSearching = false;

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
                'FilmFolio',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                  color: Colors.white,
                ),
              ),
        backgroundColor: Colors.black,
        elevation: 4.0,
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
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.black.withOpacity(0.8),
                Colors.black.withOpacity(0.6)
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
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
          showDialog(
            context: context,
            builder: (context) {
              return AddMovieForm(
                onMovieAdded: (movie) {
                  _addMovie(movie);
                  Navigator.of(context).pop();
                },
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
