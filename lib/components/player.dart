import 'package:flutter/material.dart';
import 'package:video_browsing_ui/config/constants.dart';
import 'package:video_browsing_ui/config/extensions.dart';
import 'package:video_browsing_ui/config/theme.dart';
import 'package:video_browsing_ui/models/video.dart';
import 'package:video_player/video_player.dart';

class Player extends StatefulWidget {
  final Video video;
  const Player({super.key, required this.video});

  @override
  State<Player> createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  late final VideoPlayerController controller =
      VideoPlayerController.asset(widget.video.url)
        ..initialize().then((_) => setState(() {}));

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  bool controlsAreVisible = false;
  void showControls() => setState(() => controlsAreVisible = true);

  void hideControls({bool delayed = false}) {
    void hide() {
      if (controlsAreVisible != false) {
        setState(() => controlsAreVisible = false);
      }
    }

    if (!delayed) return hide();
    Future.delayed(const Duration(seconds: 1), hide);
  }

  void playToggle() {
    controller.value.isPlaying ? controller.pause() : controller.play();
    if (controller.value.isPlaying) hideControls(delayed: true);
    setState(() {});
  }

  void fastRewind() {
    controller.seekTo(controller.value.position - const Duration(seconds: 10));
    if (controller.value.isPlaying) hideControls(delayed: true);
  }

  void fastForward() {
    controller.seekTo(controller.value.position + const Duration(seconds: 10));
    if (controller.value.isPlaying) hideControls(delayed: true);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Hero(
      tag: widget.video.id,
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: controller.value.isInitialized
            ? Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Center(
                    child: AspectRatio(
                      aspectRatio: controller.value.aspectRatio,
                      child: VideoPlayer(controller),
                    ),
                  ),
                  AnimatedOpacity(
                    opacity: controlsAreVisible ? 1 : 0,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeOut,
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: controlsAreVisible ? hideControls : null,
                      child: Container(
                        color: Colors.black38,
                        child: Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                behavior: HitTestBehavior.translucent,
                                onDoubleTap:
                                    controlsAreVisible ? null : fastRewind,
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: IconButton(
                                    onPressed: () {
                                      if (controlsAreVisible) fastRewind();
                                    },
                                    icon: const Icon(Icons.replay_10),
                                    iconSize: 30,
                                    color: theme.colorScheme.onPrimary,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: IconButton(
                                  onPressed: () {
                                    if (controlsAreVisible) playToggle();
                                  },
                                  icon: Icon(
                                    controller.value.isPlaying
                                        ? Icons.pause
                                        : Icons.play_arrow,
                                  ),
                                  iconSize: 48,
                                  color: theme.colorScheme.onPrimary,
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                behavior: HitTestBehavior.translucent,
                                onDoubleTap:
                                    controlsAreVisible ? null : fastForward,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: IconButton(
                                    onPressed: () {
                                      if (controlsAreVisible) fastForward();
                                    },
                                    icon: const Icon(Icons.forward_10),
                                    iconSize: 30,
                                    color: theme.colorScheme.onPrimary,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  AnimatedOpacity(
                    opacity: controlsAreVisible ? 1 : 0,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeOut,
                    child: _ProgressBar(controller),
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: controlsAreVisible ? null : showControls,
                  ),
                ],
              )
            : Image.asset(widget.video.thumbnailUrl),
      ),
    );
  }
}

class _ProgressBar extends StatefulWidget {
  final VideoPlayerController controller;
  const _ProgressBar(this.controller);

  @override
  State<_ProgressBar> createState() => __ProgressBarState();
}

class __ProgressBarState extends State<_ProgressBar> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() => setState(() {}));
  }

  final height = 3.0;
  double get width =>
      widget.controller.value.position.inMilliseconds /
      widget.controller.value.duration.inMilliseconds *
      MediaQuery.of(context).size.width;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(kSpace),
              child: Text(
                '${widget.controller.value.position.format()} / '
                '${widget.controller.value.duration.format()}',
                style: theme.textTheme.labelMedium,
              ),
            ),
            const Spacer(),
            IconButton(
              onPressed: () {}, //TODO fullscreen
              icon: const Icon(Icons.fullscreen),
              color: theme.colorScheme.onPrimary,
            ),
          ],
        ),
        Container(
          height: height,
          color: Palette.lightGrey,
          alignment: Alignment.centerLeft,
          child: Stack(
            children: [
              Container(
                height: height,
                width: width,
                color: Colors.red,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
