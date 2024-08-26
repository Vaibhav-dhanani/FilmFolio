import 'package:flutter/material.dart';
import 'package:filmfolio/src/models/movie.dart';

class AddMovieForm extends StatefulWidget {
  final Function(Movie) onMovieAdded;

  const AddMovieForm({super.key, required this.onMovieAdded});

  @override
  _AddMovieFormState createState() => _AddMovieFormState();
}

class _AddMovieFormState extends State<AddMovieForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _directorController = TextEditingController();
  final _ratingController = TextEditingController();
  final _typeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add a new movie'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                style: const TextStyle(color: Colors.black),
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Movie Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a movie name';
                  }
                  return null;
                },
              ),
              TextFormField(
                style: const TextStyle(color: Colors.black),
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              TextFormField(
                style: const TextStyle(color: Colors.black),
                controller: _directorController,
                decoration: const InputDecoration(labelText: 'Director'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the director\'s name';
                  }
                  return null;
                },
              ),
              TextFormField(
                style: const TextStyle(color: Colors.black),
                controller: _ratingController,
                decoration: const InputDecoration(labelText: 'Rating'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a rating';
                  }
                  if (double.tryParse(value) == null ||
                      double.parse(value) < 0 ||
                      double.parse(value) > 10) {
                    return 'Please enter a valid.\nRating should be between 0 and 10';
                  }
                  return null;
                },
              ),
              TextFormField(
                style: const TextStyle(color: Colors.black),
                controller: _typeController,
                decoration: const InputDecoration(labelText: 'Type'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the type (e.g., Hollywood, Bollywood)';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              final newMovie = Movie(
                name: _nameController.text,
                description: _descriptionController.text,
                images: "",
                rating: double.parse(_ratingController.text),
                type: _typeController.text,
                director: _directorController.text,
              );
              widget.onMovieAdded(newMovie);
            }
          },
          child: const Text('Add'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _directorController.dispose();
    _ratingController.dispose();
    _typeController.dispose();
    super.dispose();
  }
}
