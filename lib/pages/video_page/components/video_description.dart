import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:video_browsing_ui/components/user_avatar.dart';
import 'package:video_browsing_ui/config/constants.dart';
import 'package:video_browsing_ui/models/video.dart';
import 'package:video_browsing_ui/pages/overview_page.dart';
import 'package:video_browsing_ui/persistent_data.dart';

class VideoDescription extends StatelessWidget {
  final Video video;
  const VideoDescription({super.key, required this.video});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kSpace * 2),
      child: ListView(
        children: [
          const SizedBox(height: kSpace * 2),
          details(context, video),
          const SizedBox(height: kSpace * 2),
          Text(
            video.description,
            textAlign: TextAlign.justify,
          ),
          const SizedBox(height: kSpace),
          tags(context, video),
          const SizedBox(height: kSpace * 2),
        ],
      ),
    );
  }

  Widget details(BuildContext context, Video video) {
    final creator = PersistentData.user(video.creatorId);
    final theme = Theme.of(context);
    return Row(
      children: [
        UserAvatar(creator),
        const SizedBox(width: kSpace),
        Expanded(
          child: Text(
            creator.name,
            style: theme.textTheme.bodyLarge,
          ),
        ),
        ActionChip(
          label: Text(
            video.sport.toString(),
            style: theme.textTheme.labelMedium,
          ),
          padding: EdgeInsets.zero,
          visualDensity: VisualDensity.compact,
          onPressed: () => Navigator.pushNamed(context, OverviewPage.route,
              arguments: video.sport),
        ),
      ],
    );
  }

  Widget tags(BuildContext context, Video video) {
    final theme = Theme.of(context);
    return Text.rich(
      TextSpan(
        style: TextStyle(color: theme.primaryColor),
        children: [
          for (final tag in video.tags) ...[
            TextSpan(
                text: '#$tag',
                recognizer: TapGestureRecognizer()
                  ..onTap = () {} //TODO search tag

                ),
            const TextSpan(text: ' '),
          ]
        ]..removeLast(),
      ),
    );
  }
}
