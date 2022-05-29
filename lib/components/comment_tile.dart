import 'package:flutter/material.dart';
import 'package:video_browsing_ui/components/user_avatar.dart';
import 'package:video_browsing_ui/config/constants.dart';
import 'package:video_browsing_ui/config/extensions.dart';
import 'package:video_browsing_ui/models/comment.dart';
import 'package:video_browsing_ui/persistent_data.dart';

class CommentTile extends StatelessWidget {
  final Comment comment;
  final int? maxLines;
  final EdgeInsetsGeometry? padding;
  final bool compact;

  CommentTile(
    this.comment, {
    super.key,
    this.maxLines,
    this.padding,
    this.compact = false,
  });

  late final user = PersistentData.user(comment.userId);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: padding ??
          const EdgeInsets.symmetric(
            horizontal: kSpace,
            vertical: kSpace,
          ),
      child: Row(
        crossAxisAlignment:
            compact ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          UserAvatar(user, radius: 12),
          const SizedBox(width: kSpace),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (!compact)
                  Text(
                    '${user.name} ∙ ${comment.time.timeago}',
                    style: theme.textTheme.bodySmall,
                  ),
                Text(
                  comment.text,
                  style: theme.textTheme.bodyMedium,
                  maxLines: maxLines,
                  overflow: maxLines == null
                      ? TextOverflow.visible
                      : TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
