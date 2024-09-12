import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';

class UserController {
  final CollectionReference _usersCollection = FirebaseFirestore.instance.collection('users');
  User? _currentUser;

  User? get currentUser => _currentUser;

  Future<User> createUser(String id,String name, String email) async {
    _currentUser = User(
      id: id,
      name: name,
      email: email,
    );
    await _usersCollection.doc(_currentUser!.id).set(_currentUser!.toJson());
    return _currentUser!;
  }

  Future<void> getUser(String userId) async {
    DocumentSnapshot doc = await _usersCollection.doc(userId).get();
    if (doc.exists) {
      _currentUser = User.fromJson(doc.data() as Map<String, dynamic>);
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
    }
  }

  Future<void> deleteUser() async {
    if (_currentUser != null) {
      await _usersCollection.doc(_currentUser!.id).delete();
      _currentUser = null;
    }
  }

  Future<List<User>> getAllUsers() async {
    QuerySnapshot querySnapshot = await _usersCollection.get();
    return querySnapshot.docs
        .map((doc) => User.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }

  Future<void> saveUserToLocalStorage(String id,String name,String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user_id', id );
    prefs.setString('user_name', name);
    prefs.setString('user_email', email);
    print(prefs);
  }

  Future<User?> loadUserFromLocalStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString('user_id');
    String? name = prefs.getString('user_name');
    String? email = prefs.getString('user_email');

    if (id != null && name != null && email != null) {
      var user = User(id: id, name: name, email: email);
      print(user);
      return user;
    } else {
      return null;
    }
  }

  void clearUserFromLocalStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

}