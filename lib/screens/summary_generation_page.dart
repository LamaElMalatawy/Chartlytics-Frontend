import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pick_image/screens/information_page.dart';
import 'package:pick_image/screens/user_profile_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'pick_image_page.dart';
import 'package:flutter_tts/flutter_tts.dart';

class SummaryPage extends StatefulWidget{

  String summary = "";

  SummaryPage(this.summary, {super.key});
  @override
  State<SummaryPage> createState() => SummaryPageState();
}
class SummaryPageState extends State<SummaryPage> {
  final FlutterTts flutterTts = FlutterTts();
  final TextEditingController textControl = TextEditingController();

  speak(String text) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setVolume(1);
    await flutterTts.setPitch(1.1);
    await flutterTts.speak(text);
  }
  @override
  void initState() {
    super.initState();
    save();
    flutterTts.stop();
    speak(widget.summary);
  }
  void save() async
  {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // Name, email address, and profile photo URL
      final email = user.email;
      await FirebaseFirestore.instance.collection('userImages').doc(email).update(
          {
            PickImageState.fileID.toString(): widget.summary.toString(),
          }
      );
    }
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
        title: const
        Center(
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
            child: Column(
                children: [
                  // const SizedBox(height:10,),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.deepPurple[50],
                        border: Border.all(color: Colors.black45, width: 3)
                        ,borderRadius: BorderRadius.circular(12)),
                    alignment: Alignment.center,
                    width: 250,
                    height: 55,
                    child: const Text("Generated Summary", style: TextStyle(color: Colors.black, fontSize: 23, fontFamily: 'Alata',fontWeight: FontWeight.bold),),
                  ),
                  const SizedBox(height:13,),
                  Padding(
                      padding: const EdgeInsets.all(5),
                      child: Text(widget.summary ,textAlign: TextAlign.center, style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, fontFamily: 'Alata'))
                  ),
                  SizedBox(
                      height: 45, //height of button
                      width: 190,
                      child:ElevatedButton(
                              onPressed: () {
                                speak(widget.summary);
                                Clipboard.setData(ClipboardData(text:widget.summary));
                                },
                        style: ElevatedButton.styleFrom(
                            side: const BorderSide(
                              width: 1.0,
                              color: Colors.black12,
                            ),
                            backgroundColor: Colors.deepPurple[100],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),),),
                              child: const Text("Let Me Hear it Again",
                        style: TextStyle(
                                  fontSize: 17,
                                  fontFamily: 'Alata',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                      ),
                  ),
                  ),
                  const SizedBox(height:13,),
                  SizedBox(
                    height: 45, //height of button
                    width: 150,
                    child:ElevatedButton(
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: widget.summary));
                        _showNoImgDialog(context);
                      },
                      style: ElevatedButton.styleFrom(
                        side: const BorderSide(
                          width: 1.0,
                          color: Colors.black12,
                        ),
                        backgroundColor: Colors.yellowAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),),),
                      child: const Text("Copy Summary",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Alata',
                            fontSize: 17),
                      ),
                    ),
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
            title: const Text('Summary Copied to Clipboard',
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