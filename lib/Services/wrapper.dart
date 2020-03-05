import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:swe/Screens/FirstPage.dart';
import 'package:swe/Screens/HomePage.dart';
import 'userc.dart';


//I don't understand what happened here so don't touch anything



class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print(user);
    if (user == null) {
      return FirstPage();
    }else {
      return HomePage();
    }
  }
}
