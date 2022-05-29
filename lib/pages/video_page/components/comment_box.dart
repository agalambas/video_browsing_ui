import 'package:flutter/material.dart';
import 'package:video_browsing_ui/config/constants.dart';
import 'package:video_browsing_ui/config/theme.dart';
import 'package:video_browsing_ui/models/video.dart';

class CommentBox extends StatefulWidget {
  final Video video;
  final TextEditingController controller;
  const CommentBox({super.key, required this.video, required this.controller});

  @override
  State<CommentBox> createState() => _CommentBoxState();
}

class _CommentBoxState extends State<CommentBox> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      if (widget.controller.text.length == 1 ||
          widget.controller.text.isEmpty) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kSpace * 2),
      child: TextField(
        controller: widget.controller,
        maxLines: null,
        keyboardType: TextInputType.multiline,
        decoration: customInputDecoration(
          hint: 'Add a comment...',
        ).copyWith(
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          suffixIcon: IconButton(
            onPressed: widget.controller.text.isEmpty
                ? null
                : () => setState(() {
                      widget.video.addComment(widget.controller.text);
                      widget.controller.clear();
                      FocusScope.of(context).unfocus();
                    }),
            icon: Icon(
              Icons.send_outlined,
              size: 18,
              color: widget.controller.text.isEmpty
                  ? Palette.lightGrey
                  : Palette.grey,
            ),
          ),
        ),
      ),
    );
  }
}
