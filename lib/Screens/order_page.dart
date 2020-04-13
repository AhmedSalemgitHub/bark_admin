import 'package:bark_admin/Models/order.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var order = Provider.of<List<Order>>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Admin")),
      body: order == null
          ? CircularProgressIndicator()
          : ListView.builder(
              itemCount: order.length ?? 0,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(order[index].name.toString()),
                );
              }),
    );
  }
}