import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Signinlogin extends StatefulWidget {
  const Signinlogin({super.key});
  @override
  State<Signinlogin> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<Signinlogin> {
  //TextEditingController is a built-in class, its like data type int var etc.
  //final -> keyword const
  //TextEditingController() is object and You create an object so you can actually use the features inside the class.

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  String message = '';

  Future<void> loginUser() async {
    setState(() {
      isLoading = true;
      message = '';
    });
    final response = await http.post(
      Uri.parse('https://dummyjson.com/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': usernameController.text.trim(),
        'password': passwordController.text.trim(),
      }),
    );
    setState(() {
      isLoading = false;
    });
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        message = 'Login Successful ✅\nToken: ${data['accessToken']}';
      });
    } else {
      setState(() {
        message = 'Login Failed ❌\nInvalid credentials';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              //controller Connects this TextField to a TextEditingController
              controller: usernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: isLoading ? null : loginUser,
                child: isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Login'),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
