import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:filmfolio/models/movie.dart';

class ContentController {
  List<Movie> movies = [];
  final CollectionReference _movieCollection =
  FirebaseFirestore.instance.collection("contents");

  Future<Movie> addMovie(Movie movie) async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      throw Exception('User is not authenticated');
    }

    final Map<String, dynamic> movieJson = {
      "_id": "102e9f5fa8dfb1b0001dda079",
      "name": "Inception",
      "director": "Christopher Nolan",
      "cast": [
        {"name": "Leonardo DiCaprio", "role": "Dom Cobb"},
        {"name": "Joseph Gordon-Levitt", "role": "Arthur"},
        {"name": "Elliot Page", "role": "Ariadne"},
        {"name": "Tom Hardy", "role": "Eames"}
      ],
      "rating": 8.8,
      "reviews": [
        {
          "userId": "64e9f5fa8dfb1b0001e1a080",
          "reviewText":
          "A mind-bending masterpiece that blurs the line between dream and reality.",
          "date": "2024-01-05T00:00:00Z"
        }
      ],
      "popularity": 98,
      "isMovie": true,
      "thumbnailUrl":
      "https://imgs.search.brave.com/qXVg4dhniZlUDRVSsnOj-IQf2EtRBos3TGdGtWdx6KA/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly93YWxs/cGFwZXJjYXZlLmNv/bS93cC9mV25XcEhq/LmpwZw",
      "trailer": "https://www.youtube.com/watch?v=YoHD9XEInc0",
      "photos": [
        "https://imgs.search.brave.com/W8g-4V7jcPKsXuToWz2VdfscOoA2LJB5dwmLEKq09fI/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly9weXhp/cy5ueW1hZy5jb20v/djEvaW1ncy9mYTgv/MzQ1LzYyMGM3OGEw/MGM4M2Q2NTgzMzI4/ZjZlMGUwNjU5OWYy/OGItaW5jZXB0aW9u/LnJzcXVhcmUudzQw/MC5qcGc",
        "https://imgs.search.brave.com/blb9wnHMWjC76Lvc7wQfBvoeVFRNqGDT_b1m8lXgsEE/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly9zdGF0/aWMxLnNyY2RuLmNv/bS93b3JkcHJlc3Mv/d3AtY29udGVudC91/cGxvYWRzLzIwMjEv/MDIvSW5jZXB0aW9u/LXplcm8tZ3Jhdml0/eS1oYWxsd2F5LXNj/ZW5lLWJ0cy5qcGc",
        "https://imgs.search.brave.com/jkaFwNt5ldGouWgb-zQHX9XsbGjMNdOo8UQMBz6jb4Y/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly93YWxs/cGFwZXJjYXZlLmNv/bS93cC9pMkpEbHpX/LmpwZw"
      ],
      "categories": ["Sci-Fi", "Thriller"],
      "storyline":
      "A thief who enters the dreams of others to steal their secrets is given a chance to have his past crimes erased if he can plant an idea in a target's subconscious.",
      "language": "English",
      "releaseDate": "2010-07-16T00:00:00Z",
      "duration": 148,
      "crew": [
        {"name": "Hans Zimmer", "imageUrl": "dummy"},
        {"name": "Wally Pfister", "imageUrl": "dummy"}
      ],
      "awards": [
        {
          "name": "Academy Awards",
          "year": 2011,
          "category": "Best Cinematography"
        },
        {
          "name": "BAFTA Awards",
          "year": 2011,
          "category": "Best Production Design"
        }
      ],
      "numberOfSeasons": null,
      "numberOfEpisodes": null,
      "seasons": []
    };

    try {
      final customMovie = movie;
      await _movieCollection.doc(customMovie.id).set(customMovie.toJson());
      movies.add(customMovie);
      return customMovie;
    } catch (e) {
      print('Error adding movie: $e');
      rethrow;
    }
  }

  Future<void> removeMovie(String id) async {
    await _movieCollection.doc(id).delete();
    movies.removeWhere((movie) => movie.id == id);
  }

  Future<Movie?> getMovieById(String id) async {
    DocumentSnapshot doc = await _movieCollection.doc(id).get();

    if (doc.exists) {
      return Movie.fromJson(doc.data() as Map<String, dynamic>);
    } else {
      return null;
    }
  }

  Future<void> updateMovie(String id, Map<String, dynamic> updatedMovieJson) async {
    final updatedMovie = Movie.fromJson(updatedMovieJson);
    await _movieCollection.doc(id).update(updatedMovie.toJson());
    int index = movies.indexWhere((movie) => movie.id == id);
    if (index != -1) {
      movies[index] = updatedMovie;
    }
  }

  Future<List<Movie>> getAllMovies() async {
    QuerySnapshot snapshot = await _movieCollection.get();
    movies = snapshot.docs
        .map((doc) => Movie.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
    return movies;
  }
}



