import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pick_image/screens/information_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pick_image/screens/classification_page.dart';
import 'user_profile_page.dart';
import 'package:flutter_tts/flutter_tts.dart';

class PickImage extends StatefulWidget {
  const PickImage({super.key});
  @override
  State<PickImage> createState() => PickImageState();
}

class PickImageState extends State<PickImage> {
  File? image;
  XFile? imageX;
  static String userName = "";
  static String lastName = "";
  static String? imageUrl;
  static String fileID = '';
  int value = -1;
  static String? email;
  Map<String, dynamic> map = {};

  final FlutterTts flutterTts = FlutterTts();
  final TextEditingController textControl = TextEditingController();

  speak(String text) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1.0);
    await flutterTts.setSpeechRate(0.4);
    await flutterTts.speak(text);
  }
  @override
  void initState() {
    email = FirebaseAuth.instance.currentUser?.email.toString();
    super.initState();
    retrieve();
    setState(() {

    });

    flutterTts.stop();
    String text = "Welcome to Chartlytics";
    speak(text);
  }

  Future getImage() async {
    imageX = await ImagePicker().pickImage(source: ImageSource.gallery);
    try {
      setState(() {
        // setting file instance to display the image chosen in the image widget
        image = File(imageX!.path);
      });
    } catch (e) {
      _showNoImgDialog(context);
    }
  }

  void retrieve() async {
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('userImages')
        .doc(PickImageState.email)
        .get();
    map = doc.data() as Map<String, dynamic>;
    userName = map["first name"].toString();
    lastName = map["last name"];
    setState(() {});

  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 70,
          backgroundColor: Colors.deepPurple[100],
          title:
              const Center(
                child: Text('Chartlytics',
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Alata'))
          ),
        ),
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
               Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Hello ",
                          style: TextStyle(
                            color: Colors.black54,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Alata',
                              fontSize: 35)),
                      Text( "$userName ",
                          style:  TextStyle(
                            color: Colors.deepPurple[300],
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Alata',
                              fontSize: 35)),
                      const Icon(Icons.waving_hand_rounded, color: Colors.black54),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  image != null
                      ? Container(
                      height: 200,
                      width: 250,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 2,
                          color: Colors.black12,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Image.file(
                        image!,
                        width: 200,
                        height: 200,
                      ))
                      : Image.asset('assets/images/unnamed.png',
                      width: 200, height: 200),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 50, //height of button
                    width: 250,
                    child: ElevatedButton.icon(
                      onPressed: () => {getImage()},
                      label: const Text('Upload Your Image Here',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Alata',
                              fontSize: 16)),
                      icon: const ImageIcon(
                        AssetImage('assets/images/upload.png'),
                        color: Colors.black,
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.indigo[50],
                        shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(10)), // Background color
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: 40, // height of button
                    width: 85,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (image == null) {
                          showErrorMessage(
                              "No Image Chosen", "Please Choose a Valid Image");
                        } else {
                          // Upload to firebase Storage
                          fileID =
                              DateTime.now().millisecondsSinceEpoch.toString();
                          Reference referenceRoot =
                          FirebaseStorage.instance.ref();
                          Reference referenceDirImages =
                          referenceRoot.child("images");
                          Reference referenceImageToUpload =
                          referenceDirImages.child(fileID);
                          try {
                            await referenceImageToUpload
                                .putFile(File(image!.path));
                            imageUrl =
                            await referenceImageToUpload.getDownloadURL();
                          } catch (error) {
                            showErrorMessage(
                                "Seems like there's no internet connection :( ",
                                "Check your connection and try again later.");
                          }
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const Classification(),
                          ));
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.yellowAccent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        // Background color
                      ),
                      child: const Text(
                        'Submit',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Alata',
                            fontSize: 16),
                      ),
                    ),
                  ),
                  //
                ],
              ),
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

  void showErrorMessage(String message, String details) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(message),
          content: Text(details),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context), child: const Text('OK'))
          ],
        ));
  }

  _showNoImgDialog(BuildContext context) {
    showDialog(
        context: context,
        barrierColor: Colors.white.withOpacity(0),
        builder: (context) {
          Future.delayed(const Duration(milliseconds: 1000), () {
            Navigator.of(context).pop(true);
          });
          return AlertDialog(
            backgroundColor: Colors.grey[100],
            elevation: 0,
            title: const Text('No Image Chosen',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black54, fontSize: 20, fontFamily: 'Alata')),
            alignment: Alignment.bottomCenter,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          );
        });
  }
}
