import 'package:filmfolio/models/movie.dart';
import 'package:filmfolio/ui/widgets/content_player.dart';
import 'package:filmfolio/ui/widgets/movie_info.dart';
import 'package:filmfolio/ui/widgets/movie_poster.dart';
import 'package:filmfolio/ui/widgets/movie_title.dart';
import 'package:filmfolio/ui/widgets/secsons_info.dart';
import 'package:flutter/material.dart';

class MovieDetailScreen extends StatelessWidget {
  final Movie movie;

  const MovieDetailScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        movie.name,
        style: const TextStyle(
          fontSize: 22.0,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
          color: Colors.white,
        ),
      ),
      backgroundColor: Colors.black.withOpacity(1),
      elevation: 4.0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.amber),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  Widget _buildBody() {
    return Container(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MoviePoster(movie: movie),
            const SizedBox(height: 16.0),
            MovieTitle(movie: movie),
            const SizedBox(height: 8.0),
            MovieInfo(movie: movie),
            const SizedBox(height: 24.0),
            SeasonInfo(movie: movie),
            const SizedBox(height: 10,),
            ContentPlayer(movie: movie)
          ],
        ),
      ),
    );
  }
}