import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'HomePage.dart';
import 'package:swe/Services/Auth.dart';
import 'package:swe/constants.dart';
import 'package:swe/Services/LoadingPage.dart';

/*This the first page I Merged Sign In/UP pages to one page I used 
    the Rflutter_alert package to handle it 
    I use the same package in the main page
    check it: https://pub.dev/packages/rflutter_alert 

 */

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  AuthService _auth = AuthService();
  //from this point
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  /*To this point read the docs to understand what happened here 
  check it: https://flutter.dev/docs/cookbook/forms/retrieve-input
            https://flutter.dev/docs/cookbook/forms/validation
  */
  bool loading = false; //the boolean for loading page
  String error = ''; //The error message if you made eid

/*This method called when you leave the page read more about initState and dispose:
https://api.flutter.dev/flutter/widgets/State/initState.html
https://api.flutter.dev/flutter/widgets/State/dispose.html
 */
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //if (loading is true) => show the loading page
    return loading
        ? Loading()
        : Scaffold(
            body: SafeArea(
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).copyWith().size.height,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xff7487a6), Color(0xffffbc2eb)])),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text(
                          'RentAt',
                          style: KTextHomeScreen,
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          'Rent your stuff at RentAt',
                          style: KTextComment,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        ButtonHomePage(
                          buttonColor: Colors.white,
                          borderColor: Color(0xff536077),
                          textColor: Colors.black87,
                          buttonText: 'Log In',
                          route: () {
                            buildAlert(context, 1, 'Log In').show();
                          },
                        ),
                        //This used to make space between widget (Try to remove it to understand)
                        SizedBox(
                          height: 20,
                        ),
                        ButtonHomePage(
                          buttonColor: Color(0xff7487a6),
                          borderColor: Colors.white,
                          textColor: Colors.white,
                          buttonText: 'Create an account',
                          route: () {
                            buildAlert(context, 2, 'Create an account').show();
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
  }

/*To more info about Extract, a widget to method or separate class check Section 12 in Angel course */
  Alert buildAlert(
      BuildContext alertcontext, int typeOfaccess, String accessTitle) {
    dynamic result;
    return Alert(
        context: alertcontext,
        title: accessTitle,
        content: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    icon: Icon(Icons.account_circle),
                    labelText: 'Email',
                  ),
                  validator: (val) =>
                      val.isEmpty ? ('Please enter your E-mail') : null,
                ),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    icon: Icon(Icons.lock),
                    labelText: 'Password',
                  ),
                  validator: (val) =>
                      val.length < 6 ? 'Enter your password' : null,
                ),
                Text(
                  error,
                  style: TextStyle(color: Colors.red),
                )
              ],
            )),
        buttons: [
          DialogButton(
            color: Colors.blueAccent,
            onPressed: () async {
              //Read the document about validate form
              if (_formKey.currentState.validate()) {
                setState(() {
                  loading = true;
                  Navigator.pop(context);
                });
                if (typeOfaccess == 1) {
                  result = await _auth.signInEAndP(
                      emailController.text, passwordController.text);
                  loading = false;
                } else {
                  result = _auth.signUpEAndP(
                      emailController.text, passwordController.text);
                }

                if (result == null) {
                  setState(() {
                    loading = false;
                    error = 'Please check your information';
                    buildAlert(context, typeOfaccess, accessTitle).show();
                  });
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                }
              }
            },
            child: Text(
              accessTitle,
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ]);
  }
}

class ButtonHomePage extends StatelessWidget {
  ButtonHomePage(
      {@required this.buttonColor,
      @required this.borderColor,
      @required this.textColor,
      @required this.buttonText,
      this.route});
  final Color buttonColor;
  final Color borderColor;
  final String buttonText;
  final Function route;
  final Color textColor;
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 220,
        height: 60,
        decoration: BoxDecoration(
            border: Border.all(width: 1, color: borderColor),
            color: buttonColor,
            borderRadius: BorderRadius.circular(10)),
        child: FlatButton(
          child: Text(
            buttonText,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                fontFamily: 'Tajawal',
                color: textColor),
          ),
          onPressed: route,
        ));
  }
}
