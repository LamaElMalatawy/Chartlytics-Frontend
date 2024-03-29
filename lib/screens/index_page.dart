import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pick_image/screens/login_page.dart';
import 'package:pick_image/screens/register_page.dart';
import 'package:pick_image/components/change_theme_button.dart';

class Index extends StatefulWidget {
  const Index({Key? key}) : super(key: key);

  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Index> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 70,
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: const [
            ChangeThemeButtonWidget(),
          ],
        ),
        body: Center(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                  width: 500,
                  height: 300,
                  child: Lottie.network(
                      'https://assets5.lottiefiles.com/packages/lf20_dews3j6m.json')),
              const Text(
                "Chartlytics",
                style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Alata'),
              ),
              const Text(
                "Charts Data Extraction and Analysis",
                style: TextStyle(
                    fontSize: 15, fontFamily: 'Alata', color: Colors.grey),
              ),
              const SizedBox(
                height: 40,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const LogIn(),
                  ));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple[200],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  fixedSize: Size.fromWidth(150),
                  // Background color
                ),
                child: const Text('Existing User',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Alata')),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const RegisterPage(),
                  ));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple[200],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  fixedSize: Size.fromWidth(150), // Background color
                ),
                child: const Text('New User',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Alata')),
              )
            ],
          ),
          //child: Text('Hello'),
        ),
      ),
    );
  }
}
