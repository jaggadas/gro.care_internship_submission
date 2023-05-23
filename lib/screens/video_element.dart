import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shorts_internship_submission/screens/video_swiper_overlay.dart';
import 'package:shimmer/shimmer.dart';
import 'package:video_player/video_player.dart';
import '../models/Video.dart';

class VideoElement extends StatefulWidget {
  final Video? src;
  const VideoElement({Key? key, this.src}) : super(key: key);

  @override
  _VideoElementState createState() => _VideoElementState();
}

class _VideoElementState extends State<VideoElement> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;
  @override
  void initState() {
    super.initState();
    initializePlayer();
  }

  Future initializePlayer() async {
    _videoPlayerController =
        VideoPlayerController.network(widget.src!.videoUrl);
    await Future.wait([_videoPlayerController.initialize()]);
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      showControls: false,
      looping: true,
    );
    setState(() {});
  }

  double videoContainerRatio = 0.4;
  double getScale() {
    double videoRatio = _videoPlayerController.value.aspectRatio;
    if (videoRatio < videoContainerRatio) {
      return videoContainerRatio / videoRatio;
    } else {
      return videoRatio / videoContainerRatio;
    }
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        _chewieController != null &&
                _chewieController!.videoPlayerController.value.isInitialized
            ? Transform.scale(
                scale: getScale(),
                child: Chewie(
                  controller: _chewieController!,
                ),
              )
            :Shimmer.fromColors(child: Container(height: MediaQuery.of(context).size.height,width: MediaQuery.of(context).size.height,color: Colors.grey[800],),
            baseColor: Colors.grey[800]!,
            highlightColor: Colors.grey[900]!),
        VideoSwiperOverlay(
          video: widget.src!,
        )
      ],
    );
  }
}
