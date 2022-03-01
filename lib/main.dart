import 'dart:developer';

import 'package:device_preview/device_preview.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:htask/bloc_observer.dart';
import 'package:htask/layout/cubit/app_cubit.dart';
import 'package:htask/layout/cubit/app_states.dart';
import 'package:htask/screens/login/login.dart';
import 'package:htask/screens/staff/staff.dart';
import 'package:htask/shared/network/local/cache_helper.dart';
import 'package:htask/shared/network/remote/dio_helper.dart';
import 'package:htask/shared/network/remote/local_notification_statuses.dart';
import 'package:htask/shared/network/remote/local_notifications.dart';
import 'package:htask/shared/network/remote/notifications.dart';
import 'package:htask/translations/translation_loader.dart';

import 'layout/supervisor_layout/supervisor_home_layout.dart';

Future<void> main() async {
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  await Firebase.initializeApp();
  await CacheHelper.init(); // Cache Initialize

  DioHelper.init();
  runApp(
    EasyLocalization(
      path: 'assets/translations',
      supportedLocales: const [Locale('en', 'US'), Locale('ar', 'EG')],
      fallbackLocale: const Locale('en', 'US'),
      assetLoader: const CodegenLoader(),
      child: DevicePreview(
        enabled: !kReleaseMode,
        builder: (context) => const MyApp(), // Wrap your app
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey(debugLabel: "Main Navigator");
  @override
  void initState() {
    super.initState();
    initialize();
  }

  Future<void> initialize() async {
    await FCM().setNotifications(navigatorKey);
    log((await FirebaseMessaging.instance.getToken())!);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AppCubit(context.locale), lazy: false),
      ],
      child: Builder(
        builder: (context) {
          log('Saved language is ${context.locale.toString()}');
          return MaterialApp(
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            navigatorKey: navigatorKey,
            locale: context.locale,
            // locale: Locale("ar", 'EG'),
            title: 'H-Task',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home:
                //  const _TestLocalNotification(),
                // const _TestNotification(),
                AppCubit.instance(context).loginScreenOrHomeScreen(),
          );
        },
      ),
    );
  }
}

class _TestLocalNotification extends StatelessWidget {
  const _TestLocalNotification({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text('Press'.tr()),
      onPressed: () {
        LocalNotifications.showLocalNotification(
          properties: AuthLocalNotification(),
          title: 'Hossam',
          body: 'body',
          payload: 'payload',
        );
      },
    );
  }
}
// class _TestNotification extends StatefulWidget {
//   const _TestNotification({Key? key}) : super(key: key);

//   @override
//   State<_TestNotification> createState() => _TestNotificationState();
// }

// class _TestNotificationState extends State<_TestNotification> {
//   String notificationTitle = 'No Title';
//   String notificationBody = 'No Body';
//   String notificationData = 'No Data';

//   @override
//   void initState() {
//     final firebaseMessaging = FCM();
//     // firebaseMessaging.setNotifications();

//     firebaseMessaging.streamCtlr.stream.listen(_changeData);
//     firebaseMessaging.bodyCtlr.stream.listen(_changeBody);
//     firebaseMessaging.titleCtlr.stream.listen(_changeTitle);

//     super.initState();
//   }

//   _changeData(String msg) => setState(() => notificationData = msg);
//   _changeBody(String msg) => setState(() => notificationBody = msg);
//   _changeTitle(String msg) => setState(() => notificationTitle = msg);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               notificationTitle,
//               style: Theme.of(context).textTheme.headline4,
//             ),
//             Text(
//               notificationBody,
//               style: Theme.of(context).textTheme.headline6,
//             ),
//             Text(
//               notificationData,
//               style: Theme.of(context).textTheme.headline6,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
