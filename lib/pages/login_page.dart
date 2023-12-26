
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:uasmobile/controllers/navigation_manager.dart';
import 'package:uasmobile/controllers/user_manager.dart';
import 'package:uasmobile/model/user_model.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
    });

    String username = _usernameController.text;
    String password = _passwordController.text;

    try {
      final response =
          await http.get(Uri.parse('http://34.125.9.63/api/users'));
      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);

        if (data.containsKey('data')) {
          List<dynamic> usersData = data['data'];
          List<User> users = usersData
              .map((dynamic userJson) => User.fromJson(userJson))
              .toList();

          bool isValidUser = users
              .any((user) => user.usr == username && user.pwd == password);

          if (isValidUser) {
            UserManager.currentUser = users.firstWhere(
                (user) => user.usr == username && user.pwd == password);

            NavigationManager.navigateToHomePage(context);
          } else {
            _showErrorDialog('Invalid username or password.');
          }
        } else {
          _showErrorDialog('Invalid response format. Missing "data" key.');
        }
      } else {
        _showErrorDialog(
            'Failed to fetch user data. Status code: ${response.statusCode}');
      }
    } catch (error) {
      _showErrorDialog('Error during login: $error');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Login Failed'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: _isLoading ? null : () => _login(),
              child: _isLoading
                  ? CircularProgressIndicator()
                  : Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
