import 'package:flutter/material.dart';
import 'package:video_browsing_ui/config/constants.dart';
import 'package:video_browsing_ui/config/extensions.dart';
import 'package:video_browsing_ui/config/theme.dart';
import 'package:video_browsing_ui/models/video.dart';
import 'package:video_player/video_player.dart';

class DurationChip extends StatefulWidget {
  final Video video;
  const DurationChip({super.key, required this.video});

  @override
  State<DurationChip> createState() => _DurationChipState();
}

class _DurationChipState extends State<DurationChip> {
  late final VideoPlayerController _controller =
      VideoPlayerController.asset(widget.video.url)
        ..initialize().then((_) => setState(() {}));

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (!_controller.value.isInitialized) return const SizedBox.shrink();
    return Container(
      margin: const EdgeInsets.all(kSpace),
      padding: const EdgeInsets.symmetric(
        horizontal: kSpace,
        vertical: kSpace / 2,
      ),
      decoration: BoxDecoration(
        color: Palette.textColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        _controller.value.duration.format(),
        style: theme.textTheme.labelMedium,
      ),
    );
  }
}
