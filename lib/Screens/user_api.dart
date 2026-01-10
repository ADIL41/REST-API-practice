import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rest_api/Models/user_model.dart';

class UserApiScreen extends StatefulWidget {
  const UserApiScreen({super.key});

  @override
  State<UserApiScreen> createState() => _UserApiScreenState();
}

class _UserApiScreenState extends State<UserApiScreen> {
  List<UserModel> userlist = [];
  Future<List<UserModel>> getuserapi() async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/users'),
    );
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map i in data) {
        userlist.add(UserModel.fromJson(i as Map<String, dynamic>));
      }
      return userlist;
    } else {
      return userlist;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Getting user Api'),
        backgroundColor: Colors.amber,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getuserapi(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(strokeAlign: 2),
                  );
                } else {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 10,
                        color: Colors.greenAccent,
                        margin: EdgeInsets.all(10),
                        borderOnForeground: true,
                        shape: ShapeBorder.lerp(
                          null,
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          0.5,
                        ),
                        child: Column(
                          children: [
                            Text(snapshot.data![index].name.toString()),
                            Text(snapshot.data![index].email.toString()),
                            Text(snapshot.data![index].phone.toString()),
                            Text(snapshot.data![index].website.toString()),
                            Text(
                              snapshot.data![index].address!.city.toString(),
                            ),
                          ],
                        ),
                      );
                    },
                    itemCount: userlist.length,
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
