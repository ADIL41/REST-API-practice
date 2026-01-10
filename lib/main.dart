import 'package:flutter/material.dart';
import 'package:rest_api/Screens/user_api.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: const UserApiScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
