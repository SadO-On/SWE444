import 'package:flutter/material.dart';
import 'package:swe/Screens/FirstPage.dart';
import 'package:swe/Services/Auth.dart';
import 'package:swe/Model/Ads.dart';
import 'package:swe/Screens/addPostPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}
/*This the home page we import the following pckgs:
     Auth: https://pub.dev/packages/firebase_auth
     FireStore: https://pub.dev/packages/cloud_firestore
     To know more about this page (StreamBuilder):
      Angela course Section 15 lecture 200-201
*/
class _HomePageState extends State<HomePage> {
  final Firestore f = Firestore.instance;
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //This is the button in the bottom of the page
        bottomNavigationBar: BottomAppBar(
          color: Colors.red,
          child: IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddNewAds()),
              );
            },
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.red,
          automaticallyImplyLeading: false,
          title: Text('Home Page'),
          elevation: 0,
          actions: <Widget>[
            //Sign out button
            FlatButton.icon(
                onPressed: () async {
                  await _auth.signOut();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => FirstPage()),
                  );
                },
                icon: Icon(
                  Icons.person_outline,
                  color: Colors.white,
                ),
                label: Text(
                  'Logout',
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
        //StreamBuilder
        body: StreamBuilder<QuerySnapshot>(
            stream: f.collection('Ads').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.yellow,
                  ),
                );
              }
              final ads = snapshot.data.documents;
              //I save the data in array of widgets(1)
              List<Widget> adsList = [];
              for (var ad in ads) {
                final adsTitle = ad.data['title'];
                final adPrice = ad.data['price'];
                final adDesc = ad.data['description'];
                final adwidget = TitleAd(
                  title: adsTitle,
                  price: adPrice,
                  description: adDesc,
                );
                adsList.add(adwidget);
              }
              return ListView(
                padding: EdgeInsets.only(bottom: 10),
/*And use it here the children of the list view is array of widgets
 like column and rows(2)*/
                children: adsList,
              );
            }),
      ),
    );
  }
}
