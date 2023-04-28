import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:pick_image/screens/user_profile.dart';
import 'loading.dart';
import 'pick_image.dart';

class history extends StatefulWidget {
  const history({super.key});
  @override
  State<history> createState() => HistoryState();
}

class HistoryState extends State<history> {
  var url = '';
  String imageID = '';
  Map<String, dynamic> map = {};
  String summary = '';
  @override
  void initState() {
    super.initState();
    retrieve();
    // print(map.keys);
  }

  void retrieve() async {
    print(PickImageState.email);
    Reference imagereference = FirebaseStorage.instance.ref();
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('userImages')
        .doc(PickImageState.email)
        .get();
    map = await doc.data() as Map<String, dynamic>;
    print(map.keys);
    for (int i = 0; i < map.keys.toList().length; i++) {
      if (map.keys.toList()[i] != "last name" ||
          map.keys.toList()[i] != "first name") {
        imageID = map.keys.toList()[i];
        // break;
      }
    }
    ;
    summary = map[imageID];
    final spaceRef = imagereference.child("images/" + imageID);
    url = await spaceRef.getDownloadURL();
    setState(() {});

    print('retrieval done.');
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child:Scaffold(
        appBar: AppBar(
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
                    size: 50,
                    color: Colors.indigo[400],
                  ),
                  const Center(
                    child: Text(
                      " User Recent History",
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 30,
                          fontFamily: 'Alata',
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ]),
                const SizedBox(
                  height: 30,
                ),
                Container(
                    height: 210,
                    width: 320,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 5,
                        color: Colors.black38,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Image.network(
                      url,
                      height: 210,
                      width: 320,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  SizedBox(
                                    width: 200,
                                    height: 200,
                                    child: SpinKitRing(
                                      color: Colors.indigo,
                                      size: 50.0,
                                    ),
                                  ),
                                ]));
                      },
                      errorBuilder: (context, error, stackTrace) => Center(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 200,
                                  height: 200,
                                  child: SpinKitRing(
                                    color: Colors.purple.shade100,
                                    size: 50.0,
                                  ),
                                ),
                              ])),
                    )),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                    padding: EdgeInsets.all(13),
                    child: Text(summary,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Alata')))
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
