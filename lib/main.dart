import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rahbar/providers/user_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'authentication/login_screen.dart';
import 'firebase_options.dart';
import 'api/firebase_api.dart';
import 'navigate.dart';
import 'notification_controller.dart';
import 'notification_screen.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

// global object for accessing device screen size
late Size mq;

final navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Set up portrait orientation
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Set up immersive mode
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  // Initialize Firebase and other services asynchronously
  await _initializeApp();

  runApp(const MyApp());
}

Future<void> _initializeApp() async {
  // Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Initialize notifications
  await FirebaseApi().initNotifications();
  await _setupNotifications();

  // Set up permissions
  await requestPermissions();
}

Future<void> requestPermissions() async {
  Map<Permission, PermissionStatus> statuses = await [
    Permission.camera,
    Permission.location,
    Permission.notification,
    Permission.bluetooth,
    Permission.accessMediaLocation,
    Permission.microphone,
    Permission.photos,
    Permission.videos,
  ].request();

  if (kDebugMode) {
    statuses.forEach((permission, status) {
      print('$permission: $status');
    });
  }
}

Future<void> _setupNotifications() async {
  bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
  if (!isAllowed) {
    await AwesomeNotifications().requestPermissionToSendNotifications();
  }

  await AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
        channelGroupKey: "basic_channel_group",
        channelKey: "basic_channel",
        channelName: "Basic Notification",
        channelDescription: "Basic notifications channel",
      )
    ],
    channelGroups: [
      NotificationChannelGroup(
        channelGroupKey: "basic_channel_group",
        channelGroupName: "Basic Group",
      )
    ],
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    AwesomeNotifications().setListeners(
      onActionReceivedMethod: NotificationController.onActionReceivedMethod,
      onNotificationCreatedMethod: NotificationController.onNotificationCreatedMethod,
      onNotificationDisplayedMethod: NotificationController.onNotificationDisplayedMethod,
      onDismissActionReceivedMethod: NotificationController.onDismissActionReceivedMethod,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
        themeMode: ThemeMode.system, // Set the theme mode to follow the system default theme
        theme: ThemeData.light(), // Set the light theme
        darkTheme: ThemeData.dark(), // Set the dark theme
        title: 'Rahbar',
        debugShowCheckedModeBanner: false,
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, usersnapshot) {
            if (usersnapshot.hasData) {
              return NavigatePage();
            } else {
              return LoginScreen();
            }
          },
        ),
        routes: {
          NotificationScreen.route: (context) => const NotificationScreen(),
        },
      ),
    );
  }
}
