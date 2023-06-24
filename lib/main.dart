import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timer/Services/notification_Service.dart';
import 'package:timer/Provider/dateTime_Provider.dart';
import 'package:timer/Provider/clock_Provider.dart';
import 'package:timer/View/tabbar.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationServices().initialiseNotifications();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ClockState(),
        ),
        ChangeNotifierProvider(create: (_) => TimeProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Clock & Alarm App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const MyTabBarView(),
      ),
    );
  }
}
