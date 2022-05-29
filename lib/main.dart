import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'config/theme.dart';
import 'models/sport.dart';
import 'pages/login_page.dart';
import 'pages/overview_page.dart';
import 'pages/video_page/video_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video Browing UI',
      debugShowCheckedModeBanner: false,
      theme: theme,
      scrollBehavior: const CupertinoScrollBehavior(),
      initialRoute: LoginPage.route,
      routes: {
        LoginPage.route: (_) => const LoginPage(),
        OverviewPage.route: (context) => OverviewPage(
              sport: ModalRoute.of(context)!.settings.arguments as Sport?,
            ),
        VideoPage.route: (context) => VideoPage(
              videoId: ModalRoute.of(context)!.settings.arguments as String,
            ),
      },
    );
  }
}
