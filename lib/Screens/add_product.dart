import 'dart:io';
import 'package:bark_admin/services/DatabaseService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  DatabaseService _databaseService = DatabaseService();
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  //text controllers for the dialogs
  TextEditingController brandController = TextEditingController();
  TextEditingController productNameController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();
  TextEditingController productDescController = TextEditingController();
  List<DocumentSnapshot> brandsList = <DocumentSnapshot>[];
  List<DocumentSnapshot> categoriesList = <DocumentSnapshot>[];
  List<DropdownMenuItem<String>> categoriesDropDown =
      <DropdownMenuItem<String>>[];
  List<DropdownMenuItem<String>> brandsDropDown = <DropdownMenuItem<String>>[];
  String _currentCategory;
  String _currentBrand;

  File _fileImage1;
  bool isLoading = false;

  @override
  void initState() {
    _getCategories();
    _getBrands();
    super.initState();
  }

  List<DropdownMenuItem<String>> getCategoriesMenu() {
    List<DropdownMenuItem<String>> items = List();
    for (int i = 0; i < categoriesList.length; i++) {
      items.insert(
          0,
          DropdownMenuItem(
            child: Text(categoriesList[i].data['name']),
            value: categoriesList[i].data['name'],
          ));
    }
    return items;
  }

  List<DropdownMenuItem<String>> getBrandsMenu() {
    List<DropdownMenuItem<String>> items = List();
    for (int i = 0; i < brandsList.length; i++) {
      items.insert(
        0,
        DropdownMenuItem(
          child: Text(brandsList[i].data['name']),
          value: brandsList[i].data['name'],
        ),
      );
    }
    return items;
  }

  _getCategories() async {
    List<DocumentSnapshot> data = await _databaseService.getCategories();
    if (data.isNotEmpty) {
      setState(() {
        categoriesList = data;
        categoriesDropDown = getCategoriesMenu();
        _currentCategory = categoriesList[0].data['name'];
      });
    }
  }

  _getBrands() async {
    List<DocumentSnapshot> data = await _databaseService.getBrands();
    if (data.isNotEmpty) {
      setState(() {
        brandsList = data;
        brandsDropDown = getBrandsMenu();
        _currentBrand = brandsList[0].data['name'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Add Product",
          style: TextStyle(color: Colors.black),
        ),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.close,
            color: Colors.black,
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: isLoading
              ? Center(child: CircularProgressIndicator())
              : Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: OutlineButton(
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 1.0),
                                onPressed: () {
                                  _selectImage(
                                    ImagePicker.pickImage(
                                        source: ImageSource.gallery),
                                  );
                                },
                                child: _displayChild()),
                          ),
                        ),
                      ],
                    ),
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: productNameController,
                        decoration:
                            InputDecoration(hintText: 'Enter Product Name'),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'this field could not be empty';
                          } else if (value.length > 15) {
                            return 'product name must be less than 15 letters';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        leading: Text("Categories : "),
                        title: DropdownButton(
                          items: categoriesDropDown,
                          onChanged: (String newValue) {
                            setState(() {
                              _currentCategory = newValue;
                            });
                          },
                          value: _currentCategory,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        leading: Text("Brands : "),
                        title: DropdownButton(
                          items: brandsDropDown,
                          onChanged: (String newValue) {
                            setState(() {
                              _currentBrand = newValue;
                            });
                          },
                          value: _currentBrand,
                        ),
                      ),
                    ),
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: productPriceController,
                        decoration: InputDecoration(
                            hintText: 'Enter Product Price',
                            labelText: 'price'),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'this field could not be empty';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: productDescController,
                        decoration: InputDecoration(
                            hintText: 'Enter Product Description',
                            labelText: 'description'),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'this field could not be empty';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(32.0, 8.0, 32.0, 8.0),
                      child: FlatButton(
                        onPressed: () {
                          validateAndUpload();
                        },
                        child: Text("add Product"),
                        color: Colors.red,
                        textColor: Colors.white,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  changeSelectedCategory(String selectedCategory) {
    setState(() {
      _currentCategory = selectedCategory;
    });
  }

  changeSelectedBrand(String selectedBrand) {
    setState(() {
      _currentBrand = selectedBrand;
    });
  }

  void _selectImage(Future<File> pickImage) async {
    File temp = await pickImage;
    int max = 3 * 1024 * 1024;
    int fileSize = temp.lengthSync();
    if (fileSize > max) {
      temp = null;
      Fluttertoast.showToast(msg: "File size must be less than 3 mega bytes");
      temp = await pickImage;
    } else {
    setState(() => _fileImage1 = temp);
    }

  }

  _displayChild() {
    if (_fileImage1 == null) {
      return Padding(
        padding: EdgeInsets.fromLTRB(14, 70, 14, 70),
        child: Icon(Icons.add),
      );
    } else {
      return Image.file(
        _fileImage1,
        fit: BoxFit.fill,
        width: double.infinity,
      );
    }
  }

  void validateAndUpload() async {
    if (_formKey.currentState.validate()) {
      setState(() => isLoading = true);
      if (_fileImage1 != null) {
        String imageUrl1;

        final FirebaseStorage storage = FirebaseStorage.instance;

        final String picture1 =
            "${DateTime.now().millisecondsSinceEpoch.toString()}.jpg";
        StorageUploadTask task1 =
            storage.ref().child(picture1).putFile(_fileImage1);

        task1.onComplete.then((snapshot1) async {
          imageUrl1 = await snapshot1.ref.getDownloadURL();
          _databaseService.uploadProduct(
              name: productNameController.text,
              brand: _currentBrand,
              category: _currentCategory,
              price: double.parse(productPriceController.text),
              picture: imageUrl1,
              description: productDescController.text,
              featured: true);
          _formKey.currentState.reset();
          setState(() => isLoading = false);
          Fluttertoast.showToast(msg: "product uploaded");
          Navigator.pop(context);
        });
      } else {
        setState(() => isLoading = true);
        Fluttertoast.showToast(msg: "please select an image");
      }
    }
  }
}
