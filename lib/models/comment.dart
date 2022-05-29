class Comment implements Comparable {
  final String text;
  final String userId;
  final DateTime time;

  Comment({
    required this.text,
    required this.userId,
    required this.time,
  });

  @override
  int compareTo(other) => other.time.compareTo(time);
}
