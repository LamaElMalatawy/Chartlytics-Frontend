import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
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
    };
    summary = map[imageID];
    final spaceRef = imagereference.child("images/" + imageID);
    url = await spaceRef.getDownloadURL();
    setState(() {});

    print('retrieval done.');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.indigo[200],
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
              Image.network(url,
                  height: 250,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              SizedBox(
                                width: 500,
                                height: 450,
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
                          children: const [
                            SizedBox(
                              width: 500,
                              height: 450,
                              child: SpinKitRing(
                                color: Colors.indigo,
                                size: 50.0,
                              ),
                            ),
                          ]))),
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
    );
  }
}
