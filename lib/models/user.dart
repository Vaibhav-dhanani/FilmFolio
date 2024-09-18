import 'package:filmfolio/models/watchitem.dart';

class User {
  final String? id;
  final String name;
  final String email;
  List<String> watchlist;

  User({
    required this.id,
    required this.name,
    required this.email,
  }) : watchlist = [];

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'watchlist': watchlist,
  };

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
    )..watchlist = List<String>.from(json['watchlist'] ?? []);
  }
}