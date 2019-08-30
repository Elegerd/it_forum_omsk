import 'package:flutter/material.dart';
import 'package:it_forum_omsk/screens/splash_page.dart';
import 'package:it_forum_omsk/screens/main_screen.dart';
import 'package:it_forum_omsk/screens/login_page.dart';
import 'package:it_forum_omsk/screens/register_page.dart';
import 'package:flutter/services.dart';


void main() {
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((_) => runApp(App()));
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "IT-FORUM OMSK",
      debugShowCheckedModeBanner: false,
      home: SplashPage(),
      routes: <String, WidgetBuilder>{
        '/home': (BuildContext context) => MainScreen(),
        '/login': (BuildContext context) => LoginPage(),
        '/register': (BuildContext context) => RegisterPage(),
      },
    );
  }
}