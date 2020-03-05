import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseService {
  DataBaseService({this.userId});
  final String userId;
  //Collection reference
  final CollectionReference adsCollection =
      Firestore.instance.collection('Ads');

  Future updateUserAd(String title, int price, String description) async {
    return await adsCollection.document(userId).setData({
      'AdTitle': title,
      'AdPrice': price,
      'AdDescription': description,
    });
  }
  Stream<QuerySnapshot> get ads{
    return adsCollection.snapshots();
  }


}
