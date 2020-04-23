import 'package:bark_admin/Screens/validation_screen.dart';
import 'package:bark_admin/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LogIn extends StatelessWidget {
  const LogIn({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Welcome to Bark Park Admin Application",style: TextStyle(fontSize: 30),textAlign: TextAlign.center,),
            SizedBox(height: 50,),
            Padding(
              padding: const EdgeInsets.fromLTRB(32.0,8.0,32.0,8.0),
              child: MaterialButton(
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Image.asset(
                        "images/google.png",
                        width: 50,
                      ),
                    ),
                    SizedBox(width: 20),
                    Text("Google sign in ...",style: TextStyle(color: Colors.white,fontSize: 20),)
                  ],
                ),
                color: Colors.grey,
                onPressed: () async {
                  user.signInGoogle().whenComplete(() {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> ValidationScreen()));
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
