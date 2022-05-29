import 'package:flutter/material.dart';
import 'package:video_browsing_ui/components/thumbnail.dart';
import 'package:video_browsing_ui/components/user_avatar.dart';
import 'package:video_browsing_ui/config/constants.dart';
import 'package:video_browsing_ui/config/extensions.dart';
import 'package:video_browsing_ui/models/video.dart';
import 'package:video_browsing_ui/pages/video_page/video_page.dart';
import 'package:video_browsing_ui/persistent_Data.dart';

class VideoTile extends StatefulWidget {
  final Video video;
  final bool compact;

  const VideoTile({super.key, required this.video, this.compact = false});

  @override
  State<VideoTile> createState() => _VideoTileState();
}

class _VideoTileState extends State<VideoTile> {
  late final creator = PersistentData.user(widget.video.creatorId);

  bool showHeroAnimation = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() => showHeroAnimation = true);
        Navigator.popUntil(context, (route) => route.isFirst);
        Navigator.pushNamed(context, VideoPage.route,
            arguments: widget.video.id);
      },
      child: Padding(
        padding: const EdgeInsets.all(kSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(kBorderRadius),
                  child: Thumbnail(
                    video: widget.video,
                    showHeroAnimation: showHeroAnimation,
                    aspectRatio: widget.compact ? 16 / 5 : 16 / 9,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(kSpace),
                  child: UserAvatar(creator),
                ),
              ],
            ),
            const SizedBox(height: kSpace),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kSpace / 2),
              child: VideoTitle(video: widget.video),
            )
          ],
        ),
      ),
    );
  }
}

class VideoTitle extends StatelessWidget {
  final Video video;
  final bool bigFontSize;

  VideoTitle({
    super.key,
    required this.video,
    this.bigFontSize = false,
  });

  late final creator = PersistentData.user(video.creatorId);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          video.title,
          style: theme.textTheme.titleSmall!
              .copyWith(fontSize: bigFontSize ? 16 : null),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: kSpace / 2),
        Text(
          '${creator.name} ∙ ${video.sport} ∙ ${video.postDate.timeago}',
          style: theme.textTheme.labelSmall,
        ),
      ],
    );
  }
}
