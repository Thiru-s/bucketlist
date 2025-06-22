
import 'package:easy_localization/easy_localization.dart';

class TimeRule {
  static String timeAgo(String dateString) {
    final dateTime = DateTime.parse(dateString).toLocal();
    final now = DateTime.now();

    if (dateTime.isAfter(now)) return 'just now';

    final difference = now.difference(dateTime);

    if (difference.inSeconds < 60) {
      return 'just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} min ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hr ago';
    } else if (difference.inDays < 30) {
      return '${difference.inDays} day${difference.inDays == 1 ? '' : 's'} ago';
    } else if (difference.inDays < 365) {
      final months = (difference.inDays / 30).floor();
      return '$months month${months == 1 ? '' : 's'} ago';
    } else {
      final years = (difference.inDays / 365).floor();
      return '$years year${years == 1 ? '' : 's'} ago';
    }
  }

  static String formatDate(String dateString) {
    final dateTime = DateTime.parse(dateString).toLocal();
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }
  static String formatToDdMmmYy(String dateStr) {
    try {
      DateTime dateTime = DateTime.parse(dateStr);
      return DateFormat('dd-MMM-yy').format(dateTime);
    } catch (e) {
      return '';
    }
  }

  static String formatInvoiceDate(String createdAt) {
    final DateTime date = DateTime.parse(createdAt).toLocal();
    final DateTime now = DateTime.now();
    final DateTime today = DateTime(now.year, now.month, now.day);
    final DateTime yesterday = today.subtract(Duration(days: 1));
    final DateTime dateOnly = DateTime(date.year, date.month, date.day);

    if (dateOnly == today) {
      return 'Today';
    } else if (dateOnly == yesterday) {
      return 'Yesterday';
    } else {
      return DateFormat('dd-MMM-yyyy').format(date);
    }
  }

  static String formatTo12HourTime(String isoTime) {
    final dateTime = DateTime.parse(isoTime).toLocal(); // Convert to local time zone
    return DateFormat('hh:mm a').format(dateTime); // Format to 12-hour with AM/PM
  }


}
