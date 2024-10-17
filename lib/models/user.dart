class User {
  final String id;
  final String name;
  final String email;
  List<String> watchlist;
  final String profileUrl;
  final bool isAdmin;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.profileUrl,
    this.isAdmin = false,
  }) : watchlist = [];

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'watchlist': watchlist,
    'profileUrl': profileUrl,
    'isAdmin': isAdmin,
  };

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      profileUrl: json['profileUrl'] as String,
      isAdmin: json['isAdmin'] as bool? ?? true,
    )..watchlist = List<String>.from(json['watchlist'] ?? []);
  }
}
