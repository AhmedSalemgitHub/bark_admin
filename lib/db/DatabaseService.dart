import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class DatabaseService {
//Firestore instance to retrive the data
  Firestore _firestore = Firestore.instance;

//Collections names
  String productRef = "product";
  String brandRef = "brand";
  String categoryRef = "category";
  String usersRef = "users";

//users services
//Retrive the product data list
  Future<List<DocumentSnapshot>> getUsers() {
    return _firestore.collection(usersRef).getDocuments().then((snaps) {
      return snaps.documents;
    });
  }

//count the users
  int countusers(){
    int count;
    getUsers().then((products){
      count = products.length;
    });
  return count;
  }

//Products Service
//Upload the products
  void uploadProduct(
      {@required String name,
      @required double price,
      @required String brand,
      @required String category,
      @required String description,
      @required String picture,
      @required bool featured}) {
    var id = Uuid();
    String productId = id.v1();

    _firestore.collection(productRef).document(productId).setData({
      'id': productId,
      'name': name,
      'price': price,
      'brand': brand,
      'category': category,
      'description': description,
      'picture': picture,
      'featured': featured
    });
  }

//Retrive the product data list
  Future<List<DocumentSnapshot>> getProduct() {
    return _firestore.collection(productRef).getDocuments().then((snaps) {
      return snaps.documents;
    });
  }

//Update product data
  void updateProduct(String id, Map<String, dynamic> data) {
    _firestore.collection(productRef).document(id).updateData(data);
  }

  //count the products
  int countProducts(){
    int count;
    getProduct().then((products){
      count = products.length;
    });
  return count;
  }

//the brand services
//create a new brand
  void createBrand(String name) {
    var id = Uuid();
    String brandId = id.v1();

    _firestore
        .collection(brandRef)
        .document(brandId)
        .setData({"name": name});
  }

//retrive the brand list
  Future<List<DocumentSnapshot>> getBrands() {
    return _firestore.collection(brandRef).getDocuments().then((snaps) {
      return snaps.documents;
    });
  }

//the category services
//add new category
  void createCategory(String name) {
    var id = Uuid();
    String categoryId = id.v1();

    _firestore
        .collection(categoryRef)
        .document(categoryId)
        .setData({"name": name});
  }

//get the category list
  Future<List<DocumentSnapshot>> getCategories() {
    return _firestore.collection(categoryRef).getDocuments().then((snaps) {
      return snaps.documents;
    });
  }
}
