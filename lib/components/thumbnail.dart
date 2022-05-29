import 'package:flutter/material.dart';
import 'package:video_browsing_ui/models/video.dart';

import 'duration_chip.dart';

class Thumbnail extends StatelessWidget {
  final Video video;
  final bool showHeroAnimation;
  final double aspectRatio;

  const Thumbnail({
    super.key,
    required this.video,
    this.showHeroAnimation = false,
    this.aspectRatio = 16 / 9,
  });

  @override
  Widget build(BuildContext context) {
    final thumbnail = AspectRatio(
      aspectRatio: aspectRatio,
      child: Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(video.thumbnailUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          DurationChip(video: video),
        ],
      ),
    );
    return showHeroAnimation
        ? Hero(tag: video.id, child: thumbnail)
        : thumbnail;
  }
}
