import 'package:filmfolio/models/movie.dart';
import 'package:filmfolio/models/user.dart';

class MovieWithCreator {
  final Movie movie;
  final User? user;
  final DateTime createdAt;

  MovieWithCreator({
    required this.movie,
    required this.user,
    required this.createdAt,
  });
}
