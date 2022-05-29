import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:video_browsing_ui/components/video_tile.dart';
import 'package:video_browsing_ui/config/constants.dart';
import 'package:video_browsing_ui/models/sport.dart';
import 'package:video_browsing_ui/pages/login_page.dart';
import 'package:video_browsing_ui/persistent_data.dart';

class OverviewPage extends StatefulWidget {
  static const route = 'overview';
  final Sport? sport;

  const OverviewPage({super.key, this.sport});

  @override
  State<OverviewPage> createState() => _OverviewPageState();
}

class _OverviewPageState extends State<OverviewPage> {
  late Sport? selectedSport = widget.sport;
  bool showComments = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final videos = selectedSport == null
        ? PersistentData.videos
        : PersistentData.videos.where((v) => v.sport == selectedSport);

    return Scaffold(
      appBar: AppBar(
        title: SvgPicture.asset(
          'assets/blindside_horizontal_logo.svg',
          color: theme.colorScheme.onBackground,
          height: 18,
        ),
        actions: [
          IconButton(
            onPressed: () {}, //TODO search
            icon: const Icon(Icons.search_outlined),
          ),
          PopupMenuButton(
            itemBuilder: (context) => [
              const PopupMenuItem<String>(
                value: 'logout',
                child: Text("Logout"),
              ),
            ],
            onSelected: (value) {
              if (value == 'logout') {
                Navigator.of(context).pushReplacementNamed(LoginPage.route);
              }
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          ListView(
            children: [
              const SizedBox(height: kSpace),
              _SportsFilter(
                padding: const EdgeInsets.symmetric(horizontal: kSpace),
                selected: selectedSport,
                onSelected: (sport) => setState(() => selectedSport = sport),
              ),
              const SizedBox(height: kSpace),
              for (final video in videos) VideoTile(video: video),
            ],
          ),
          if (videos.isEmpty)
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(kSpace * 2),
              child: const Text(
                'There are currently\nno videos in this category',
                textAlign: TextAlign.center,
              ),
            ),
        ],
      ),
    );
  }
}

class _SportsFilter extends StatelessWidget {
  final Sport? selected;
  final void Function(Sport?) onSelected;
  final EdgeInsetsGeometry? padding;

  const _SportsFilter({
    required this.selected,
    required this.onSelected,
    this.padding,
  });

  Widget allChip(BuildContext context) {
    final theme = Theme.of(context);
    return ChoiceChip(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      label: Text('All', style: theme.textTheme.labelMedium),
      selected: selected == null,
      onSelected: (_) => onSelected(null),
    );
  }

  Widget sportChip(BuildContext context, Sport sport) {
    final theme = Theme.of(context);
    return ChoiceChip(
      label: Text(sport.toString(), style: theme.textTheme.labelMedium),
      selected: sport == selected,
      onSelected: (_) => onSelected(sport),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kChipHeight,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: padding,
        itemCount: Sport.values.length + 1,
        separatorBuilder: (_, __) => const SizedBox(width: kSpace),
        itemBuilder: (_, i) {
          return i == 0
              ? allChip(context)
              : sportChip(context, Sport.values[i - 1]);
        },
      ),
    );
  }
}
