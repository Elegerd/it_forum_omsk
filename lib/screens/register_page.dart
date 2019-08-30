import 'package:flutter/material.dart';
import 'package:it_forum_omsk/screens/main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class RegisterPage extends StatefulWidget {
  RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();
  TextEditingController firstNameInputController;
  TextEditingController lastNameInputController;
  TextEditingController positionInputController;
  TextEditingController companyInputController;
  TextEditingController emailInputController;
  TextEditingController phoneInputController;
  TextEditingController pwdInputController;
  TextEditingController confirmPwdInputController;

  static const iconColor = Color.fromRGBO(123, 123, 130, 0.5);
  static const inputColor = Color.fromRGBO(124, 125, 141, 1);
  static const appTitleColor = Color.fromRGBO(69, 69, 77, 1);
  static const buttonColor = Color.fromRGBO(65, 195, 0, 1);
  static const buttonStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.w800, fontFamily: 'Roboto', color: Colors.white, letterSpacing: 1);
  static const inputStyle = TextStyle(fontSize: 14, fontFamily: 'Roboto', color: inputColor, letterSpacing: 1);

  ThemeData themeData = ThemeData(
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderSide: BorderSide(color: inputColor),
        borderRadius: BorderRadius.circular(15),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: inputColor),
        borderRadius: BorderRadius.circular(15),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: inputColor),
        borderRadius: BorderRadius.circular(15),
      ),
      counterStyle: TextStyle(color: inputColor),
      contentPadding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
      labelStyle: TextStyle(color: inputColor),
      hintStyle: TextStyle(color: inputColor),
    ),
  );

  @override
  initState() {
    firstNameInputController = TextEditingController();
    lastNameInputController = TextEditingController();
    positionInputController = TextEditingController();
    companyInputController = TextEditingController();
    emailInputController = TextEditingController();
    phoneInputController = TextEditingController();
    pwdInputController = TextEditingController();
    confirmPwdInputController = TextEditingController();
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
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80.0),
          child: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.white,
            centerTitle: true,
            leading: Padding(
              padding: EdgeInsets.only(left: 10, top: 20),
              child: IconButton(
                icon: Icon(Icons.arrow_back_ios, size: 20, color: iconColor),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            title: Padding(
              padding: EdgeInsets.only(top: 25),
              child: Text('Регистрация',
                style: TextStyle(color: appTitleColor, fontSize: 24),
              ),
            ),
          ),
        ),
        body: Container(
            child: SingleChildScrollView(
                padding: EdgeInsets.all(20.0),
                child: Form(
                  key: _registerFormKey,
                  child: Theme(
                    data: themeData,
                    child: Column(
                      children: <Widget>[
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(bottom: 10),
                              child: Text("Имя*", style: inputStyle,),
                            ),
                            Container(
                              height: 100,
                              child: TextFormField(
                                controller: firstNameInputController,
                                validator: (value) {
                                  if (value.length < 2) {
                                    return "Пожалуйста, введите корректное имя.";
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(bottom: 10),
                              child: Text("Фамилия*", style: inputStyle,),
                            ),
                            Container(
                              height: 100,
                              child: TextFormField(
                                  controller: lastNameInputController,
                                  validator: (value) {
                                    if (value.length < 3) {
                                      return "Пожалуйста, введите корректную фамилию.";
                                    } else {
                                      return null;
                                    }
                                  }
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(bottom: 10),
                              child: Text("Должность", style: inputStyle,),
                            ),
                            Container(
                              height: 100,
                              child: TextFormField(
                                  decoration: InputDecoration(
                                      labelText: 'Должность',
                                  ),
                                  controller: positionInputController,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(bottom: 10),
                              child: Text("Компания", style: inputStyle,),
                            ),
                            Container(
                              height: 100,
                              child: TextFormField(
                                controller: companyInputController,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(bottom: 10),
                              child: Text("E-mail*", style: inputStyle,),
                            ),
                            Container(
                              height: 100,
                              child: TextFormField(
                                decoration: InputDecoration(
                                    hintText: 'example@itclastersib.ru'
                                ),
                                controller: emailInputController,
                                keyboardType: TextInputType.emailAddress,
                                validator: emailValidator,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(bottom: 10),
                              child: Text("Телефон", style: inputStyle,),
                            ),
                            Container(
                              height: 100,
                              child: TextFormField(
                                controller: phoneInputController,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(bottom: 10),
                              child: Text("Пароля*", style: inputStyle,),
                            ),
                            Container(
                              height: 100,
                              child: TextFormField(
                                decoration: InputDecoration(
                                    hintText: "********"
                                ),
                                controller: pwdInputController,
                                obscureText: true,
                                validator: pwdValidator,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(bottom: 10),
                              child: Text("Подтверждение пароля*", style: inputStyle,),
                            ),
                            Container(
                              height: 100,
                              child: TextFormField(
                                decoration: InputDecoration(
                                    hintText: "********"
                                ),
                                controller: confirmPwdInputController,
                                obscureText: true,
                                validator: pwdValidator,
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            if (_registerFormKey.currentState.validate()) {
                              if (pwdInputController.text == confirmPwdInputController.text) {
                                FirebaseAuth.instance
                                    .createUserWithEmailAndPassword(
                                      email: emailInputController.text,
                                      password: pwdInputController.text
                                    )
                                    .then((currentUser) => Firestore.instance
                                      .collection("users")
                                      .document(currentUser.user.uid)
                                      .setData({
                                        "uid": currentUser.user.uid,
                                        "fname": firstNameInputController.text,
                                        "surname": lastNameInputController.text,
                                        "position": positionInputController.text,
                                        "company": companyInputController.text,
                                        "email": emailInputController.text,
                                        "phone": phoneInputController.text,
                                      })
                                      .then((result) => {
                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => MainScreen(
                                                  uid: currentUser.user.uid,
                                                )
                                            ),
                                                (_) => false
                                        ),
                                        firstNameInputController.clear(),
                                        lastNameInputController.clear(),
                                        positionInputController.clear(),
                                        companyInputController.clear(),
                                        emailInputController.clear(),
                                        phoneInputController.clear(),
                                        pwdInputController.clear(),
                                        confirmPwdInputController.clear()
                                      })
                                    .catchError((err) => print(err))
                                  )
                                  .catchError((err) => print(err));
                              } else {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text("Ошибка"),
                                        content: Text("Пароли не совпадают"),
                                        actions: <Widget>[
                                          FlatButton(
                                            child: Text("Close"),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          )
                                        ],
                                      );
                                    }
                                );
                              }
                            }
                          },
                          child: Container(
                            height: 50,
                            padding: EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              color: buttonColor,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Center(
                                child: Text("Зарегистрироваться", textAlign: TextAlign.center, style: buttonStyle,)
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
            )
        )
    );
  }
}