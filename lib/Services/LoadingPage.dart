import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: Center(child: SpinKitRing(
        color: Colors.orange[100],
        size: 50,
      ),),
      
    );
  }
}
/*Here's the loading page that appears after you Sign In
or Sign up Originally it's a package so you can know more
about it by following the link:
              https://pub.dev/packages/flutter_spinkit
              feel free to change the shapes or colors     

*/