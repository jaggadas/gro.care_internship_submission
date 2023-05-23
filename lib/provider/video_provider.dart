import 'package:flutter/foundation.dart';
import '../models/Video.dart';

class VideoProvider with ChangeNotifier {
  List<Video> _videos = [];

  List<Video> get videos => _videos;

  set videos(List<Video> value) {
    _videos = value;
    notifyListeners();
  }
}
