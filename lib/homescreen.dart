import 'package:flutter/material.dart';

class Movie {
  final String title;
  final String director;
  final String imageUrl;
  final double rating;

  const Movie({
    required this.title,
    required this.director,
    required this.imageUrl,
    required this.rating,
  });
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const List<Movie> movies = [
    Movie(
      title: 'Inception',
      director: 'Christopher Nolan',
      imageUrl: 'assets/images/inception.jpg',
      rating: 9.0,
    ),
    Movie(
      title: 'The Dark Knight',
      director: 'Christopher Nolan',
      imageUrl: 'assets/images/the_dark_knight.jpg',
      rating: 8.9,
    ),
    Movie(
      title: 'Interstellar',
      director: 'Christopher Nolan',
      imageUrl: 'assets/images/interstellar.jpg',
      rating: 8.8,
    ),
    Movie(
      title: 'Demon Slayer',
      director: 'Haruo Sotozaki',
      imageUrl: 'assets/images/demon_slayer.jpg',
      rating: 9.6,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight + 20.0),
        child: AppBar(
          title: const Text(
            'FilmFolio',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
              fontSize: 50,
              color: Colors.amber,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.black,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Top Rated Movies',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  final movie = movies[index];
                  return Card(
                    color: Colors.grey[850],
                    child: ListTile(
                      leading: Container(
                        width: 50,
                        height: 75,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: AssetImage(movie.imageUrl),
                            fit: BoxFit.cover,
                            onError: (exception, stackTrace) {
                              print('Error loading image: ${movie.imageUrl}');
                              print(exception);
                            },
                          ),
                        ),
                      ),
                      title: Text(
                        movie.title,
                        style: const TextStyle(color: Colors.white),
                      ),
                      subtitle: Text(
                        'Director: ${movie.director}',
                        style: TextStyle(color: Colors.grey[400]),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.star, color: Colors.amber),
                          const SizedBox(width: 4),
                          Text(
                            movie.rating.toString(),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.add),
        label: const Text('Add Review'),
        backgroundColor: Colors.amber,
      ),
    );
  }
}
