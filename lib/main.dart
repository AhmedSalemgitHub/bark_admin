import 'package:bark_admin/Models/brand.dart';
import 'package:bark_admin/Models/categoty.dart';
import 'package:bark_admin/Models/order.dart';
import 'package:bark_admin/Models/product.dart';
import 'package:bark_admin/Models/sold.dart';
import 'package:bark_admin/Models/user.dart';
import 'package:bark_admin/Screens/login.dart';
import 'package:bark_admin/provider/auth_provider.dart';
import 'package:bark_admin/services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final FirestoreService _db = FirestoreService();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<FirestoreService>(create: (BuildContext context) => _db),
        ChangeNotifierProvider.value(value: AuthProvider.initialize()),
        StreamProvider<List<Category>>(create: (BuildContext context) => _db.getCategory()),
        StreamProvider<List<Brand>>(create: (BuildContext context) => _db.getBrand()),
        StreamProvider<List<Product>>(create: (BuildContext context) => _db.getProduct()),
        StreamProvider<List<User>>(create: (BuildContext context) => _db.getUser()),
        StreamProvider<List<Order>>(create: (BuildContext context) => _db.getOrder()),
        StreamProvider<List<Sold>>(create: (BuildContext context) => _db.getSold())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Park Admin',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home:LogIn(),
      ),
    );
  }
}

