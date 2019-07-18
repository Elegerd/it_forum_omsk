import 'package:flutter/material.dart';
import 'package:it_forum_omsk/screens/main_screen.dart';
import 'package:flutter/services.dart';


//void main() => runApp(App());
void main() {
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((_) => runApp(App()));
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "IT-FORUM",
      theme: ThemeData.light(),
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
    );
  }
}