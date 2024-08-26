import 'package:filmfolio/src/models/movie.dart';
import 'package:filmfolio/src/ui/widgets/add_movie_form.dart';
import 'package:filmfolio/src/ui/widgets/custom_card_normal.dart';
import 'package:filmfolio/src/ui/widgets/custom_card_thumbnail.dart';
import 'package:flutter/material.dart';
import 'package:filmfolio/src/ui/widgets/movie_list.dart';
import 'package:filmfolio/src/services/auth_service.dart'; // Import AuthService

import '../../../utils/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Movie> foryouItemsList = List.of(forYouImages);
  List<Movie> popularItemsList = List.of(popularImages);
  List<Movie> genresList = List.of(genresImages);
  List<Movie> legendaryItemList = List.of(legendaryImages);


  List<Movie> filteredPopularItemsList = [];// For search functionality
  List<Movie> filteredLegendaryItemsList = []; // For search functionality

  PageController pageController =
      PageController(initialPage: 0, viewportFraction: 0.9);
  int currentPage = 0;

  String? userEmail; // Variable to hold user's email
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchUserEmail(); // Fetch the user's email on initialization
    filteredPopularItemsList = List.of(popularItemsList); // Initialize filtered list
    filteredLegendaryItemsList = List.of(legendaryItemList);
    _searchController.addListener(_filterMovies); // Add listener to search controller
  }

  Future<void> _fetchUserEmail() async {
    final authService = AuthService();
    final user = authService.currentUser;
    if (user != null) {
      setState(() {
        userEmail = user.email; // Set the user's email
      });
    }
  }

  void _filterMovies() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      filteredPopularItemsList = popularItemsList.where((movie) {
        return (movie.name?.toLowerCase().contains(query) ?? false) ||
            (movie.director?.toLowerCase().contains(query) ?? false);
      }).toList();
      filteredLegendaryItemsList = legendaryItemList.where((movie) {
        return (movie.name?.toLowerCase().contains(query) ?? false) ||
            (movie.director?.toLowerCase().contains(query) ?? false);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          userEmail != null
                              ? "Hi, $userEmail!"
                              : "Hi there!", // Display user's email
                          style: const TextStyle(
                              color: Colors.white70, fontSize: 15),
                        ),
                        Stack(
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                image: DecorationImage(
                                  image: NetworkImage(
                                    "https://media.istockphoto.com/id/1337144146/vector/default-avatar-profile-icon-vector.jpg?s=612x612&w=0&k=20&c=BIbFwuv7FxTWvh5S3vB6bkT0Qv8Vn8N5Ffseq84ClGI=",
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              right: 2,
                              top: 2,
                              child: Container(
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: kBackgroundColor,
                                ),
                                height: 10,
                                width: 10,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),

                  // Search bar
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: kSearchBarColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        controller: _searchController,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search, color: Colors.white70),
                          hintText: 'Search...',
                          hintStyle: TextStyle(color: Colors.white70),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                    child: Text(
                      "For You",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                  forYouCardLayout(forYouImages),

                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: kSearchBarColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: buildPageIndicatorWidget(),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 30),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Popular",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 20,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            Text(
                              "See All",
                              style: TextStyle(
                                color: kButtonColor,
                                fontSize: 17,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  MovieListBuilder(
                      filteredPopularItemsList), // Use filtered list

                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 30),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Geners",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 20,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            Text(
                              "See All",
                              style: TextStyle(
                                color: kButtonColor,
                                fontSize: 17,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  genresBuilder(genresImages),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 30),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Legendary Movies",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 20,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            Text(
                              "See All",
                              style: TextStyle(
                                color: kButtonColor,
                                fontSize: 17,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  MovieListBuilder(filteredLegendaryItemsList),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget forYouCardLayout(List<Movie> movieList) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.60,
      child: PageView.builder(
        physics: const ClampingScrollPhysics(),
        controller: pageController,
        itemCount: movieList.length,
        itemBuilder: (context, index) {
          return CustomCardThumbnail(
            images: movieList[index].images.toString(),
          );
        },
        onPageChanged: (int page) {
          setState(() {
            currentPage = page;
          });
        },
      ),
    );
  }

  Widget MovieListBuilder(List<Movie> movieList) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      height:
          MediaQuery.of(context).size.height * 0.5, // Adjust height as needed
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: movieList.length,
        itemBuilder: (context, index) {
          return CustomCardNormal(movie: movieList[index]);
        },
      ),
    );
  }

  Widget genresBuilder(List<Movie> genresList) {
    return Container(
      height: 200, // Fixed height
      child: ListView.builder(
        itemCount: genresList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return RepaintBoundary(
            child: Stack(
              children: [
                Container(
                  width: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: AssetImage(
                        genresList[index].images.toString(),
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  margin: const EdgeInsets.only(
                      left: 10, right: 10, top: 8, bottom: 30
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 20,
                  child: Text(
                    genresList[index].name.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }


  List<Widget> buildPageIndicatorWidget() {
    List<Widget> list = [];
    for (int i = 0; i < foryouItemsList.length; i++) {
      list.add(i == currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      height: 8.0,
      width: 8.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Colors.white30,
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    _searchController.dispose(); // Dispose of the search controller
    super.dispose();
  }
}

// class _HomeScreenState extends State<HomeScreen> {
// final List<Movie> _movies = [
//   Movie(
//     name: 'Inception',
//     description:
//     "Inception is a mind-bending science fiction thriller directed by Christopher Nolan. The film follows Dom Cobb, a skilled thief who specializes in extracting secrets from within the subconscious during dreams...",
//     images: ['assets/images/inception.jpg'],
//     rating: 8.8,
//     type: 'Hollywood',
//     director: 'Christopher Nolan',
//   ),
//   Movie(
//     name: 'Demon Slayer',
//     description:
//     'Demon Slayer (Kimetsu no Yaiba) is a visually stunning anime series set in Taisho-era Japan...',
//     images: ['assets/images/demon_slayer.jpg'],
//     rating: 8.9,
//     type: 'Anime',
//     director: 'Koyoharu Gotouge',
//   ),
//   Movie(
//     name: 'The Dark Knight',
//     description:
//     "The Dark Knight is a critically acclaimed superhero film directed by Christopher Nolan...",
//     images: ['assets/images/the_dark_knight.jpg'],
//     rating: 8.9,
//     type: 'Hollywood',
//     director: 'Christopher Nolan',
//   ),
//   Movie(
//     name: 'Interstellar',
//     description:
//     "Interstellar is a science fiction epic directed by Christopher Nolan. The film explores the journey of a team of astronauts who travel through a wormhole in search of a new home for humanity...",
//     images: ['assets/images/interstellar.jpg'],
//     rating: 8.6,
//     type: 'Hollywood',
//     director: 'Christopher Nolan',
//   ),
// ];
//
// final _searchController = TextEditingController();
// bool _isSearching = false;
//
// void _addMovie(Movie movie) {
//   setState(() {
//     _movies.add(movie);
//   });
// }
//
// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     appBar: AppBar(
//       title: AnimatedSwitcher(
//         duration: const Duration(milliseconds: 300),
//         child: _isSearching
//             ? TextField(
//           key: const ValueKey('SearchField'),
//           controller: _searchController,
//           style: const TextStyle(color: Colors.white),
//           decoration: const InputDecoration(
//             hintText: 'Search...',
//             hintStyle: TextStyle(color: Colors.white70),
//             border: InputBorder.none,
//           ),
//           onChanged: (value) {
//             setState(() {});
//           },
//         )
//             : const Text(
//           'FILMFOLIO',
//           key: ValueKey('AppTitle'),
//           style: TextStyle(
//             fontSize: 24.0,
//             fontWeight: FontWeight.bold,
//             letterSpacing: 1.5,
//             color: Colors.amber,
//           ),
//         ),
//       ),
//       backgroundColor: Colors.black,
//       elevation: 4.0,
//       actions: [
//         IconButton(
//           icon: Icon(_isSearching ? Icons.close : Icons.search),
//           onPressed: () {
//             setState(() {
//               if (_isSearching) {
//                 _searchController.clear();
//               }
//               _isSearching = !_isSearching;
//             });
//           },
//         ),
//         PopupMenuButton<String>(
//           onSelected: (value) {
//             // Handle menu selection
//           },
//           itemBuilder: (context) {
//             return [
//               const PopupMenuItem(value: 'Settings', child: Text('Settings')),
//               const PopupMenuItem(value: 'About', child: Text('About')),
//             ];
//           },
//           icon: const Icon(Icons.more_vert),
//         ),
//       ],
//     ),
//     body: _movies.isEmpty
//         ? const Center(
//       child: Text(
//         'No movies found.',
//         style: TextStyle(fontSize: 18, color: Colors.grey),
//       ),
//     )
//         : MovieList(
//       movies: _movies.where((movie) {
//         String query = _searchController.text.toLowerCase();
//         return (movie.name?.toLowerCase().contains(query) ?? false )||
//             (movie.director?.toLowerCase().contains(query) ?? false );
//       }).toList(),
//     ),
//     floatingActionButton: FloatingActionButton.extended(
//       onPressed: () {
//         showDialog(
//           context: context,
//           builder: (context) {
//             return AddMovieForm(
//               onMovieAdded: (movie) {
//                 _addMovie(movie);
//                 Navigator.of(context).pop();
//               },
//             );
//           },
//         );
//       },
//       label: const Text('Add Movie'),
//       icon: const Icon(Icons.add),
//       backgroundColor: Colors.amber,
//     ),
//     floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//   );
// }
// }
