import 'package:flutter/material.dart';

import '../models/Video.dart';

class SelectionScreenOverlay extends StatelessWidget {
  final Video video;
  SelectionScreenOverlay({required this.video});
  @override
  Widget build(BuildContext context) {
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
                  SizedBox(height: 110),
                  Text('${video.title}'),
                  SizedBox(width: 6),
                  Text('11M Views'),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
