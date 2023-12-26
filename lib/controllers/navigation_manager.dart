// navigation_manager.dart
import 'package:flutter/material.dart';
import 'package:uasmobile/model/movie_model.dart'; // Import your models
import 'package:uasmobile/model/user_model.dart'; // Import your models

class NavigationManager {
  static void navigateToLoginPage(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/login');
  }

  static void navigateToHomePage(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/home');
  }

  static void navigateToMovieDetailPage(BuildContext context, Movie movie) {
    Navigator.pushNamed(
      context,
      '/detail',
      arguments: movie,
    );
  }

  static void navigateToReviewPage(BuildContext context, Movie movie, User user) {
    Navigator.pushNamed(
      context,
      '/review',
      arguments: {
        'movie': movie,
        'user': user,
      },
    );
  }
}