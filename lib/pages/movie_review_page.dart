import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:uasmobile/model/movie_model.dart';
import 'package:uasmobile/model/user_model.dart';
import 'package:uasmobile/model/review_model.dart';

class ReviewPage extends StatefulWidget {
  final Movie movie;
  final User user;

  // Modify the constructor to accept named arguments
  ReviewPage({required this.movie, required this.user});

  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  final TextEditingController subjectController = TextEditingController();
  final TextEditingController detailController = TextEditingController();
  List<Review> reviews = [];

  @override
  void initState() {
    super.initState();
    _fetchReviews();
  }

  Future<void> _fetchReviews() async {
    final apiUrl = 'https://api.github.com/repos/YOUR_USERNAME/YOUR_REPO/contents/path/to/reviews.json';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      reviews = data
          .map((json) => Review.fromJson(json))
          .where((review) => review.movieId == widget.movie.id)
          .toList();
      setState(() {});
    } else {
      print('Error fetching reviews: ${response.statusCode}');
    }
  }

  Future<void> submitReview() async {
    final Review review = Review(
      userId: widget.user.id.toString(),
      review: 'Some review text',
      movieId: widget.movie.id.toString(),
      subject: subjectController.text,
      detail: detailController.text,
    );

    final apiUrl = 'https://api.github.com/repos/YOUR_USERNAME/YOUR_REPO/contents/path/to/reviews.json';

    final response = await http.put(
      Uri.parse(apiUrl),
      headers: {
        'Authorization': 'Bearer YOUR_GITHUB_TOKEN',
        'Content-Type': 'application/json',
      },
      body: json.encode(review.toJson()),
    );

    if (response.statusCode == 200) {
      print('Review submitted successfully!');
      _fetchReviews(); // Refresh reviews after submission
    } else {
      print('Error submitting review: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reviews for ${widget.movie.title}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: subjectController,
              decoration: InputDecoration(labelText: 'Subject'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: detailController,
              decoration: InputDecoration(labelText: 'Detail'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: submitReview,
              child: Text('Submit Review'),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: reviews.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(reviews[index].subject),
                    subtitle: Text(reviews[index].detail),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
