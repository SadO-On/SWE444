import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.purple[200],
      child: Center(child: SpinKitRing(
        color: Colors.orange[100],
        size: 50,
      ),),
      
    );
  }
}