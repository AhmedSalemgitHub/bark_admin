import 'package:bark_admin/Models/brand.dart';
import 'package:bark_admin/services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Brands extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var brand = Provider.of<List<Brand>>(context);
    FirestoreService _db = FirestoreService();

    return Scaffold(
      appBar: AppBar(title: Text("Admin")),
      body: brand == null
          ? CircularProgressIndicator()
          : ListView.builder(
              itemCount: brand.length ?? 0,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(brand[index].name.toString()),
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