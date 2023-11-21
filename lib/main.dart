import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'profile.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
// import 'package:firebase_analytics/observer.dart';

Future<void> main(List<String> args) async {
  runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
  // FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(true);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // navigatorObservers: [
      // FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance)
      // ],
      home: Scaffold(
        appBar: AppBar(
          title: Text("Minicoders Family Plans"),
        ),
        body: Home(),
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    OneSignal.shared.setLogLevel(OSLogLevel.debug, OSLogLevel.none);
    OneSignal.shared.setAppId("e9fb36cf-b90e-4fcf-a023-24a872bdc440");
    OneSignal.shared.promptUserForPushNotificationPermission(fallbackToSettings: true);

    OneSignal.shared.setNotificationOpenedHandler((openedResult) {
      var data = openedResult.notification.additionalData!["appurl"].toString();

      FirebaseAnalytics.instance.logEvent(name: 'push_notification');
      
      if (data.isNotEmpty) {

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Profile(data: data), // Pass your data here
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WebView(
      userAgent: "random",
      initialUrl: 'https://parents.minicoders.com/',
      javascriptMode: JavascriptMode.unrestricted, // Enable JavaScript
    );
  }
}
