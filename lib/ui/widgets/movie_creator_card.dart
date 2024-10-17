import 'package:filmfolio/controllers/content_controller.dart';
import 'package:filmfolio/models/movie_with_creator.dart';
import 'package:filmfolio/ui/widgets/add_movie_form.dart';
import 'package:flutter/material.dart';


class MovieCreatorCard extends StatefulWidget {
  final MovieWithCreator movieWithCreator;

  const MovieCreatorCard({
    Key? key,
    required this.movieWithCreator,
  }) : super(key: key);

  @override
  State<MovieCreatorCard> createState() => _MovieCreatorCardState();
}

class _MovieCreatorCardState extends State<MovieCreatorCard> {
  final ContentController _contentController = ContentController();
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 100,
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: NetworkImage(widget.movieWithCreator.movie.thumbnailUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                // Movie Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.movieWithCreator.movie.name,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Created by: ${widget.movieWithCreator.user?.name ?? 'Unknown'}',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Created on: ${_formatDate(widget.movieWithCreator.createdAt)}',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.movieWithCreator.movie.storyline,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              // Handle Edit logic here
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      AddMoviePage(movie: widget.movieWithCreator.movie),
                                ),
                              );
                            },
                            child: const Icon(Icons.edit),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                            ),
                          ),
                          const SizedBox(width: 16),
                          ElevatedButton(
                            onPressed: () {
                              _confirmDelete(context);
                            },
                            child: const Icon(Icons.delete),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Movie'),
        content: const Text('Are you sure you want to delete this movie?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              await _contentController.removeMovie(widget.movieWithCreator.movie.id);
              Navigator.pop(context);
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
