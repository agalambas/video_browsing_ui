import 'package:flutter/material.dart';
import 'package:video_browsing_ui/components/comment_tile.dart';
import 'package:video_browsing_ui/components/player.dart';
import 'package:video_browsing_ui/components/video_tile.dart';
import 'package:video_browsing_ui/config/constants.dart';
import 'package:video_browsing_ui/config/theme.dart';
import 'package:video_browsing_ui/models/video.dart';
import 'package:video_browsing_ui/persistent_data.dart';

import 'components/comment_box.dart';
import 'components/video_description.dart';

enum _Section {
  none,
  description,
  comments;

  bool get isNone => this == _Section.none;
  bool get isDescription => this == _Section.description;
  bool get isComments => this == _Section.comments;
}

class VideoPage extends StatefulWidget {
  static const route = 'video';

  final String videoId;
  const VideoPage({super.key, required this.videoId});

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  _Section section = _Section.none;
  final commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final video = PersistentData.video(widget.videoId);
    final relatedVideos = PersistentData.videos.where((v) => v.id != video.id);
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Player(video: video),
              if (section.isNone)
                Expanded(
                  child: ListView(
                    children: [
                      title(video),
                      comments(video, showOne: true),
                      for (final video in relatedVideos)
                        VideoTile(video: video, compact: true),
                    ],
                  ),
                ),
              if (section.isDescription) ...[
                title(video),
                Expanded(child: VideoDescription(video: video)),
              ],
              if (section.isComments) ...[
                comments(video),
                Expanded(
                  child: ListView(
                    children: [
                      for (final comment in video.comments)
                        CommentTile(comment),
                    ],
                  ),
                ),
                const Divider(),
                CommentBox(video: video, controller: commentController),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget title(Video video) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () => setState(() {
              section = section.isNone ? _Section.description : _Section.none;
            }),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                  kSpace, kSpace * 3 / 2, kSpace, kSpace * 2),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: VideoTitle(video: video, bigFontSize: true),
                  ),
                  Icon(section.isNone
                      ? Icons.keyboard_arrow_down_outlined
                      : Icons.keyboard_arrow_up_outlined),
                ],
              ),
            ),
          ),
          const Divider(indent: kSpace, endIndent: kSpace),
        ],
      );

  Widget comments(Video video, {bool showOne = false}) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: () => setState(() {
            section = section.isNone ? _Section.comments : _Section.none;
          }),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
                kSpace, kSpace * 3 / 2, kSpace, kSpace * 2),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: showOne
                      ? CrossAxisAlignment.start
                      : CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text.rich(
                        TextSpan(
                          text: 'Comments ',
                          style: theme.textTheme.titleSmall,
                          children: [
                            TextSpan(
                              text: '(${video.comments.length})',
                              style: theme.textTheme.titleSmall!
                                  .copyWith(color: Palette.grey),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Icon(
                      section.isNone
                          ? Icons.unfold_more_outlined
                          : Icons.keyboard_arrow_up_outlined,
                      color: Palette.grey,
                    ),
                  ],
                ),
                if (showOne)
                  CommentTile(
                    video.comments.first,
                    maxLines: 2,
                    padding: EdgeInsets.zero,
                    compact: true,
                  ),
              ],
            ),
          ),
        ),
        if (showOne) const Divider(indent: kSpace, endIndent: kSpace),
      ],
    );
  }
}
