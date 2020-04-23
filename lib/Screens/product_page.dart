import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'add_product.dart';

class ProductPage extends StatelessWidget {
  List<Widget> listWidgets(AsyncSnapshot snapshot) {
    return snapshot.data.documents.map<Widget>((document) {
      return Padding(
        padding: const EdgeInsets.all(4.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              children: <Widget>[
                Text(
                  document["name"],
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(document["id"]),
                Row(
                  children: <Widget>[
                    Image.network(
                      document['picture'],
                      height: 100,
                      width: 100,
                    ),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Text(document["description"]),
//                      Text(document["featured"].toString()),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 4,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      flex: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text("Category : "),
                              Text(document["category"]),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Text("Brand : "),
                              Text(document["brand"]),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: InkWell(
                          onTap: () {
                            _deleteProduct(document["id"]);
                          },
                          child: Icon(
                            Icons.delete,
                            color: Colors.red,
                          )),
                    )
                  ],
                ),
                SizedBox(
                  height: 4,
                ),
                Row(
                  children: <Widget>[
                    Text(
                      "Price : ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${document["price"].toString()} L.E.",
                      textAlign: TextAlign.right,
                    ),
                  ],
                ),
              ],
            ),
          ),
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

  void _deleteProduct(document) {
    Firestore.instance.collection("product").document(document).delete().then((_){
      Fluttertoast.showToast(msg: "Product deleted");
    });
  }
}
