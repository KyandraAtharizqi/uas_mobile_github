import 'package:flutter/material.dart';
import 'package:uasmobile/model/movie_model.dart';
import 'package:uasmobile/model/user_model.dart';
import 'package:uasmobile/controllers/user_manager.dart'; // Import UserManager

class MovieDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Extract the movie argument passed from the home page
    final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;

    return Scaffold(
      appBar: AppBar(
        title: Text('Movie Detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 200, // Adjust the width as needed
              child: Image.network(
                movie.posterUrl,
                errorBuilder: (context, error, stackTrace) {
                  return Image.network(
                    'https://sternbergclinic.com.au/wp-content/uploads/2020/03/placeholder.png',
                    height: 200,
                  );
                },
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: Text(
                movie.title,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Year: ${movie.year}'),
                Text('Genres: ${movie.genres.join(", ")}'),
                Text('Runtime: ${movie.runtime} minutes'),
                Text('Directors: ${movie.director}'),
                Text('Actors: ${movie.actors}'),
                Text('Plot: ${movie.plot}'),
                // Add more details as needed
              ],
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Navigate to ReviewPage when the button is tapped
                Navigator.pushNamed(
                  context,
                  '/review',
                  arguments: {
                    'movie': movie,
                    'user': UserManager.currentUser, // Use UserManager to get the current user
                  },
                );
              },
              child: Text('Leave a Review'),
            ),
          ],
        ),
      ),
    );
  }
}
