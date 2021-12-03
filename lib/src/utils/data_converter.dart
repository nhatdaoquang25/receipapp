import 'package:cloud_firestore/cloud_firestore.dart';

import '../constants/constants_number.dart';
import '../constants/constants_text.dart';

class DataConverter {
  static String getFeedTime(Timestamp postTime) {
    final DateTime feedTime =
        DateTime.fromMillisecondsSinceEpoch(postTime.millisecondsSinceEpoch);
    String resultTime;
    final Duration subTime = DateTime.now().difference(feedTime);
    final int subSecond = subTime.inSeconds;
    if (subSecond < FeedNumber.oneMinute) {
      resultTime = FeedText.justNow;
    } else if (subSecond > FeedNumber.secondsOfMinute &&
        subSecond < FeedNumber.oneHour) {
      resultTime = subTime.inMinutes.toString() + FeedText.minAgo;
    } else if (subSecond > FeedNumber.secondsOfHour &&
        subSecond < FeedNumber.oneDay) {
      resultTime = subTime.inHours.toString() + FeedText.hourAgo;
    } else if (subSecond > FeedNumber.secondsOfDay &&
        subSecond < FeedNumber.oneWeek) {
      resultTime = subTime.inDays.toString() + FeedText.dayAgo;
    } else if (subSecond > FeedNumber.secondsOfWeek &&
        subSecond < FeedNumber.oneMonth) {
      resultTime = (subTime.inDays / FeedNumber.daysOfWeek).floor().toString() +
          FeedText.weekAgo;
    } else if (subSecond > FeedNumber.secondsOfMonth &&
        subSecond < FeedNumber.thirtySevenDays) {
      resultTime =
          (subTime.inDays / FeedNumber.daysOfMonth).floor().toString() +
              FeedText.monthAgo;
    } else {
      resultTime = '${feedTime.day}/${feedTime.month}/${feedTime.year}';
    }
    return resultTime;
  }

  static String getReaction(String reactions) {
    int reactNumber = int.parse(reactions);
    String prefix;
    String suffix;
    if (reactions.length <= FeedNumber.zeroQuantityOfMillion &&
        reactions.length > FeedNumber.zeroQuantityOfThousand) {
      prefix =
          (reactNumber / FeedNumber.oneThousand).toString().split('.').first;
      suffix =
          (reactNumber / FeedNumber.oneThousand).toString().split('.').last;
      return prefix + '.' + suffix.substring(0, 1) + 'K';
    } else if (reactions.length <= FeedNumber.zeroQuantityOfBillion &&
        reactions.length > FeedNumber.zeroQuantityOfMillion) {
      prefix =
          (reactNumber / FeedNumber.oneMillion).toString().split('.').first;
      suffix = (reactNumber / FeedNumber.oneMillion).toString().split('.').last;
      return prefix + '.' + suffix.substring(0, 1) + 'M';
    } else if (reactions.length > FeedNumber.zeroQuantityOfBillion) {
      prefix =
          (reactNumber / FeedNumber.oneBillion).toString().split('.').first;
      suffix = (reactNumber / FeedNumber.oneBillion).toString().split('.').last;
      return prefix + '.' + suffix.substring(0, 1) + 'B';
    } else {
      return reactNumber.toString();
    }
  }
}
