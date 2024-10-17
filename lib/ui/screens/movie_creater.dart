import 'package:filmfolio/models/content_create_track.dart';
import 'package:filmfolio/models/movie_with_creator.dart';
import 'package:filmfolio/ui/widgets/add_movie_form.dart';
import 'package:flutter/material.dart';
import 'package:filmfolio/controllers/content_controller.dart';
import 'package:filmfolio/controllers/user_controller.dart';
import 'package:filmfolio/controllers/usercontent_controller.dart';
import 'package:filmfolio/models/movie.dart';
import 'package:filmfolio/models/user.dart';
import 'package:filmfolio/ui/widgets/movie_creator_card.dart';

class MovieCreatorsPage extends StatefulWidget {
  const MovieCreatorsPage({Key? key}) : super(key: key);

  @override
  State<MovieCreatorsPage> createState() => _MovieCreatorsPageState();
}

class _MovieCreatorsPageState extends State<MovieCreatorsPage> {
  final UserContentController _userContentController = UserContentController();
  final ContentController _contentController = ContentController();
  final UserController _userController = UserController();
  bool _isLoading = true;
  List<MovieWithCreator> _moviesWithCreators = [];

  @override
  void initState() {
    super.initState();
    _loadMoviesWithCreators();
  }

  Future<void> _loadMoviesWithCreators() async {
    try {
      setState(() {
        _isLoading = true;
      });

      List<Movie> movies = await _contentController.getAllMovies();
      List<UserContent> allUserContent =
      await _userContentController.getAllUserContent();
      List<MovieWithCreator> moviesWithCreators = [];

      for (Movie movie in movies) {
        var creators =
        allUserContent.where((uc) => uc.contentId == movie.id).toList();
        if (creators.isNotEmpty) {
          moviesWithCreators.add(
            MovieWithCreator(
              movie: movie,
              user: await _userController.getUserById(creators.first.userId),
              createdAt: creators.first.createdAt,
            ),
          );
        }
      }

      moviesWithCreators.sort((a, b) => b.createdAt.compareTo(a.createdAt));

      setState(() {
        _moviesWithCreators = moviesWithCreators;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      _showErrorDialog('Error loading movies: $e');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie Creators'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadMoviesWithCreators,
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const AddMoviePage(),
                ),
              );
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _moviesWithCreators.isEmpty
          ? Center(
        child: Text(
          'No movies found',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      )
          : RefreshIndicator(
        onRefresh: _loadMoviesWithCreators,
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: _moviesWithCreators.length,
          itemBuilder: (context, index) {
            final movieWithCreator = _moviesWithCreators[index];
            return MovieCreatorCard(
              movieWithCreator: movieWithCreator,
            );
          },
        ),
      ),
    );
  }
}
