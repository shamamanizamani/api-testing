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
  //or -> final usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String message = '';

  Future<void> loginUser(String username, password) async {
    //When dealing with Future or async functions, you must use the await keyword within the try block. Without await, the exception may bypass the catch block.
    try {
      final response = await http.post(
        //response is just a variable. It stores the result returned by the function
        //http.post(...) ✅ THIS is the function, post() is a function from the http package, It sends a POST request
        Uri.parse('https://dummyjson.com/auth/login'),

        //Uri A class from Dart’s core library Used to represent URLs in a structured, safe way
        //parse() A static method of the Uri class Converts a String URL → Uri object
        headers: {'Content-Type': 'application/json'},

        //headers:A named parameter of http.post
        //Content-Type tells the server “Hey server, the data I’m sending is in JSON format.”
        //Without this:Server may think it’s plain text Or form data Or reject the request
        //Body = the message
        //Headers = instructions on how to read the
        body: jsonEncode({'username': username, 'password': password}),
      );

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
    } catch (e) {
      setState(() {
        message = 'Network error ❌\nPlease check your internet';
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
              child: GestureDetector(
                onTap: () {
                  //made it more simple
                  loginUser(
                    usernameController.text.toString(),
                    passwordController.text.toString(),
                  );
                },
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
