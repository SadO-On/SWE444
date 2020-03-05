import 'package:flutter/material.dart';
import 'package:swe/Screens/HomePage.dart';
import 'package:swe/Services/Auth.dart';
import 'package:swe/constants.dart';
import 'mainPage.dart';
import 'package:swe/Services/LoadingPage.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  String email = '';
  String pass = '';
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;
  final AuthService _auth = AuthService();
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            resizeToAvoidBottomPadding: false,
            body: SafeArea(
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).copyWith().size.height,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.topRight,
                        colors: [Color(0xff7487a6), Color(0xffffbc2eb)])),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: Text(
                        ' Sign In',
                        textAlign: TextAlign.start,
                        style: KTextSignInScreen,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    //The White box
                    Expanded(
                        child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(45),
                              topRight: Radius.circular(45))),
                      child: Padding(
                          padding: EdgeInsets.all(30),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(bottom: 20),
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(45)),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.purple[100],
                                          blurRadius: 20,
                                          offset: Offset(10, 10))
                                    ]),
                                child: Form(
                                  key: _formKey,
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        child: TextFormField(
                                          validator: (val) => val.isEmpty
                                              ? ('Please enter your E-mail')
                                              : null,
                                          onChanged: (val) {
                                            setState(() {
                                              email = val;
                                            });
                                          },
                                          decoration: InputDecoration(
                                              hintText: 'Enter your E-mail',
                                              border: InputBorder.none),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        child: TextFormField(
                                          obscureText: true,
                                          validator: (val) => val.length < 6
                                              ? 'Enter your password'
                                              : null,
                                          onChanged: (val) {
                                            setState(() {
                                              pass = val;
                                            });
                                          },
                                          decoration: InputDecoration(
                                              hintText: 'Enter your password',
                                              border: InputBorder.none),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        child: ButtonHomePage(
                                          buttonColor: Color(0xff7487a6),
                                          borderColor: Colors.white,
                                          textColor: Colors.white,
                                          buttonText: 'Sign In',
                                          route: () async {
                                            if (_formKey.currentState
                                                .validate()) {
                                              setState(() {
                                                loading = true;
                                              });
                                              dynamic result = await _auth
                                                  .signInEAndP(email, pass);
                                              if (result == null) {
                                                setState(() {
                                                  loading = false;
                                                  error =
                                                      'Please check your information';
                                                });
                                              } else {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          HomePage()),
                                                );
                                              }
                                            }
                                          },
                                        ),
                                      ),
                                      Text(
                                        error,
                                        style: TextStyle(color: Colors.red),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          )),
                    ))
                  ],
                ),
              ),
            ),
          );
  }
}
