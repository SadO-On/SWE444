import 'package:flutter/material.dart';
import 'package:swe/Screens/FirstPage.dart';
import 'package:swe/Services/Auth.dart';
import 'package:swe/Model/AdsWidget.dart';
import 'package:swe/Screens/addPostPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:swe/Model/Ads.dart';

class HomePage extends StatefulWidget {
  static String whoAreyou = '';

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
  String _searchText = '';
  List names = new List();
  List<Widget> filtered = [];
   List<String> descriptionCheck = [];
  List filteredNames = new List();
  Icon _searchIcon = new Icon(
    Icons.search,
    color: Colors.white,
  );

  Widget _appBarTitle = Text(HomePage.whoAreyou);
  final TextEditingController _filter = TextEditingController();
  bool state = false;
  List<Widget> adsList = [];
  List<Adss> adsArray = [];

  _HomePageState() {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          filteredNames = names;
        });
      } else {
        setState(() {
          _searchText = _filter.text;
        });
      }
    });
  }
 

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //This is the button in the bottom of the page
        bottomNavigationBar: BottomAppBar(
          color: Colors.deepPurpleAccent,
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
          backgroundColor: Colors.deepPurpleAccent,
          automaticallyImplyLeading: false,
          title: _appBarTitle,
          elevation: 0,
          actions: <Widget>[
          
              FlatButton(onPressed: _searchPressed, child: _searchIcon),
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
              Adss newAdds;
              final ads = snapshot.data.documents;
              for (var ad in ads) {
                  newAdds = Adss();
                newAdds.title = ad.data['title'];
                newAdds.price = ad.data['price'];
                newAdds.description = ad.data['description'];
                newAdds.imageUrl = ad.data['picture'];
                adsArray.add(newAdds);
              }
              for(int i = 0; i < adsArray.length; i++){}

              for (int i = 0; i < ads.length; i++) {
                final adwidget = TitleAd(
                  title: adsArray[i].title,
                  price: adsArray[i].price,
                  description: adsArray[i].description,
                  imageURl: adsArray[i].imageUrl,
                );
                adsList.add(adwidget);
              }

              return state
                  ? _buildList()
                  : ListView(
                      padding: EdgeInsets.only(bottom: 10),
/*And use it here the children of the list view is array of widgets
 like column and rows(2)*/
                      children: fixedListe(),
                    );
            }),
      ),
    );
  }


List<Widget> fixedListe(){
   List<String> descriptionCheck = [];
   List<Widget> lastFilteredList=[];
   for(int i=0 ;i<adsList.length;i++){
     if(!descriptionCheck.contains(adsArray[i].description)){
       final adwidget = TitleAd(
                  title: adsArray[i].title,
                  price: adsArray[i].price,
                  description: adsArray[i].description,
                  imageURl: adsArray[i].imageUrl,
                );
                lastFilteredList.add(adwidget);
                descriptionCheck.add(adsArray[i].description);
     }
   }
   return lastFilteredList;

}
  Widget _buildList() {
    int counter = 0;
    List<Adss> tempList = [];
    List<String> descriptionCheck = [];
    if (!(_searchText.isEmpty)) {
      tempList = new List();
      filtered = new List();
      for (int i = 0; i < adsArray.length; i++) {
        if (adsArray[i]
            .title
            .toLowerCase()
            .contains(_searchText.toLowerCase())) {
          // (an old condition i think it's useless) tadsArray[i].title.toLowerCase()==adsArray[i].title.toLowerCase()&&
          if (tempList.isNotEmpty &&
              descriptionCheck.contains(adsArray[i].description)) {
          } else {
            print(counter);
            tempList.add(adsArray[i]);
            filtered.add(TitleAd(
              title: tempList[counter].title,
              price: tempList[counter].price,
              description: tempList[counter].description,
              imageURl: tempList[counter].imageUrl,
            ));
            descriptionCheck.add(tempList[counter].description);
            counter++;
          }
        }
      }
    }
    return ListView(
      children: filtered,
    );
  }

  void _searchPressed() {
    
    setState(() {
   
      state = true;
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = new Icon(Icons.close);
        this._appBarTitle = new TextField(
          controller: _filter,
          decoration: new InputDecoration(
              prefixIcon: new Icon(Icons.search), hintText: 'Search...'),
        );
      } else {
        state = false;
        this._searchIcon = new Icon(
          Icons.search,
          color: Colors.white,
        );
        this._appBarTitle = Text(HomePage.whoAreyou);
        _filter.clear();
        filtered.clear();
      }
    });
  }
}
