import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:swe/Screens/HomePage.dart';
import 'package:swe/Screens/mainPage.dart';
import 'userc.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print(user);
    if (user == null) {
      return MainPage();
    }else {
      return HomePage();
    }
  }
}
