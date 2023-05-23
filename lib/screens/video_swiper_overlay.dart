import 'package:flutter/material.dart';

import '../models/Video.dart';

class VideoSwiperOverlay extends StatelessWidget {
  final Video video;
  VideoSwiperOverlay({required this.video});
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: height / 5),
                  Row(
                    children: [
                      CircleAvatar(
                        child:
                            ClipOval(child: Image.network(video.creatorImage)),
                        radius: 16,
                      ),
                      SizedBox(width: height / 50),
                      Text('${video.creatorName}'),
                      SizedBox(width: height / 25),
                      Icon(Icons.verified, size: 15),
                      SizedBox(width: height / 50),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Follow',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: height / 50),
                  Text('${video.title}'),
                  SizedBox(height: height / 60),
                  Row(
                    children: [
                      Icon(
                        Icons.music_note,
                        size: 15,
                      ),
                      Text('Original Audio - some music track--'),
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  Icon(Icons.favorite_outline),
                  Text('${video.likeCount}'),
                  SizedBox(height: height / 50),
                  Icon(Icons.comment_rounded),
                  Text('${video.commentCount}'),
                  SizedBox(height: height / 50),
                  Transform(
                    transform: Matrix4.rotationZ(5.8),
                    child: Icon(Icons.send),
                  ),
                  SizedBox(height: height / 25),
                  Icon(Icons.more_vert),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
