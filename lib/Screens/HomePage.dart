import 'package:flutter/material.dart';
import 'package:swe/Screens/mainPage.dart';
import 'package:swe/Services/Auth.dart';
import 'package:swe/Model/Ads.dart';
import 'package:swe/Screens/addPostPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Firestore f = Firestore.instance;

  final double height = 80;
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
            FlatButton.icon(
                onPressed: () async {
                  await _auth.signOut();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => MainPage()),
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
                children: adsList,
              );
            }),
      ),
    );
  }
}
