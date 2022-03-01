import 'dart:developer';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

abstract class LocalNotificationProperties {
  String get notificationSoundPath;
  String get methodChannelName;
  String get methodChannelId;
  Future notificationDetails();
}

class AuthLocalNotification extends LocalNotificationProperties {
  @override
  String get methodChannelId => 'Auth_local_notification';

  @override
  String get methodChannelName => 'Auth';

  @override
  String get notificationSoundPath => 'notification1';

  @override
  Future notificationDetails() async {
    return NotificationDetails(
        android: AndroidNotificationDetails(
          methodChannelId,
          methodChannelName,
          sound: RawResourceAndroidNotificationSound(notificationSoundPath),
          playSound: true,
          channelDescription: 'Channel description',
          importance: Importance.defaultImportance,
        ),
        iOS: const IOSNotificationDetails());
  }
}

class OrdersLocalNotification extends LocalNotificationProperties {
  @override
  String get methodChannelId => 'Orders_local_notification';

  @override
  String get methodChannelName => 'Orders';

  @override
  String get notificationSoundPath => 'notification2';
  @override
  Future notificationDetails() async {
    return NotificationDetails(
        android: AndroidNotificationDetails(
          methodChannelId,
          methodChannelName,
          sound: RawResourceAndroidNotificationSound(notificationSoundPath),
          playSound: true,
          channelDescription: 'Channel description',
          importance: Importance.defaultImportance,
        ),
        iOS: const IOSNotificationDetails());
  }
}

class ChangeAvailableLocalNotification extends LocalNotificationProperties {
  @override
  String get methodChannelId => 'Change_Available_local_notification';

  @override
  String get methodChannelName => 'Change available';

  @override
  String get notificationSoundPath => 'notification3';
  @override
  Future notificationDetails() async {
    return NotificationDetails(
        android: AndroidNotificationDetails(
          methodChannelId,
          methodChannelName,
          sound: RawResourceAndroidNotificationSound(notificationSoundPath),
          playSound: true,
          channelDescription: 'Channel description',
          importance: Importance.defaultImportance,
        ),
        iOS: const IOSNotificationDetails());
  }
}

class DefaultLocalNotification extends LocalNotificationProperties {
  @override
  String get methodChannelId => 'Default_local_notification';

  @override
  String get methodChannelName => 'Default';

  @override
  String get notificationSoundPath => 'notification4';

  @override
  Future notificationDetails() async {
    log(notificationSoundPath);
    return NotificationDetails(
        android: AndroidNotificationDetails(
          methodChannelId,
          methodChannelName,
          sound: RawResourceAndroidNotificationSound(notificationSoundPath),
          playSound: true,
          channelDescription: 'Channel description',
          importance: Importance.defaultImportance,
        ),
        iOS: const IOSNotificationDetails());
  }
}