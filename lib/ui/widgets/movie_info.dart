import 'package:filmfolio/models/movie.dart';
import 'package:flutter/material.dart';

class MovieInfo extends StatelessWidget {
  final Movie movie;
  const MovieInfo({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            'Director: ${movie.director}',
            style: const TextStyle(fontSize: 16.0, color: Colors.white70),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            'Type: ${movie.isMovie ? "Movie" : "Series"}',
            style: const TextStyle(fontSize: 16.0, color: Colors.white70),
          ),
        ),
        Text(
          'Rating: ${movie.rating}/10',
          style: const TextStyle(
            fontSize: 16.0,
            color: Colors.amber,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16.0),
        Text(
          movie.storyline,
          style: const TextStyle(fontSize: 14.0, color: Colors.white70),
        ),
        const SizedBox(height: 24.0),
        if (movie.awards != null && movie.awards!.isNotEmpty)
          _buildSection('Awards:', movie.awards!.map((award) => award.name).toList()),
        if (movie.crew.isNotEmpty)
          _buildSection('Crew:', movie.crew.map((crew) => crew.name).toList()),
      ],
    );
  }

  Widget _buildSection(String title, List<String> items) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8.0),
          ...items.map((item) => Text(
            item,
            style: const TextStyle(
              fontSize: 14.0,
              color: Colors.white70,
            ),
          )).toList(),
        ],
      ),
    );
  }
}
