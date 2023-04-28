import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;
import 'package:pick_image/screens/user_profile.dart';
import 'pick_image.dart';
import 'loading.dart';

class Classification extends StatefulWidget {
  const Classification({super.key});
  @override
  ClassificationState createState() => ClassificationState();
}

class ClassificationState extends State<Classification> {
  @override
  void initState() {
    super.initState();
    uploadImage();
  }

  static int chartIdx = -1;
  final loadingPage load = new loadingPage();
  String chartType = "";
  //String url = r"http://10.0.2.2:4000/?img=";
  var response;
  Future uploadImage() async {
    try {
      print(PickImageState.imageUrl);
      response = await http.post(Uri.parse("http://10.0.2.2:5000/Classify"),
          body: jsonEncode({
            'URL': PickImageState.imageUrl,
          }));

      chartType = response.body;

      if (chartType == 'Pie') {
        chartIdx = 0;
      } else if (chartType == 'Vertical Bar Chart') {
        chartIdx = 1;
      } else if (chartType == 'Horizontal Bar Chart') {
        chartIdx = 2;
      }
    } catch (e) {
      print(e);
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
    child: Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Colors.deepPurple[100],
        title: const Center(
          child: Text(
            'Chartlytics',
            style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
        child: SingleChildScrollView(
        child: Center(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 25,
            ),
            const Text(
              "Classifying your Chart Image",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  fontFamily: 'Alata'),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
                width: 500,
                height: 250,
                child: Lottie.network(
                    'https://assets5.lottiefiles.com/packages/lf20_yMpiqXia1k.json')),
            const SizedBox(
              height: 20,
            ),
            Text(
              chartType,
              style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Alata'),
            ),
            const SizedBox(
              height: 25,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const loadingPage(),
                ));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple[100], // Background color
              ),
              child: const Text('Proceed to Summary',
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Alata',
                      fontWeight: FontWeight.bold,
                      color: Colors.black54)),
            )
          ],
        ),
    ),
    ),
        ),
        //child: Text('Hello'),
      ),
      ///////////////******** Navigation Bar *********////////////////
      bottomNavigationBar: SizedBox(
        height: 70,
        child: BottomNavigationBar(
          onTap: (value) {
            if (value == 0) {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const PickImage(),
              ));
            }
            if (value == 1) {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const userPage(),
              ));
            }
            if (value == 2) {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const loadingPage(),
              ));
            }
          },
          backgroundColor: Colors.deepPurple[100],
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home, size: 40, color: Colors.black54),
              label: "home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person, size: 40, color: Colors.black54),
              label: "user",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.info, size: 40, color: Colors.black54),
              label: "settings",
            ),
          ],
        ),
      ),
            ),
    );
  }
}
