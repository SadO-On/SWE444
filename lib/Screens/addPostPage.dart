import 'package:flutter/material.dart';
import 'package:swe/Screens/HomePage.dart';
import 'package:swe/Services/Auth.dart';
import 'package:swe/Screens/FirstPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class AddNewAds extends StatefulWidget {
  @override
  _AddNewAdsState createState() => _AddNewAdsState();
}

class _AddNewAdsState extends State<AddNewAds> {
  final _formKey = GlobalKey<FormState>();
  File _image;
  String title;
  String picture;
  String price;
  String description;
  String imageUrl;
  

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
      resizeToAvoidBottomInset: false,
        bottomNavigationBar: BottomAppBar(
          color: Colors.deepPurpleAccent,
          child: IconButton(
            icon: Icon(
              Icons.done,
              color: Colors.white,
            ),
            onPressed: () async {
              if(_image != null){
                final FirebaseStorage storage= FirebaseStorage.instance; 
                final StorageReference ref = FirebaseStorage.instance.ref().child("${DateTime.now().millisecondsSinceEpoch.toString()}.jpg"); 
                StorageUploadTask uploadTask = ref.putFile(_image);
                var dowurl = await (await uploadTask.onComplete).ref.getDownloadURL();
                picture= dowurl.toString();
                StorageUploadTask task= storage.ref().child(picture).putFile(_image);
                task.onComplete.then((snapshot) async{
                    imageUrl= await snapshot.ref.getDownloadURL();
                });
               }

              /*Here to make sure that the user fill all the field */
              if (_formKey.currentState.validate()) {
                f.collection('Ads').add({
                  'title': title,
                  'price': price,
                  'description': description,
                  'picture': picture
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
          backgroundColor: Colors.deepPurpleAccent,
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
              Center(
                child: Container(
                  margin: EdgeInsets.only(top:15),
                  width: 200,
                  height: 200,
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: OutlineButton(
                        borderSide: BorderSide(
                            color: Colors.grey.withOpacity(0.5), width: 2.5),
                        onPressed: () {
                          _selectImage(
                              ImagePicker.pickImage(source: ImageSource.gallery));
                        },
                        child: _displayChild()),
                  ),
                ),
              )
            ],
          ),
        ));
  }

  void _selectImage(Future<File> pickImage) async {
    File tempImg = await pickImage;
    setState(() => _image = tempImg);
  }

  Widget _displayChild() {
    if (_image == null) {
      return Padding(
          padding: const EdgeInsets.fromLTRB(14, 70, 14, 70),
          child: new Icon(
            Icons.add,
            color: Colors.grey,
          ));
    } else {
      return Padding(
          padding: const EdgeInsets.fromLTRB(14, 70, 14, 70),
          child: Image.file(_image));
    }
  }
}
