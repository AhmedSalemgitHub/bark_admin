import 'package:bark_admin/Models/sold.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SoldPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var sold = Provider.of<List<Sold>>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Admin")),
      body: sold == null
          ? CircularProgressIndicator()
          : ListView.builder(
              itemCount: sold.length ?? 0,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(sold[index].name.toString()),
                );
              }),
    );
  }
}