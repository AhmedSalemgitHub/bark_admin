import 'package:bark_admin/Screens/dashboard.dart';
import 'package:flutter/material.dart';

class ValidationScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 100),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'please enter your password';
                        } else if (value.length < 6) {
                          return 'password must be more than 6 charcters';
                        } else if (value != 'bbbbbb') {
                          return 'password does not match the assign password';
                        } else {
                          return null;
                        }
                      },
                      controller: _passwordTextController,
                      decoration: InputDecoration(
                          hintText: "Password",
                          icon: Icon(Icons.lock),
                          border: OutlineInputBorder()),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Please Enter the Password Provided by the Applcation admin",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.fromLTRB(14, 8, 14, 8),
                    child: MaterialButton(
                      color: Colors.blueGrey,
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Dashboard()));
                          }
                        },
                        child: Text(
                          "Enter",
                          style: TextStyle(fontSize: 20,color: Colors.white),
                        )),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
