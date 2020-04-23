import 'package:bark_admin/Models/categoty.dart';
import 'package:bark_admin/Models/brand.dart';
import 'package:bark_admin/Models/order.dart';
import 'package:bark_admin/Models/product.dart';
import 'package:bark_admin/Models/sold.dart';
import 'package:bark_admin/Models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uuid/uuid.dart';

class FirestoreService with ChangeNotifier{

  Firestore _db = Firestore.instance;

  var id = Uuid();
  
  String _categoryRef = 'category';
  String _brandRef = 'brand';
  String _productRef = 'product';
  String _userRef = 'user';
  String _orderRef = 'order';
  String _soldRef = 'sold';

  Stream<List<Category>> getCategory() {
    return _db
        .collection(_categoryRef)
        .orderBy('name', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.documents
            .map((document) => Category.fromJson(document.data))
            .toList());
  }

  Stream<List<Brand>> getBrand() {
    return _db
        .collection(_brandRef)
        .orderBy('name', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.documents
            .map((document) => Brand.fromJson(document.data))
            .toList());
  }

  Stream<List<Product>> getProduct() {
    return _db
        .collection(_productRef)
        //.orderBy('name', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.documents
            .map((document) => Product.fromJson(document.data))
            .toList());
  }

  Stream<List<User>> getUser() {
    return _db
        .collection(_userRef)
        //.orderBy('name', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.documents
            .map((document) => User.fromJson(document.data))
            .toList());
  }

  Stream<List<Order>> getOrder() {
    return _db
        .collection(_orderRef)
        //.orderBy('name', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.documents
            .map((document) => Order.fromJson(document.data))
            .toList());
  }

  Stream<List<Sold>> getSold() {
    return _db
        .collection(_soldRef)
        //.orderBy('name', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.documents
            .map((document) => Sold.fromJson(document.data))
            .toList());
  }

  Future<void> addCategory(String name) {
    var dataMap = Map<String, dynamic>();
    dataMap['id'] = id.v1();
    dataMap['name'] = name;
    return _db.collection(_categoryRef).document(dataMap['id']).setData(dataMap);
  }

  Future<void> addBrand(String name) {
    var dataMap = Map<String, dynamic>();
    dataMap['id'] = id.v1();
    dataMap['name'] = name;
    return _db.collection(_brandRef).document(dataMap['id']).setData(dataMap);
  }

  Future<void> removeCategoty(String uid) {
    return _db.collection(_categoryRef).document(uid).delete();
  }

  Future<void> removeBrand(String uid) {
    return _db.collection(_brandRef).document(uid).delete();
  }

  addBrandAlert(BuildContext context) {
    TextEditingController brandController = TextEditingController();
    GlobalKey<FormState> _brandFormKey = GlobalKey();

    var alert = new AlertDialog(
      content: Form(
        key: _brandFormKey,
        child: TextFormField(
          controller: brandController,
          validator: (value) {
            if (value.isEmpty) {
              return 'Brand cannot be empty';
            } else {
              return null;
            }
          },
          decoration: InputDecoration(hintText: "add Brand"),
        ),
      ),
      actions: <Widget>[
        FlatButton.icon(
          onPressed: () {
            if (brandController.text != null) {
              addBrand(brandController.text);
              //_databaseService.createBrand(brandController.text);
            }
            Fluttertoast.showToast(msg: "Brand created");
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
  }

  addCategoryAlert(BuildContext context) {
    TextEditingController categoryController = TextEditingController();
    GlobalKey<FormState> _categoryFormKey = GlobalKey();

    var alert = new AlertDialog(
      content: Form(
        key: _categoryFormKey,
        child: TextFormField(
          controller: categoryController,
          validator: (value) {
            if (value.isEmpty) {
              return 'Category cannot be empty';
            } else {
              return null;
            }
          },
          decoration: InputDecoration(hintText: "add Category"),
        ),
      ),
      actions: <Widget>[
        FlatButton.icon(
          onPressed: () {
            if (categoryController.text != null) {
              addCategory(categoryController.text);
              //_databaseService.createBrand(brandController.text);
            }
            Fluttertoast.showToast(msg: "Category created");
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
  }

  void notify(){
    notifyListeners();
  }

  
}
