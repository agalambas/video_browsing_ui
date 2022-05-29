import 'package:flutter/material.dart';
import 'package:video_browsing_ui/config/theme.dart';
import 'package:video_browsing_ui/models/user.dart';

class UserAvatar extends StatelessWidget {
  final User user;
  final double? radius;
  const UserAvatar(this.user, {super.key, this.radius});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Palette.lightGrey,
      foregroundImage: user.hasPhoto ? AssetImage(user.photoUrl!) : null,
      radius: radius,
      child: Text(
        user.name[0].toUpperCase(),
        style: const TextStyle(color: Palette.grey),
      ),
    );
  }
}
