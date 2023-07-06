import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../screens/pick_image_page.dart';
import '../screens/index_page.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({super.key});

  @override
  State<AuthenticationPage> createState() => AuthenticationPageState();
}
class AuthenticationPageState extends State<AuthenticationPage> {
  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if(user == null)
      {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Index(),));

      }
      else
      {
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
