import 'package:bark_admin/db/DatabaseService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {

TextEditingController categoryController = TextEditingController();
GlobalKey<FormState> _categoryFormKey = GlobalKey();

DatabaseService _databaseService = DatabaseService();

  List<Widget> listWidgets(AsyncSnapshot snapshot) {
    return snapshot.data.documents.map<Widget>((document) {
      return Card(
        child: ListTile(
          leading: Icon(Icons.category),
          title:Text(document["name"]),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Categories"),
      ),
      body: Container(
          child: StreamBuilder(
              stream: Firestore.instance.collection("category").snapshots(),
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
          var alert = new AlertDialog(
            content: Form(
              key: _categoryFormKey,
              child: TextFormField(
                controller: categoryController,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'category cannot be empty';
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(hintText: "add category"),
              ),
            ),
            actions: <Widget>[
              FlatButton.icon(
                onPressed: () {
                  if (categoryController.text != null) {
                    _databaseService.createCategory(categoryController.text);
                  }
                  Fluttertoast.showToast(msg: "category created");
                  Navigator.pop(context);
                },
                icon: Icon(Icons.add),
                label: Text('add'),
              ),
              FlatButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.close),
                label: Text('cancel'),
              ),
            ],
          );
          showDialog(context: context, builder: (_) => alert);
        },
      ),
    );
  }
}
