import 'package:timeago/timeago.dart' as ago;

class _EnShortMessages extends ago.EnShortMessages {
  @override
  String suffixAgo() => 'ago';
  @override
  String suffixFromNow() => 'from now';
}

extension DateTimeX on DateTime {
  String get timeago {
    // return '8mo ago';
    ago.setLocaleMessages('en_short', _EnShortMessages());
    return ago.format(this, locale: 'en_short');
  }
}

extension DurationX on Duration {
  String format() {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String h = twoDigits(inHours);
    String m = twoDigits(inMinutes.remainder(60));
    String s = twoDigits(inSeconds.remainder(60));
    return h == '00' ? '$m:$s' : '$h:$m:$s';
  }
}
