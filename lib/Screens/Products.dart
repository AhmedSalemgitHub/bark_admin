import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'add_product.dart';

class Products extends StatelessWidget {
  List<Widget> listWidgets(AsyncSnapshot snapshot) {
    return snapshot.data.documents.map<Widget>((document) {
      return Card(
        child: Column(
          children: <Widget>[
            Text(document["id"]),
            Text(document["name"]),
            Text(document["category"]),
            Text(document["description"]),
            Text(document["featured"].toString()),
            Text(document["price"].toString()),
            Text(document["brand"]),
          ],
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Products"),
      ),
      body: Container(
          child: StreamBuilder(
              stream: Firestore.instance.collection("product").snapshots(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return CircularProgressIndicator();
                    break;
                  case ConnectionState.none:
                    return Center(
                        child: Text(
                      "No Internet Connection",
                      style: TextStyle(fontSize: 20, color: Colors.red),
                    ));
                    break;
                  default:
                    return ListView(children: listWidgets(snapshot));
                }
              })),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddProduct()));
        },
      ),
    );
  }
}
