class Video {
  final String title;
  final String thumbnailUrl;
  final String videoUrl;
  final String creatorName;
  final String creatorImage;
  final int likeCount;
  final int commentCount;

  Video(
      {required this.title,
      required this.thumbnailUrl,
      required this.videoUrl,
      required this.creatorName,
      required this.creatorImage,
      required this.likeCount,
      required this.commentCount});

  @override
  String toString() {
    return 'Video{title: $title, thumbnailUrl: $thumbnailUrl, videoUrl: $videoUrl, creatorName: $creatorName, creatorImage: $creatorImage, likeCount: $likeCount, commentCount: $commentCount}';
  }

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
        title: json['submission']['title'],
        thumbnailUrl: json['submission']['thumbnail'],
        videoUrl: json['submission']['mediaUrl'],
        creatorName: json['creator']['handle'],
        creatorImage: json['creator']['pic'],
        likeCount: json['reaction']['count'],
        commentCount: json['comment']['count']);
  }
}
