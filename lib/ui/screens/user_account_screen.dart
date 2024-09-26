import 'package:filmfolio/controllers/content_controller.dart';
import 'package:filmfolio/controllers/user_controller.dart';
import 'package:filmfolio/services/auth_service.dart';
import 'package:filmfolio/ui/screens/user_profile_screen.dart';
import 'package:flutter/material.dart';

import '../../models/movie.dart';
import '../../models/user.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  User? user;
  String username = '';
  List<Movie> reviewedMovies = [];

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    UserController userController = UserController();
    User? loadedUser = await userController.loadUserFromLocalStorage();
    if (loadedUser != null) {
      setState(() {
        user = loadedUser;
        username = loadedUser.name;
      });
      _loadReviewedMovies(loadedUser.id);
    }
  }

  Future<void> _loadReviewedMovies(String userId) async {
    ContentController _contentController = ContentController();
    List<Movie> allMovies = await _contentController.getAllMovies();
    List<Movie> moviesWithUserReviews = allMovies.where((movie) {
      return movie.reviews?.any((review) => review.username == username) ??
          false;
    }).toList();

    setState(() {
      reviewedMovies = moviesWithUserReviews;
    });
  }

  void _logOut(BuildContext context) async {
    try {
      final AuthService auth = AuthService();
      await auth.signOut();
    } on Exception catch (e) {
      showDialog(
        context: context,
        builder: ((context) => AlertDialog(
              title: Text(e.toString()),
            )),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.amber,
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(0.0, 10, 10, 0),
                child: Text(
                  'Settings',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Profile'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserFullProfile(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.notifications),
              title: Text('Notifications'),
              onTap: () {
                // Navigate to Notifications
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () => _logOut(context),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20.0, 0, 0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.perm_identity_rounded,
                        color: Colors.amber,
                        size: 30.0,
                      ),
                      SizedBox(width: 10),
                      Text(
                        username,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Builder(
                  builder: (context) {
                    return IconButton(
                      icon: const Icon(
                        Icons.settings,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Scaffold.of(context).openEndDrawer();
                      },
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      "Reviewed Movies",
                      style: TextStyle(
                        color: Colors.amber,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      itemCount: reviewedMovies.length,
                      itemBuilder: (context, index) {
                        Movie movie = reviewedMovies[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8.0),
                          child: ListTile(
                            title: Text(
                              movie.name,
                              style: TextStyle(color: Colors.black),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: movie.reviews?.map((review) {
                                    return Text(
                                      '${review.username}: ${review.reviewText}',
                                      style: TextStyle(color: Colors.black),
                                    );
                                  }).toList() ??
                                  [],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const Divider(color: Colors.grey),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
