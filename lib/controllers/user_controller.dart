import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:filmfolio/controllers/content_controller.dart';
import 'package:filmfolio/models/movie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';

class UserController {
  final CollectionReference _usersCollection = FirebaseFirestore.instance.collection('users');
  User? _currentUser;

  User? get currentUser => _currentUser;

  Future<User> createUser(String id, String name, String email) async {
    _currentUser = User(
      id: id,
      name: name,
      email: email,
    );
    await _usersCollection.doc(_currentUser!.id).set(_currentUser!.toJson());
    await saveUserToLocalStorage(id, name, email);
    return _currentUser!;
  }

  Future<void> getUser(String userId) async {
    DocumentSnapshot doc = await _usersCollection.doc(userId).get();
    if (doc.exists) {
      _currentUser = User.fromJson(doc.data() as Map<String, dynamic>);
      await saveUserToLocalStorage(_currentUser!.id!, _currentUser!.name, _currentUser!.email);
    } else {
      _currentUser = null;
    }
  }

  Future<void> updateUser(String name, String email) async {
    if (_currentUser != null) {
      _currentUser = User(
        id: _currentUser!.id,
        name: name,
        email: email,
      );
      await _usersCollection.doc(_currentUser!.id).update(_currentUser!.toJson());
      await saveUserToLocalStorage(_currentUser!.id!, name, email);
    }
  }

  Future<void> deleteUser() async {
    if (_currentUser != null) {
      await _usersCollection.doc(_currentUser!.id).delete();
      _currentUser = null;
      await clearUserFromLocalStorage();
    }
  }

  Future<List<User>> getAllUsers() async {
    QuerySnapshot querySnapshot = await _usersCollection.get();
    return querySnapshot.docs
        .map((doc) => User.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }

  Future<void> saveUserToLocalStorage(String id, String name, String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_id', id);
    await prefs.setString('user_name', name);
    await prefs.setString('user_email', email);
  }

  Future<User?> loadUserFromLocalStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString('user_id');
    String? name = prefs.getString('user_name');
    String? email = prefs.getString('user_email');

    if (id != null && name != null && email != null) {
      _currentUser = User(id: id, name: name, email: email);
      await getUser(id);
    }
    return _currentUser;
  }

  Future<void> clearUserFromLocalStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  bool isUserLoggedIn() {
    return _currentUser != null;
  }

  Future<void> addToWatchlist(String showId) async {
    if (!isUserLoggedIn()) {
      await loadUserFromLocalStorage();
      if (!isUserLoggedIn()) {
        throw Exception('No user is currently logged in');
      }
    }

    final String? userId = _currentUser!.id;
    if (userId == null || userId.isEmpty) {
      throw Exception('Current user has no valid ID');
    }

    if (_currentUser!.watchlist.contains(showId)) {
      return;
    }

    try {
      _currentUser!.watchlist.add(showId);
      await _usersCollection.doc(userId).update({
        'watchlist': FieldValue.arrayUnion([showId])
      });
    } catch (e) {
      _currentUser!.watchlist.remove(showId);
      throw Exception('Failed to add show to watchlist: $e');
    }
  }

  Future<void> removeFromWatchlist(String showId) async {
    if (!isUserLoggedIn()) {
      await loadUserFromLocalStorage();
      if (!isUserLoggedIn()) {
        throw Exception('No user is currently logged in');
      }
    }

    final String? userId = _currentUser!.id;
    if (userId == null || userId.isEmpty) {
      throw Exception('Current user has no valid ID');
    }

    try {
      if(!_currentUser!.watchlist.contains(showId)) {
        return;
      }
      else {
        _currentUser!.watchlist.remove(showId);
        await _usersCollection.doc(userId).update({
          'watchlist': FieldValue.arrayRemove([showId])
        });
      }
    } on Exception catch (e) {
      print(e.toString());
    }

  }

  Future<List<Movie>> fetchUserShows() async {
    if (!isUserLoggedIn()) {
      await loadUserFromLocalStorage();
      if (!isUserLoggedIn()) {
        throw Exception('No user is currently logged in');
      }
    }

    List<Movie> movies = [];
    final ContentController _contentController = ContentController();
    for (var id in _currentUser!.watchlist) {
      Movie? m = await _contentController.getMovieById(id);
      movies.add(m!);
    }
    return movies;
  }

}