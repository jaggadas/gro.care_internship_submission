import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shorts_internship_submission/screens/video_element.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../provider/video_provider.dart';

class VideoSwiperScreen extends StatelessWidget {
  final int currentPage;
  final int currentIndex;
  final SwiperController swiperController = SwiperController();
  VideoSwiperScreen({required this.currentPage, required this.currentIndex}) {
    swiperController.index = currentIndex;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Stack(
            children: [
              Consumer<VideoProvider>(builder: (context, value, child) {
                return Swiper(
                  controller: swiperController,
                  itemBuilder: (BuildContext context, int index) {
                    return VideoElement(
                      src: value.videos[index],
                    );
                  },
                  itemCount: value.videos.length,
                  scrollDirection: Axis.vertical,
                );
              }),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('YouTube Shorts',
                        style: GoogleFonts.lilyScriptOne(
                            fontWeight: FontWeight.bold,
                            color: Color(0xffFF0000),
                            fontSize: 30)),
                    Icon(Icons.camera_alt),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
