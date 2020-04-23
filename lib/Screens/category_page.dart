import 'package:bark_admin/Models/categoty.dart';
import 'package:bark_admin/services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var category = Provider.of<List<Category>>(context);
    FirestoreService _db = FirestoreService();

    Future<void> _removeCategory(BuildContext context ,String id) async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Remove Category'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('The selected category will be removed from categories menu, old categories will remain.'),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text('OK'),
                onPressed: () {
                  _db.removeCategoty(id);
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text("Admin")),
      body: category == null
          ? CircularProgressIndicator()
          : ListView.builder(
              itemCount: category.length ?? 0,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(category[index].name.toString()),
                  trailing: InkWell(
                    child: Icon(Icons.delete, color: Colors.red),
                    onTap: () {
                      _removeCategory(context, category[index].id);
                    },
                  ),
                );
              }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _db.addCategoryAlert(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
