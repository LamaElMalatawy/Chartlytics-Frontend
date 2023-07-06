import 'dart:ui';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:pick_image/screens/information_page.dart';
import 'package:pick_image/screens/summary_generation_page.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:pick_image/screens/user_profile_page.dart';
import 'loading_page.dart';
import 'pick_image_page.dart';

class History extends StatefulWidget {
  const History({super.key});
  @override
  State<History> createState() => HistoryState();
}

class HistoryState extends State<History> {

  var url = '';
  List<String> imageIDs = [];
  List<String> imageURL = [];
  List<String> summaries = [];
  String imageID = '';
  Map<String, dynamic> map = {};
  static String historySummary = '';
  final FlutterTts flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();
    flutterTts.stop();

    retrieve();

  }

  void retrieve() async {

    Reference imageReference = FirebaseStorage.instance.ref();
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('userImages')
        .doc(PickImageState.email)
        .get();


    map = doc.data() as Map<String, dynamic>;

    int length = map.keys.toList().length;
    for (int i = 0; i < length; i++) {
      if (map.keys.toList()[i] == "last name" ||
          map.keys.toList()[i] == "first name") {
        continue;
      }

        imageID = map.keys.toList()[i];

        // to store ids & summaries associated to them
        imageIDs.add(imageID);
        summaries.add(map[imageID]);
        var imgRef = imageReference.child("images/$imageID");
        url = await imgRef.getDownloadURL();
        imageURL.add(url);


    }


    setState(() {});


  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child:Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 70,
          backgroundColor: Colors.deepPurple[100],
          title: const Center(
              child: Text('Chartlytics',
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Alata'))),
        ),
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(children: [
                const SizedBox(
                  height: 30,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Icon(
                    Icons.manage_history_outlined,
                    size: 30,
                    color: Colors.indigo[400],
                  ),
                  const Center(
                    child: Text(
                      "User Recent History",
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 25,
                          fontFamily: 'Alata',
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ]),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                    height: 500,
                    width: 320,
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Number of grid columns
                        mainAxisSpacing: 8.0, // Spacing between grid items
                        crossAxisSpacing: 8.0, // Spacing between grid items
                      ),
                      itemCount: imageURL.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: (){
                            Navigator.pop(context);
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => SummaryPage(summaries[index]),
                            ));
                          },
                            child: Image.network(imageURL[index])
                        );
                      },
                    ),

                ),
                const SizedBox(
                  height: 30,
                ),
              ]),
            ),
          ),
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
                  builder: (context) => const UserPage(),
                ));
              }
              if (value == 2) {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const AboutChartlytics(),
                ));
              }
            },
            backgroundColor: Colors.deepPurple[100],
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home, size: 40, color: Colors.black54),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person, size: 40, color: Colors.black54),
                label: "User",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.info, size: 40, color: Colors.black54),
                label: "About",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
