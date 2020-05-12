import 'package:flutter/material.dart';
import 'package:swe/Screens/HomePage.dart';
import 'package:swe/Services/Auth.dart';
import 'package:swe/Screens/FirstPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddNewAds extends StatefulWidget {
  @override
  _AddNewAdsState createState() => _AddNewAdsState();
}

class _AddNewAdsState extends State<AddNewAds> {
  final _formKey = GlobalKey<FormState>();

  String title;

  String price;

  String description;

  final Firestore f = Firestore.instance;

  final AuthService _auth = AuthService();

/* To more information about this method check:
           Angela course Section 15 lecture 198-199          
 */
  void messageStrem() async {
    await for (var snapshot in f.collection('Ads').snapshots()) {
      for (var ad in snapshot.documents) {
        print(ad);
      }
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomAppBar(
          color: Colors.red,
          child: IconButton(
            icon: Icon(
              Icons.done,
              color: Colors.white,
            ),
            onPressed: () {
              /*Here to make sure that the user fill all the field */
              if (_formKey.currentState.validate()) {
                f.collection('Ads').add({
                  'title': title,
                  'price': price,
                  'description': description,
                  
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              }
            },
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.red,
          //This one to remove the back arrow
          automaticallyImplyLeading: false,
          title: Text('Home Page'),
          elevation: 0,
          actions: <Widget>[
            //signOut button
            FlatButton.icon(
                onPressed: () async {
                  await _auth.signOut();
                  Navigator.push(
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
        //To know more about form read the f*cking docs
        body: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Enter The Ad title',
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter title';
                  }
                  return null;
                },
                onChanged: (value) {
                  title = value;
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Enter The price',
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter the price';
                  }
                  return null;
                },
                onChanged: (value) {
                  price = value;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Enter The Ad description',
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                onChanged: (value) {
                  description = value;
                },
              ),
            ],
          ),
        ));
  }
}
