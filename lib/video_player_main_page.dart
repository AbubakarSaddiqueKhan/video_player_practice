import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
// To display the video's in your flutter project . You must have to add the dependencies of the below package in your project .
// flutter pub add video_player

// For android only .

// If you are using network-based videos, ensure that the following permission is present in your Android Manifest file, located in <project root>/android/app/src/main/AndroidManifest.xm
// <uses-permission android:name="android.permission.INTERNET"/>

// For detailed information about the supported format's of the video player . Kindly read it from the official documentation .
// https://developer.android.com/media/media3/exoplayer/supported-formats
class VideoPlayerMainPage extends StatefulWidget {
  const VideoPlayerMainPage({super.key});

  @override
  State<VideoPlayerMainPage> createState() => _VideoPlayerMainPageState();
}

// You can use the video_player plugin to play videos stored on the file system, as an asset, or from the internet.

class _VideoPlayerMainPageState extends State<VideoPlayerMainPage> {
  //  The VideoPlayerController class allows you to connect to different types of videos and control playback.

  // late VideoPlayerController _videoPlayerController;

  late VideoPlayerController _videoPlayerController;
  late Future<void> _initializeVideoPlayerFuture;

  // @override
  // void initState() {
  //   super.initState();
  //   // Before you can play videos, you must also initialize the controller. This establishes the connection to the video and prepare the controller for playback.
  //   _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(
  //       'https://www.tiktok.com/@engr.mask/video/7271327815964970245'))
  //     // Attempts to open the given [dataSource] and load metadata about the video.
  //     ..initialize().then((_) {
  //       // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
  //       setState(() {});
  //     });
  // }

  @override
  void initState() {
    super.initState();

    _videoPlayerController =
        VideoPlayerController.asset("assets/videos/bakar.mp4");

    _videoPlayerController.addListener(() {
      setState(() {});
    });
    // _videoPlayerController.setLooping(true);
    _initializeVideoPlayerFuture = _videoPlayerController.initialize();
    // _videoPlayerController.play();

    // Create and store the VideoPlayerController. The VideoPlayerController
    // offers several different constructors to play videos from assets, files,
    // or the internet.
    // _videoPlayerController = VideoPlayerController.networkUrl(
    //   Uri.parse(
    //     'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
    //   ),
    // );

    // _initializeVideoPlayerFuture = _videoPlayerController.initialize();
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _videoPlayerController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Video Player"),
        centerTitle: true,
      ),
      body: // Use a FutureBuilder to display a loading spinner while waiting for the
// VideoPlayerController to finish initializing.
          FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the VideoPlayerController has finished initialization, use
            // the data it provides to limit the aspect ratio of the video.
            return AspectRatio(
              aspectRatio: _videoPlayerController.value.aspectRatio,
              // Use the VideoPlayer widget to display the video.
              child: VideoPlayer(_videoPlayerController),
            );
          } else {
            // If the VideoPlayerController is still initializing, show a
            // loading spinner.
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Wrap the play or pause in a call to `setState`. This ensures the
          // correct icon is shown.
          setState(() {
            // If the video is playing, pause it.
            if (_videoPlayerController.value.isPlaying) {
              _videoPlayerController.pause();
            } else {
              // If the video is paused, play it.
              _videoPlayerController.play();
            }
          });
        },
        // Display the correct icon depending on the state of the player.
        child: Icon(
          _videoPlayerController.value.isPlaying
              ? Icons.pause
              : Icons.play_arrow,
        ),
      ),
      // body: Center(
      //     // To use the video player you simply have to call the video player widget in your code .
      //     // The only required property of the video player is controller .
      //     // Now first of all we have to make the video player controller .

      //     // child: VideoPlayer(_videoPlayerController),
      //     // By default, the VideoPlayer widget takes up as much space as possible. This often isn’t ideal for videos because they are meant to be displayed in a specific aspect ratio, such as 16x9 or 4x3.
      //     // Therefore, wrap the VideoPlayer widget in an AspectRatio widget to ensure that the video has the correct proportions.

      //     child: _videoPlayerController.value.isInitialized
      //         ? AspectRatio(
      //             aspectRatio: _videoPlayerController.value.aspectRatio,
      //             // Use the VideoPlayer widget to display the video.
      //             child: VideoPlayer(_videoPlayerController),
      //           )
      //         : const Text("Controller is not yet initialized")),
    );
  }
}
