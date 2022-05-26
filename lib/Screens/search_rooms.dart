import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductSearch extends SearchDelegate {
  CollectionReference _firebaseFirestore =
      FirebaseFirestore.instance.collection('productlist');

  @override
  List<Widget>? buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        onPressed: () {
          query = "";
        },
        icon: Icon(Icons.close),
      )
    ];
    //throw UnimplementedError();
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    //throw UnimplementedError();
  }

  @override
  Widget buildResults(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firebaseFirestore.snapshots().asBroadcastStream(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          if (snapshot.data!.docs
              .where((QueryDocumentSnapshot<Object?> element) =>
                  element['product_name']
                      .toString()
                      .toLowerCase()
                      .contains(query.toLowerCase()))
              .isEmpty) {
            return Center(
              child: Text('No Rooms found 😔'),
            );
          }

          return ListView(
            children: [
              ...snapshot.data!.docs
                  .where(
                (QueryDocumentSnapshot<Object?> element) =>
                    element['product_name'].toString().toLowerCase().contains(
                          query.toLowerCase(),
                        ),
              )
                  .map(
                (QueryDocumentSnapshot<Object?> data) {
                  final String title = data.get('product_name');
                  final String image = data['product_image'];

                  return ListTile(
                    onTap: () {
                    },
                    title: Text(title),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(image),
                    ),
                  );
                },
              )
            ],
          );
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(
      child: Text('Search for rooms here 😄'),
    );
  }
}
