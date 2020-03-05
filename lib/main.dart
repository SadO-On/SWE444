import 'package:flutter/material.dart';
import 'package:swe/Services/Auth.dart';
import 'package:swe/Services/wrapper.dart';

import 'package:provider/provider.dart';
import 'Services/userc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        
        home: Wrapper(),
      ),
    );
  }
}
