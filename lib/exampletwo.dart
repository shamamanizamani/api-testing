import 'dart:convert';
import 'package:flutter/material.dart';
//step 1 using http package so that we want data from the internet
import 'package:http/http.dart' as http;
import 'Models/postsmodel.dart';
import 'package:flutter/material.dart';

class ExampleTwo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ExampleTwoState();
}

class _ExampleTwoState extends State<ExampleTwo> {
  //creating basic code to hit/make the request

  //the construtor "Photos" we created below, we passed that to List(using list because we have data in array)
  List<Photos> photosList = [];

  Future<List<Photos>> getPhotos() async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/photos'),
    );
    //now importing the data
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map i in data) {
        Photos photos = Photos(title: i['title'], url: i['url']);

        photosList.add(photos);
      }
      return photosList;
    } else {
      return photosList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                future: getPhotos(),
                builder: (context, snapshot) {
                  return ListView.builder(
                    itemCount: photosList.length,
                    itemBuilder: (context, index) {
                      return ListTile(title: Text("Shamama"));
                    },
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

class Photos {
  String title, url;
  //making the consturctor of photos, also we made the model of objects titile and url
  Photos({required this.title, required this.url});
}
