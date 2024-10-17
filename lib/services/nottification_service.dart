import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initialize() async {
    await _initializeFirebaseMessaging();
    await _initializeLocalNotifications();
  }

  Future<void> _initializeFirebaseMessaging() async {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    print('User granted permission: ${settings.authorizationStatus}');

    String? token = await _firebaseMessaging.getToken();
    print('FCM Token: $token');

    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);
  }

  Future<void> _initializeLocalNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    final DarwinInitializationSettings initializationSettingsIOS =
    DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        print('Notification clicked: ${response.payload}');
      },
    );
  }

  void _handleForegroundMessage(RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    if (notification != null && android != null) {
      _flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            'high_importance_channel',
            'High Importance Notifications',
            importance: Importance.max,
            priority: Priority.high,
            icon: '@mipmap/ic_launcher',
          ),
          iOS: const DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
      );
    }
  }

  // Subscribe user to topics based on their admin status
  Future<void> subscribeUserToTopics(bool isAdmin) async {
    if (isAdmin) {
      await _firebaseMessaging.subscribeToTopic('admin_users');
    } else {
      await _firebaseMessaging.subscribeToTopic('all_users');
    }
  }

  // Unsubscribe user from admin topic
  Future<void> unsubscribeFromAdminTopic() async {
    await _firebaseMessaging.unsubscribeFromTopic('admin_users');
    print('Unsubscribed from admin topic');
  }

  // Update user subscription based on admin status
  Future<void> updateUserSubscriptions(bool isAdmin) async {
    if (isAdmin) {
      await _firebaseMessaging.subscribeToTopic('admin_users');
      print('Subscribed to admin topic');
    } else {
      await _firebaseMessaging.unsubscribeFromTopic('admin_users');
      print('Unsubscribed from admin topic');
    }
  }

  // Send notification to admin users
  Future<void> sendAdminNotification({
    required String title,
    required String body,
  }) async {
    await _firebaseMessaging.subscribeToTopic('admin_users');
    _flutterLocalNotificationsPlugin.show(
      title.hashCode,
      title,
      body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          'high_importance_channel',
          'High Importance Notifications',
          importance: Importance.max,
          priority: Priority.high,
          icon: '@mipmap/ic_launcher',
        ),
        iOS: const DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
    );
  }

  // Send notification to all users
  Future<void> sendNotificationToAllUsers(String message) async {
    await _firebaseMessaging.subscribeToTopic('all_users');
    _flutterLocalNotificationsPlugin.show(
      message.hashCode,
      'New Movie Added',
      message,
      NotificationDetails(
        android: AndroidNotificationDetails(
          'high_importance_channel',
          'High Importance Notifications',
          importance: Importance.max,
          priority: Priority.high,
          icon: '@mipmap/ic_launcher',
        ),
        iOS: const DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
    );
  }

  @pragma('vm:entry-point')
  Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    print('Handling a background message: ${message.messageId}');
  }
}
