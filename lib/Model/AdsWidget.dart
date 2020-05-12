import 'package:flutter/material.dart';
import 'package:swe/constants.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:swe/Services/LoadingPage.dart';

class TitleAd extends StatelessWidget {
  TitleAd({this.title, this.price, this.description,this.imageURl});
  final String title;
  final String price;
  final String description;
  final String imageURl;
  final double height = 70;
  bool loading=false;

  String getTitle(){
    return title;
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      
      children: <Widget>[
        Expanded(
          child: InkWell(
            onTap: () {
              Alert(
                context: context,
                title: '$title',
                desc: '$description',    
                image: Image.network(imageURl),
                //Image  
                buttons: [
                  DialogButton(
                    
                    child: Text(
                      "Go to Home page",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),color: Colors.red,
                    onPressed: () => Navigator.pop(context),
                    width: 140,
                  )
                ],
              ).show();
            },
            child: Container(
              height: height,
              padding: EdgeInsets.only(left: 8,right: 8),
              decoration: BoxDecoration(
                
                  color: Colors.white, border: Border.all(width: 1)),
              child: Row(
                
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(title!=null?title:'',
                      style: KTextTitleHomePage,),
                  Text('\$$price',style: KTextPriceHomePage,)
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
