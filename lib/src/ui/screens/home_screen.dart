import 'package:filmfolio/src/models/movie.dart';
import 'package:filmfolio/src/ui/widgets/add_movie_form.dart';
import 'package:filmfolio/src/ui/widgets/movie_list.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Movie> _movies = [
    Movie(
      name: 'Inception',
      description:
          "Inception is a mind-bending science fiction thriller directed by Christopher Nolan. The film follows Dom Cobb, a skilled thief who specializes in extracting secrets from within the subconscious during dreams. Offered a chance to have his criminal record erased, Cobb takes on a seemingly impossible task: planting an idea in someones mind, a process known as 'inception.' As Cobb and his team delve deeper into the layers of the target's dreams, the lines between reality and dreams blur, leading to a suspenseful and visually stunning exploration of the human mind, guilt, and redemption.",
      images: ['assets/images/inception.jpg'],
      rating: 8.8,
      type: 'Hollywood',
      director: 'Christopher Nolan',
    ),
    Movie(
      name: 'Demon Slayer',
      description:
          'Demon Slayer (Kimetsu no Yaiba) is a visually stunning anime series set in Taisho-era Japan. It follows the journey of Tanjiro Kamado, a kind-hearted boy who becomes a demon slayer after his family is slaughtered by demons, and his sister Nezuko is turned into one. Determined to avenge his family and cure his sister, Tanjiro embarks on a perilous quest, facing powerful demons, mastering the art of swordsmanship, and forming strong bonds with fellow slayers. The series is celebrated for its breathtaking animation, intense battles, and emotional storytelling.',
      images: ['assets/images/demon_slayer.jpg'],
      rating: 8.9,
      type: 'Hollywood',
      director: 'Koyoharu Gotouge',
    ),
    Movie(
      name: 'The Dark Knight',
      description:
          "The Dark Knight is a critically acclaimed superhero film directed by Christopher Nolan. It follows Batman as he battles the Joker, a chaotic and merciless criminal mastermind who seeks to plunge Gotham City into anarchy. As the Joker's reign of terror escalates, Batman is pushed to his limits, testing his moral code and resolve. The film is renowned for its complex characters, gripping narrative, and Heath Ledger's iconic portrayal of the Joker, which earned him a posthumous Academy Award. The Dark Knight explores themes of justice, fear, and the fine line between heroism and vigilantism.",
      images: ['assets/images/the_dark_knight.jpg'],
      rating: 8.9,
      type: 'Hollywood',
      director: 'Christopher Nolan',
    ),
  ];

  void _addMovie(Movie movie) {
    setState(() {
      _movies.add(movie);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
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
            icon: const Icon(Icons.search),
            onPressed: () {
            },
          ),
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
            },
          ),
        ],
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.black.withOpacity(0.8), Colors.black.withOpacity(0.6)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ),
      body: MovieList(movies: _movies),
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
