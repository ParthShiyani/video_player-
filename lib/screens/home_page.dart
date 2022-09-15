import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player_app/screens/globals.dart';

import '../models/videos.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Videos> videos = [];

  loadJsonBank() async {
    String jdonData = await rootBundle.loadString('assets/json/data.json');

    List res = jsonDecode(jdonData);

    setState(() {
      videos = res.map((e) => Videos.fromJSON(e)).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    loadJsonBank();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Video Player"),
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 10, bottom: 10, right: 20, left: 20),
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: videos.length,
          itemBuilder: (context, i) => Container(
            margin: const EdgeInsets.only(top: 15),
            child: InkWell(
              borderRadius: BorderRadius.circular(38),
              onTap: () {
                setState(() {
                  Global.second = videos[i];
                });
                Navigator.of(context)
                    .pushNamed("details_page", arguments: videos[i]);
              },
              child: Stack(
                children: [
                  Container(
                    height: 250,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(38),
                        bottomLeft: Radius.circular(38),
                      ),
                      image: DecorationImage(
                        image: AssetImage(videos[i].image),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(
                      "  *  ${videos[i].category}",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
