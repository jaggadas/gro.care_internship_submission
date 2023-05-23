import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_shorts_internship_submission/screens/selection_screen_overlay.dart';
import 'package:flutter_shorts_internship_submission/screens/video_swiper_screen.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../models/Video.dart';
import 'package:http/http.dart' as http;

import '../provider/video_provider.dart';

class SelectionScreen extends StatefulWidget {
  const SelectionScreen({Key? key}) : super(key: key);

  @override
  State<SelectionScreen> createState() => _SelectionScreenState();
}

class _SelectionScreenState extends State<SelectionScreen> {
  ValueNotifier<int> currentPage = ValueNotifier<int>(0);
  ValueNotifier<bool> _isLoaded = ValueNotifier<bool>(false);
  int totalPages = 5;
  Future<void> fetchVideos(BuildContext context) async {
    final provider = Provider.of<VideoProvider>(context, listen: false);
    List<Video> videos = [];
    debugPrint('Fetching Videos ...');
    _isLoaded.value = false;
    final response = await http.get(Uri.parse(
        'https://internship-service.onrender.com/videos?page=${currentPage.value}'));
    print(response.body);
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final List<dynamic> videoData = responseData['data']['posts'];
      videos.addAll(
        videoData.map((data) => Video.fromJson(data)).toList(),
      );
      provider.videos = videos;
    }
    _isLoaded.value = true;
  }

  @override
  void initState() {
    super.initState();
    fetchVideos(context);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        title: Text(
          'YouTube Shorts',
          style: GoogleFonts.lilyScriptOne(
              fontWeight: FontWeight.bold,
              color: Color(0xffFF0000),
              fontSize: 30),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: List.generate(totalPages, (index) {
                  return ValueListenableBuilder(
                      valueListenable: currentPage,
                      builder: (context, value, child) {
                        return GestureDetector(
                          onTap: () {
                            currentPage.value = index;
                            fetchVideos(context);
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: currentPage.value == index
                                  ? Colors.white
                                  : Colors.grey,
                            ),
                          ),
                        );
                      });
                }),
              ),
            ),
            Expanded(
                child: ValueListenableBuilder(
                    valueListenable: _isLoaded,
                    builder: (context, value, child) {
                      return Container(
                        child: _isLoaded.value
                            ? Consumer<VideoProvider>(
                                builder: (context, value, child) {
                                return GridView.builder(
                                  shrinkWrap: true,
                                  itemCount: value.videos.length,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 0.5,
                                  ),
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return VideoSwiperScreen(
                                            currentPage: currentPage.value,
                                            currentIndex: index,
                                          );
                                        }));
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          child: Stack(
                                            children: [
                                              Image.network(
                                                value
                                                    .videos[index].thumbnailUrl,
                                                height: double.infinity,
                                                width: double.infinity,
                                                fit: BoxFit.cover,
                                              ),
                                              Container(
                                                height: double.infinity,
                                                child: SelectionScreenOverlay(
                                                    video: value.videos[index]),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              })
                            : Shimmer.fromColors(child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.5,
                        ), itemCount: 10,itemBuilder:   (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(height: MediaQuery.of(context).size.height/5, padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(color:Colors.grey[900]! ,
                                    borderRadius:
                                    BorderRadius.circular(15),
                                  ),),
                              );
                        }),
                            baseColor: Colors.grey[800]!,
                            highlightColor: Colors.grey[900]!)
                      );
                    })),
          ],
        ),
      ),
    );
  }
}
