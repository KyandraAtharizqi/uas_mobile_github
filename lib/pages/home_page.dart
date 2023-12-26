import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:uasmobile/model/movie_model.dart';
import 'package:uasmobile/pages/movie_detail_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Movie> movies = [];
  List<Movie> filteredMovies = [];
  TextEditingController searchController = TextEditingController();
  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    _fetchMovies();
  }

  Future<void> _fetchMovies() async {
    try {
      final response = await http.get(Uri.parse('https://raw.githubusercontent.com/erik-sytnyk/movies-list/master/db.json'));

      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);

        if (data.containsKey('movies')) {
          List<dynamic> moviesData = data['movies'];
          movies = moviesData.map((dynamic movieJson) => Movie.fromJson(movieJson)).toList();
          filteredMovies = List.from(movies);
          setState(() {});
        }
      }
    } catch (error) {
      print('Error fetching movies: $error');
    }
  }

  void _searchMovies(String query) {
    setState(() {
      filteredMovies = movies
          .where((movie) => movie.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _cancelSearch() {
    setState(() {
      searchController.clear();
      isSearching = false;
      filteredMovies = List.from(movies);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: isSearching
            ? TextField(
                controller: searchController,
                onChanged: _searchMovies,
                decoration: InputDecoration(
                  hintText: 'Search movies...',
                  border: InputBorder.none,
                ),
              )
            : Text('Movies List'),
        actions: [
          isSearching
              ? IconButton(
                  icon: Icon(Icons.cancel),
                  onPressed: _cancelSearch,
                )
              : IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    setState(() {
                      isSearching = true;
                    });
                  },
                ),
        ],
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: filteredMovies.length,
        itemBuilder: (context, index) {
          Movie movie = filteredMovies[index];

          return Card(
            child: InkWell(
              onTap: () {
                // Navigate to MovieDetailPage when a movie is tapped
                Navigator.pushNamed(
                  context,
                  '/detail', // Use the detail page route
                  arguments: movie, // Pass the selected movie as an argument
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Image.network(
                      movie.posterUrl,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.network(
                          'https://sternbergclinic.com.au/wp-content/uploads/2020/03/placeholder.png',
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          movie.title,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text('Year: ${movie.year}'),
                        Text('Genres: ${movie.genres.join(", ")}'),
                        Text('Runtime: ${movie.runtime} minutes'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
