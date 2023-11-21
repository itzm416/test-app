import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Profile extends StatelessWidget {
  final String data;

  const Profile({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Print the data to the console

    String urlToLoad = data; // Change the URL here

    return Scaffold(
      appBar: AppBar(title: const Text('Back')),
      body: WebView(
        initialUrl: urlToLoad,
        javascriptMode: JavascriptMode.unrestricted, // Enable JavaScript
      ),
    );
  }
}
