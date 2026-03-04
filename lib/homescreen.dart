import 'dart:convert';
import 'package:flutter/material.dart';
//step 1 using http package so that we want data from the internet
import 'package:http/http.dart' as http;

import 'Models/postsmodel.dart';

class Homescreen extends StatefulWidget {
  @override
  State<Homescreen> createState() => Home_State();
}

class Home_State extends State<Homescreen> {

  //step 2 writing code to API data from the internet
  List<Postsmodel> postlist = [];
  Future<List<Postsmodel>> getApi() async{
    final reponse = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    var data = jsonDecode(reponse.body.toString());

    //The result (status + body) is stored in response
    // So now, response contains:
    // response.statusCode  // example: 200
    // response.body        // JSON data (as text)
    if(reponse.statusCode == 200){
      for(Map i in data){
        //Postsmodel.fromJson(i) converts that one JSON object into a Dart model
        //postList.add(...) → stores it into the main list that will be shown in the UI
        postlist.add(Postsmodel.fromJson(i));
      }
      return postlist;
    }
    else{
      return postlist;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
          future: getApi(),
          builder: (context, snapshot){
            
          }
      ),
    );
  }
}
