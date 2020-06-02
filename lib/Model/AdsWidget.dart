import 'package:flutter/material.dart';
import 'package:swe/constants.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class TitleAd extends StatelessWidget {
  TitleAd({this.title, this.price, this.description, this.imageURl});
  final String title;
  final String price;
  final String description;
  final String imageURl;
  final double height = 70;
  bool loading = false;

  String getTitle() {
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
                content: Text(
                  ' \$$price',
                  style: TextStyle(
                      color: Colors.green, fontWeight: FontWeight.bold),
                ),
                desc: '$description',
                image: imageURl == null
                    ? Image.network(
                        'https://www.victoriabox.ca/img/no-product-img.png',
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes
                                  : null,
                            ),
                          );
                        },
                      )
                    : Image.network(
                        imageURl,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes
                                  : null,
                            ),
                          );
                        },
                      ),
                //Image
                buttons: [
                  DialogButton(
                    child: Text(
                      "Back to Home page",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    color: Colors.deepPurpleAccent,
                    onPressed: () => Navigator.pop(context),
                    width: 140,
                  )
                ],
              ).show();
            },
            child: Container(
              height: height,
              padding: EdgeInsets.only(left: 8, right: 8),
              decoration: BoxDecoration(
                  color: Colors.white, border: Border.all(width: 1)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    title != null ? title : '',
                    style: KTextTitleHomePage,
                  ),
                  Text(
                    '\$$price',
                    style: KTextPriceHomePage,
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
