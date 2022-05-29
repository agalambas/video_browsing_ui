import 'package:video_browsing_ui/persistent_data.dart';

import 'comment.dart';
import 'sport.dart';

class Video {
  String id;
  final String title;
  final String description;
  final List<String> tags;
  final Sport sport;
  final String creatorId;
  final DateTime postDate;
  final List<Comment> _comments;

  Video({
    required this.id,
    required this.title,
    required this.description,
    required this.tags,
    required this.sport,
    required this.creatorId,
    required this.postDate,
    required List<Comment> comments,
  }) : _comments = comments..sort();

  List<Comment> get comments => [..._comments];
  void addComment(String text) => _comments
    ..add(Comment(
      text: text,
      userId: PersistentData.myUser.id,
      time: DateTime.now(),
    ))
    ..sort();

  //TODO fake video id
  // String get url => 'assets/videos/$id.mp4';
  // String get thumbnailUrl => 'assets/thumbnails/$id.jpg';
  String get url => 'assets/videos/video1.mp4';
  String get thumbnailUrl => 'assets/thumbnails/video1.jpg';
}
