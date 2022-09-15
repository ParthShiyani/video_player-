import 'package:flutter/material.dart';
import 'package:video_player_app/screens/details_video_page.dart';
import 'package:video_player_app/screens/home_page.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "/": (context) => HomePage(),
        "details_page": (context) => DetailVideoPage(),
      },
    ),
  );
}
