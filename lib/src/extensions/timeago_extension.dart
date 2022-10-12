import 'package:timeago/timeago.dart' as timeago;

extension DateTimeAgo on DateTime {
  String timeAgo() {
    return timeago.format(this, locale: 'en');
  }
}
