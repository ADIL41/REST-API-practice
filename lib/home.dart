import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rest_api/Models/posts_model.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Postsmodel> postslist = [];
  Future<List<Postsmodel>> getpostsapi() async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/posts'),
    );
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      postslist.clear();
      for (Map i in data) {
        postslist.add(Postsmodel.fromJson(i as Map<String, dynamic>));
      }
      return postslist;
    } else {
      return postslist;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('API'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getpostsapi(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Text('Loading');
                } else {
                  return ListView.builder(
                    itemCount: postslist.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: Colors.green,
                        elevation: 10,
                        child: Column(
                          children: [
                            Text(postslist[index].title.toString()),
                            Text(postslist[index].body.toString()),
                          ],
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
