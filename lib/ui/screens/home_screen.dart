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
    setState(() {
      _movies.clear();
      _movies.addAll(movies);
    });
  }

  void _addMovie(Movie movie) async {
    await _contentController.addMovie(movie);
    _fetchMovies();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanEnd: (details) {
        if (details.velocity.pixelsPerSecond.dy > 200) {
          _fetchMovies();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: _isSearching
              ? _buildSearchField()
              : const Text(
            'FILMFOLIO',
            style: TextStyle(
              fontSize: 26.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
              color: Colors.amber,
            ),
          ),
          backgroundColor: Colors.black,
          elevation: 2.0,
          actions: [
            IconButton(
              icon: Icon(_isSearching ? Icons.close : Icons.search,color: Colors.white,size: 30,),
              onPressed: _toggleSearch,
            ),
          ],
        ),
        body: Column(
          children: [
            const SizedBox(height: 10),
            Expanded(
              child: _buildMovieList(),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.amber,
          elevation: 6.0,
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => AddMoviePage(onMovieAdded: _addMovie),
              ),
            );
          },
          child: const Icon(Icons.add, color: Colors.black),
        ),
      ),
    );
  }

  Widget _buildSearchField() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 40,
      child: TextField(
        controller: _searchController,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: 'Search movies...',
          hintStyle: const TextStyle(color: Colors.white70),
          prefixIcon: const Icon(Icons.search, color: Colors.amber),
          filled: true,
          fillColor: Colors.grey[850],
          contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide.none,
          ),
        ),
        onChanged: (value) {
          setState(() {});
        },
      ),
    );
  }

  Widget _buildMovieList() {
    final filteredMovies = _movies.where((movie) {
      final query = _searchController.text.toLowerCase();
      return movie.name.toLowerCase().contains(query) ||
          movie.director.toLowerCase().contains(query);
    }).toList();

    return filteredMovies.isNotEmpty
        ? MovieList(movies: filteredMovies)
        : Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.movie_creation_outlined, size: 80, color: Colors.amber),
          SizedBox(height: 16),
          Text(
            'No movies found',
            style: TextStyle(color: Colors.white70, fontSize: 20),
          ),
        ],
      ),
    );
  }

  void _toggleSearch() {
    setState(() {
      if (_isSearching) {
        _searchController.clear();
      }
      _isSearching = !_isSearching;
    });
  }
}


































// import 'package:flutter/material.dart';
// import 'package:filmfolio/controllers/content_controller.dart';
// import 'package:filmfolio/models/movie.dart';
// import 'package:filmfolio/ui/widgets/movie_list.dart';
//
// import '../widgets/add_movie_form.dart';
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});
//
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   final ContentController _contentController = ContentController();
//   final List<Movie> _movies = [];
//   final _searchController = TextEditingController();
//   bool _isSearching = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchMovies();
//   }
//
//   void _fetchMovies() async {
//     List<Movie> movies = await _contentController.getAllMovies();
//     setState(() {
//       _movies.clear();
//       _movies.addAll(movies);
//     });
//   }
//
//   void _addMovie(Movie movie) async {
//     await _contentController.addMovie(movie);
//     _fetchMovies();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onPanEnd: (details) {
//         if (details.velocity.pixelsPerSecond.dy > 200) {
//           _fetchMovies();
//         }
//       },
//       child: Scaffold(
//         appBar: AppBar(
//           title: _isSearching
//               ? TextField(
//             controller: _searchController,
//             style: const TextStyle(color: Colors.white),
//             decoration: const InputDecoration(
//               hintText: 'Search...',
//               hintStyle: TextStyle(color: Colors.white70),
//               border: InputBorder.none,
//             ),
//             onChanged: (value) {
//               setState(() {});
//             },
//           )
//               : const Text(
//             'FILMFOLIO',
//             style: TextStyle(
//               fontSize: 24.0,
//               fontWeight: FontWeight.bold,
//               letterSpacing: 1.5,
//               color: Colors.amber,
//             ),
//           ),
//           backgroundColor: Colors.black,
//           elevation: 0.0,
//           actions: [
//             IconButton(
//               icon: Icon(_isSearching ? Icons.close : Icons.search),
//               onPressed: () {
//                 setState(() {
//                   if (_isSearching) {
//                     _searchController.clear();
//                   }
//                   _isSearching = !_isSearching;
//                 });
//               },
//             ),
//           ],
//         ),
//         body: MovieList(
//           movies: _movies.where((movie) {
//             final query = _searchController.text.toLowerCase();
//             return movie.name.toLowerCase().contains(query) ||
//                 movie.director.toLowerCase().contains(query);
//           }).toList(),
//         ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: () {
//             Navigator.of(context).push(
//               MaterialPageRoute(
//                 builder: (context) => AddMoviePage(
//                   onMovieAdded: _addMovie,
//                 ),
//               ),
//             );
//           },
//           child: const Icon(Icons.add),
//         ),
//       ),
//     );
//   }
// }
