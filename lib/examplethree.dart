import 'dart:convert';
import 'package:flutter/material.dart';
//step 1 using http package so that we want data from the internet
import 'package:http/http.dart' as http;
import 'Models/usermodel.dart';

class ExampleThree extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ExampleTwoState();
}

class _ExampleTwoState extends State<ExampleThree> {
  //creating basic code to hit/make the request

  List<UserModel> userList = [];

  //using Future funtion, whose return type is List
  Future<List<UserModel>> getUserApi() async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/users'),
    );
    //now importing the data
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map i in data) {
        userList.add(UserModel.fromJson(i));
      }
      return userList;
    } else {
      return userList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text('Api Course')),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getUserApi(),
              builder: (context, AsyncSnapshot<List<UserModel>> snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                } else {
                  return ListView.builder(
                    itemCount: userList.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              ReusbaleRow(
                                title: 'Name',
                                value: snapshot.data![index].name.toString(),
                              ),
                              ReusbaleRow(
                                title: 'username',
                                value: snapshot.data![index].username
                                    .toString(),
                              ),
                              ReusbaleRow(
                                title: 'email',
                                value: snapshot.data![index].email.toString(),
                              ),
                              ReusbaleRow(
                                title: 'Address',
                                value: snapshot.data![index].address!.geo!.lat
                                    .toString(),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ReusbaleRow extends StatelessWidget {
  String title, value;
  ReusbaleRow({Key? key, required this.title, required this.value})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(title), Text(value)],
      ),
    );
  }
}
