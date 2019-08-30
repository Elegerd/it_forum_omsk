import 'package:flutter/material.dart';
import 'package:it_forum_omsk/screens/main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  TextEditingController emailInputController;
  TextEditingController pwdInputController;

  static const mainColor = Color.fromRGBO(50, 21, 121, 1);
  static const buttonColor = Color.fromRGBO(65, 195, 0, 1);
  static const buttonStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.w800, fontFamily: 'Roboto', color: Colors.white, letterSpacing: 1);
  static const inputStyle = TextStyle(fontSize: 14, fontFamily: 'Roboto', color: Colors.white, letterSpacing: 1);
  static const logoStyle = TextStyle(fontSize: 24, fontWeight: FontWeight.w800, fontFamily: 'Roboto', color: Colors.white, letterSpacing: 1);


  ThemeData themeData = ThemeData(
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
        borderRadius: BorderRadius.circular(15),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
        borderRadius: BorderRadius.circular(15),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
        borderRadius: BorderRadius.circular(15),
      ),
      counterStyle: TextStyle(color: Colors.white),
      contentPadding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
      labelStyle: TextStyle(color: Colors.white),
      hintStyle: TextStyle(color: Colors.white),
    ),
  );

  @override
  initState() {
    emailInputController = TextEditingController();
    pwdInputController = TextEditingController();
    super.initState();
  }

  String emailValidator(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Недопустимый формат электронной почты';
    } else {
      return null;
    }
  }

  String pwdValidator(String value) {
    if (value.length < 8) {
      return 'Пароль должен быть длиннее 8 символов';
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: mainColor,
        body: Container(
          height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: _loginFormKey,
                child: Theme(
                  data: themeData,
                  child: Column(
                    children: <Widget>[
//                      Container(
//                        height: 300,
//                        width: 300,
//                        padding: EdgeInsets.symmetric(vertical: 50),
//                        child: Image.asset('assets/icons/icon.png'),
//                      ),
                      Center(
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 130),
                          child: Text("ИТ-ФОРУМ", style: logoStyle,),
                        ),
                      ),
                      Container(
                        height: 110,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(bottom: 10),
                              child: Text("Электронная почта", style: inputStyle,),
                            ),
                            TextFormField(
                              style: inputStyle,
                              cursorColor: Colors.white,
                              decoration: InputDecoration(
                                hintText: 'example@itclastersib.ru',
                              ),
                              controller: emailInputController,
                              keyboardType: TextInputType.emailAddress,
                              validator: emailValidator,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 110,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(bottom: 10),
                              child: Text("Пароль", style: inputStyle,),
                            ),
                            TextFormField(
                              style: inputStyle,
                              cursorColor: Colors.white,
                              decoration: InputDecoration(
                                hintText: '********',
                              ),
                              controller: pwdInputController,
                              obscureText: true,
                              validator: pwdValidator,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: GestureDetector(
                          onTap: () {
                            if (_loginFormKey.currentState.validate()) {
                              FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                                  email: emailInputController.text,
                                  password: pwdInputController.text
                                )
                                .then((currentUser) => Firestore.instance
                                  .collection("users")
                                  .document(currentUser.user.uid)
                                  .get()
                                  .then((DocumentSnapshot result) =>
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MainScreen(uid: currentUser.user.uid,)
                                      ),
                                    )
                                  )
                                  .catchError((err) => print(err))
                                )
                                .catchError((err) =>
                                  showDialog(
                                      context: context,
                                      builder: (_) => AlertDialog(
                                        title: Text("Ошибка"),
                                        content: Text("Неверный логин или пароль"),
                                      )
                                  )
                                );
                            }
                          },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: buttonColor,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Center(
                                child: Text("Войти", textAlign: TextAlign.center, style: buttonStyle,)
                            ),
                          ),
                        ),
                      ),
                      FlatButton(
                        padding: EdgeInsets.only(top: 10),
                        child: Text("Регистрация", style: TextStyle(color: Color.fromRGBO(255, 255, 255, 0.7), fontSize: 16,),),
                        onPressed: () {
                          emailInputController.clear();
                          pwdInputController.clear();
                          Navigator.pushNamed(context, "/register");
                        },
                      ),
                    ],
                  ),
                ),
              )
          ),
        )
    );
  }
}