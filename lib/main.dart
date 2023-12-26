import 'package:flutter/material.dart';
import 'package:uasmobile/pages/login_page.dart';
import 'package:uasmobile/pages/home_page.dart';
import 'package:uasmobile/pages/movie_detail_page.dart';
import 'package:uasmobile/pages/movie_review_page.dart';
import 'package:uasmobile/model/movie_model.dart';
import 'package:uasmobile/model/user_model.dart';
import 'package:uasmobile/model/review_model.dart';
import 'package:uasmobile/controllers/navigation_manager.dart';
import 'package:uasmobile/controllers/user_manager.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/home': (context) => HomePage(),
        '/detail': (context) => MovieDetailPage(),
        '/review': (context) {
          final arguments = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
          return ReviewPage(
            movie: arguments['movie'] as Movie,
            user: arguments['user'] as User,
          );
        },
      },
    );
  }
}
