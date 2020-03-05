import 'package:flutter/material.dart';
import 'package:swe/Screens/SignInPage.dart';
import 'package:swe/Screens/SignUpPage.dart';
import 'package:swe/Services/Auth.dart';
import 'package:swe/constants.dart';


class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  AuthService auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  ButtonHomePage(
                    buttonColor: Colors.white,
                    borderColor: Color(0xff536077),
                    textColor: Colors.black87,
                    buttonText: 'Sign In',
                    route: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignInPage()),
                      );
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ButtonHomePage(
                    buttonColor: Color(0xff7487a6),
                    borderColor: Colors.white,
                    textColor: Colors.white,
                    buttonText: 'Create an account',
                    route: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpPage()),
                      );
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
            border: Border.all(width: 2, color: borderColor),
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
