import 'package:bark_admin/Models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<List<User>>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Admin")),
      body: user == null
          ? CircularProgressIndicator()
          : ListView.builder(
              itemCount: user.length ?? 0,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(user[index].name.toString()),
                );
              }),
    );
  }
}