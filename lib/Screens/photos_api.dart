import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PhotosApi extends StatefulWidget {
  const PhotosApi({super.key});

  @override
  State<PhotosApi> createState() => _PhotosApiState();
}

class _PhotosApiState extends State<PhotosApi> {
  List<PhotosModel> photoslist = [];
  Future<List<PhotosModel>> getphotos() async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/photos'),
    );
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map i in data) {
        PhotosModel photos = PhotosModel(
          title: i['title'],
          url: i['url'],
          id: i['id'],
          thumbnailUrl: i['thumbnailUrl'],
        );
        photoslist.add(photos);
      }
      return photoslist;
    } else {
      return photoslist;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Photos API'),
        centerTitle: true,
        backgroundColor: Colors.cyan,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getphotos(),
              builder: (context, AsyncSnapshot<List<PhotosModel>> snapshot) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    return Card(
                      color: Colors.brown,
                      elevation: 4,
                      child: ListTile(
                        title: Text(
                          snapshot.data![index].title.toString(),
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        ),
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(
                            snapshot.data![index].url.toString(),
                          ),
                        ),
                        subtitle: Text(
                          snapshot.data![index].id.toString(),
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: photoslist.length,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class PhotosModel {
  String title, url, thumbnailUrl;
  int id;

  PhotosModel({
    required this.title,
    required this.url,
    required this.id,
    required this.thumbnailUrl,
  });
}
