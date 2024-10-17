import 'package:filmfolio/controllers/content_controller.dart';
import 'package:filmfolio/controllers/user_controller.dart';
import 'package:filmfolio/controllers/usercontent_controller.dart';
import 'package:filmfolio/models/movie.dart';
import 'package:filmfolio/models/user.dart';
import 'package:filmfolio/ui/screens/movie_creater.dart';
import 'package:filmfolio/ui/widgets/movie_list.dart';
import 'package:filmfolio/ui/widgets/movie_slideshow.dart';
import 'package:filmfolio/ui/widgets/search_helper.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ContentController _contentController = ContentController();
  final UserController _userController = UserController();
  final UserContentController dummy = UserContentController();
  List<Movie> _allMovies = [];
  List<Movie> _displayedMovies = [];
  User? _user;
  late SearchHelper _searchHelper;
  bool _isLoadingUser = true;

  @override
  void initState() {
    super.initState();
    _searchHelper = SearchHelper(
      onSearch: _performSearch,
      onToggleSearch: _toggleSearch,
    );
    _initializeData();
  }

  Future<void> _initializeData() async {
    await Future.wait([
      _fetchMovies(),
      _fetchUser(),
      _searchHelper.loadSearchHistory(),
    ]);
  }

  Future<void> _fetchUser() async {
    final user = await _userController.loadUserFromLocalStorage();
    final finaluser = await _userController.getUserById(user!.id);
    print(user.email);
    print(finaluser!.isAdmin);
    setState(() {
      _user = finaluser;
      _isLoadingUser = false;
    });
  }

  Future<void> _fetchMovies() async {
    final movies = await _contentController.getAllMovies();
    setState(() {
      _allMovies = movies;
      _displayedMovies = movies;
    });
  }

  void _performSearch(String query) {
    setState(() {
      if (query.isEmpty) {
        _displayedMovies = _allMovies;
      } else {
        _displayedMovies = _allMovies
            .where((movie) =>
                movie.name.toLowerCase().contains(query.toLowerCase()) ||
                movie.categories.any((category) =>
                    category.toLowerCase().contains(query.toLowerCase())))
            .toList();
      }
    });
  }

  void _toggleSearch() {
    setState(() {
      if (_searchHelper.isSearching) {
        _displayedMovies = _allMovies;
      }
    });
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
        appBar: _buildAppBar(),
        body: SafeArea(
          child: RefreshIndicator(
            onRefresh: _fetchMovies,
            color: Colors.amber,
            backgroundColor: Colors.black,
            child: _buildBody(),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: _searchHelper.isSearching
          ? _searchHelper.buildSearchField()
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
          icon: Icon(
            _searchHelper.isSearching ? Icons.close : Icons.search,
            color: Colors.white,
            size: 30,
          ),
          onPressed: _searchHelper.toggleSearch,
        ),
        if (!_isLoadingUser  &&  _user!.isAdmin == true)
          IconButton(
            icon: const Icon(Icons.info_outline_rounded,
                color: Colors.white, size: 30),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MovieCreatorsPage(),
                ),
              );
            },
          ),
      ],
    );
  }

  Widget _buildBody() {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        if (_searchHelper.isSearching) _searchHelper.buildSearchHistoryList(),
        if (!_searchHelper.isSearching) ...[
          _buildUserGreeting(),
          const SizedBox(height: 15),
          _buildForYouSection(),
        ],
        _buildMovieCategories(),
      ],
    );
  }

  Widget _buildUserGreeting() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            _user != null ? "Hi, ${_user!.name}!" : "Hi there!",
            style: const TextStyle(color: Colors.white70, fontSize: 15),
          ),
          _buildUserAvatar(),
        ],
      ),
    );
  }

  Widget _buildUserAvatar() {
    return Stack(
      children: [
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            image: DecorationImage(
              image: NetworkImage(
                _user?.profileUrl ??
                    "https://imgs.search.brave.com/SMPQEU6hs_kEFGfDbP-8datnmpThKtzFWgQMUXJiw2Y/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly91cGxv/YWQud2lraW1lZGlh/Lm9yZy93aWtpcGVk/aWEvY29tbW9ucy8x/LzEyL1VzZXJfaWNv/bl8yLnN2Zw",
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
              color: Colors.green,
            ),
            height: 10,
            width: 10,
          ),
        ),
      ],
    );
  }

  Widget _buildForYouSection() {
    final forYouMovies = _displayedMovies.take(3).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Text(
            "For You",
            style: TextStyle(
              color: Colors.white70,
              fontSize: 20,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
        const SizedBox(height: 10),
        MovieSlideshow(movies: forYouMovies),
      ],
    );
  }

  Widget _buildMovieCategories() {
    final categories = [
      "Anime",
      "Horror",
      "Romantic",
      "Science-fiction",
      "Action",
      "Comedy",
      "Documentary",
      "Drama",
      "Fantasy",
      "Mystery",
      "Thriller",
    ];
    return Column(
      children: categories.map((category) {
        final categoryMovies = _displayedMovies
            .where((movie) => movie.categories.contains(category))
            .toList();
        return categoryMovies.isNotEmpty
            ? _buildCategorySection(category, categoryMovies)
            : const SizedBox.shrink();
      }).toList(),
    );
  }

  Widget _buildCategorySection(String category, List<Movie> movies) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                category,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 20,
                  fontWeight: FontWeight.w300,
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: const Text(
                  "See All",
                  style: TextStyle(
                    color: Colors.amber,
                    fontSize: 17,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ],
          ),
        ),
        MovieList(movies: movies),
      ],
    );
  }

  @override
  void dispose() {
    _searchHelper.dispose();
    super.dispose();
  }
}
