import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'pick_image.dart';
import 'index.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => authState();
}
class authState extends State<AuthPage> {
  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if(user == null)
      {
        print("User is signed Out");
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Index(),));
        // Navigator.pop(context);

      }
      else
      {
        print("User is signed In");
        // Navigator.of(context).push(MaterialPageRoute(builder: (context) => const PickImage(),));
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const PickImage(),));


      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:
        Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  SizedBox(
                    width: 500,
                    height: 450,
                    child: SpinKitRotatingCircle(
                      color: Colors.white,
                      size: 50.0,
                    ),
                  ),
                ]
            ))

    );
  }

}
