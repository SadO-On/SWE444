import 'package:flutter/material.dart';
import 'package:swe/Screens/HomePage.dart';
import 'package:swe/Services/LoadingPage.dart';
import 'package:swe/constants.dart';
import 'mainPage.dart';
import 'package:swe/Services/Auth.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String email = '';
  String pass = '';
  String error = '';
  bool loading = false;
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            resizeToAvoidBottomInset: false,
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
                      padding: EdgeInsets.all(10),
                      child: Text(
                        ' Create an account',
                        textAlign: TextAlign.start,
                        style: KTextSignUpScreen,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    //The white Box
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
                                      // Container(
                                      //   padding: EdgeInsets.all(10),
                                      //   child: TextField(
                                      //     decoration: InputDecoration(
                                      //         hintText: 'أدخل اسمك',
                                      //         border: InputBorder.none),
                                      //   ),
                                      // ),
                                      // Container(
                                      //   padding: EdgeInsets.all(10),
                                      //   child: TextField(
                                      //     decoration: InputDecoration(
                                      //         hintText: 'أدخل رقم جوالك',
                                      //         border: InputBorder.none),
                                      //   ),
                                      // ),
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        child: TextFormField(
                                          validator: (val) => val.isEmpty
                                              ? 'please Enter an email'
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
                                          validator: (val) => val.length < 6
                                              ? 'please Enter an password that more than 6 char'
                                              : null,
                                          onChanged: (val) {
                                            setState(() {
                                              pass = val;
                                            });
                                          },
                                          obscureText: true,
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
                                          buttonText: 'Create an account',
                                          route: () async {
                                            if (_formKey.currentState
                                                .validate()) {
                                              setState(() {
                                                loading = true;
                                              });
                                              dynamic result = await _auth
                                                  .signUpEAndP(email, pass);
                                              if (result == null) {
                                                setState(() {
                                                  loading = false;
                                                  error =
                                                      'Please use a valid email ';
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
                                      Text(error)
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
