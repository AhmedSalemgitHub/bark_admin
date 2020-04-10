import 'package:bark_admin/Models/categoty.dart';
import 'package:bark_admin/services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var category = Provider.of<List<Category>>(context);
    FirestoreService _db = FirestoreService();

    return Scaffold(
      appBar: AppBar(title: Text("Admin")),
      body: category == null
          ? CircularProgressIndicator()
          : ListView.builder(
              itemCount: category.length ?? 0,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(category[index].name.toString()),
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