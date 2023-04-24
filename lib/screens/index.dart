import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pick_image/components/change_theme_button.dart';
import 'package:pick_image/screens/login.dart';
import 'package:pick_image/screens/sign_up.dart';



class Index extends StatefulWidget {
  const Index({Key? key}) : super(key: key);

  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Index> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
        ChangeThemeButtonWidget(),
        ],
      ),
      body: Center(
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 100,
          ),
          SizedBox(
              width: 500,
              height: 400,
              child: Lottie.network(
              'https://assets5.lottiefiles.com/packages/lf20_dews3j6m.json')),
          const Text(
            "Chartlytics",
            style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const LogIn(),
                  ));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.indigo[200],
                fixedSize: const Size.fromWidth(120)// Background color
            ),
            child: const Text('Existing User'),
          ),
          ElevatedButton(
            onPressed: () {
              // Navigator.pop(context);
              // Navigator.of(context).push(
              //     MaterialPageRoute(
              //       builder: (context) => const SignUp(),
              //     ));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.indigo[200],
              fixedSize: const Size.fromWidth(120)// Background color
            ),
            child: const Text('New User'),
          )
        ],
      ),
      //child: Text('Hello'),
    ),
    );
  }
}

