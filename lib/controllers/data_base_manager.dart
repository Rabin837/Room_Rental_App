import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseManager {
  static dynamic pickStream(bool isAscending) {
    if (isAscending) {
      return FirebaseFirestore.instance
          .collection('productlist')
          .orderBy('product_price', descending: false)
          .snapshots();
    } else {
      return FirebaseFirestore.instance
          .collection('productlist')
          .orderBy('product_price', descending: true)
          .snapshots();
    }
  }
}
