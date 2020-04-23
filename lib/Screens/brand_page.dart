import 'package:bark_admin/Models/brand.dart';
import 'package:bark_admin/services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BrandPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var brand = Provider.of<List<Brand>>(context);
    FirestoreService _db = FirestoreService();

    Future<void> _removeBrand(BuildContext context ,String id) async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Remove Brand'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('The selected brand will be removed from brands menu, old brands will remain.'),
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
                  _db.removeBrand(id);
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
      body: brand == null
          ? CircularProgressIndicator()
          : ListView.builder(
              itemCount: brand.length ?? 0,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(brand[index].name.toString()),
                  trailing: InkWell(
                    child: Icon(Icons.delete, color: Colors.red),
                    onTap: () {
                      _removeBrand(context, brand[index].id).then((_){
                      });
                    },
                  ),
                );
              }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _db.addBrandAlert(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
