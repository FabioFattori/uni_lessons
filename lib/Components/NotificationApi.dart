import 'package:flutter/material.dart';
import "package:flutter_local_notifications/flutter_local_notifications.dart";
    import 'package:timezone/timezone.dart' as tz;



class NotificationApi {
  static final _notifications = FlutterLocalNotificationsPlugin();

  static Future init({bool initSchedule=false})async{
    const settings = InitializationSettings(
      android: AndroidInitializationSettings("icon"),
      iOS: DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,

      ),
    );


    await _notifications.initialize(settings);
  
  }

  static void showScheduledNotification(
      int id, String title, DateTime scheduledDate) async {
       tz.Location? location = tz.getLocation("Europe/Rome");
    await _notifications.zonedSchedule(
        id,
        title,
        "",
        tz.TZDateTime.from(scheduledDate,location),
        const NotificationDetails(
          iOS: DarwinNotificationDetails(),
            android: AndroidNotificationDetails(
                "UniLessons", "UniLessons")),
                
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
        
        
        );
  }

}