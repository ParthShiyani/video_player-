import 'dart:async';
import 'package:flutter/material.dart';
import 'package:video_player_app/screens/globals.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class DetailVideoPage extends StatefulWidget {
  const DetailVideoPage({Key? key}) : super(key: key);

  @override
  State<DetailVideoPage> createState() => _DetailVideoPageState();
}

class _DetailVideoPageState extends State<DetailVideoPage> {
  List<VideoPlayerController> controller = [];
  List<ChewieController> chewieController = [];
  List<VideoPlayerController> networkController = [];
  List<ChewieController> networkChewieController = [];

  List assetsVideos = [];
  List networkVideos = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      assetsVideos = Global.second.assetsVideos;
      networkVideos = Global.second.networkVideos;

      for (var e in assetsVideos) {
        controller.add(VideoPlayerController.asset(e)
          ..initialize().then(
            (_) {
              setState(() {});
            },
          ));
      }

      for (var e in controller) {
        chewieController.add(ChewieController(
          videoPlayerController: e,
          autoPlay: false,
          looping: false,
        ));
        setState(() {});
      }

      Timer.periodic(const Duration(microseconds: 200), (timer) {
        setState(() {});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    dynamic res = ModalRoute.of(context)!.settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(res.category),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            ...assetsVideos
                .map(
                  (e) => Container(
                    margin: const EdgeInsets.only(top: 5, right: 15, left: 15),
                    height: 230,
                    width: double.infinity,
                    child: (controller[assetsVideos.indexOf(e)]
                            .value
                            .isInitialized)
                        ? AspectRatio(
                            aspectRatio: controller[assetsVideos.indexOf(e)]
                                .value
                                .aspectRatio,
                            child: Chewie(
                              controller:
                                  chewieController[assetsVideos.indexOf(e)],
                            ),
                          )
                        : LinearProgressIndicator(),
                  ),
                )
                .toList(),
            // ...networkVideos
            //     .map(
            //       (a) => Container(
            //         margin: const EdgeInsets.only(top: 5, right: 15, left: 15),
            //         height: 230,
            //         width: double.infinity,
            //         child: (controller[networkVideos.indexOf(a)]
            //                 .value
            //                 .isInitialized)
            //             ? AspectRatio(
            //                 aspectRatio: controller[networkVideos.indexOf(a)]
            //                     .value
            //                     .aspectRatio,
            //                 child: Chewie(
            //                   controller:
            //                       chewieController[networkVideos.indexOf(a)],
            //                 ),
            //               )
            //             : LinearProgressIndicator(),
            //       ),
            //     )
            //     .toList(),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    for (var e in controller) {
      chewieController[controller.indexOf(e)].dispose();
      e.dispose();
    }
    for (var e in networkController) {
      networkChewieController[networkController.indexOf(e)].dispose();
      e.dispose();
    }
  }
}
