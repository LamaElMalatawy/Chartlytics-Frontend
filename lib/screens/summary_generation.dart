import 'package:flutter/material.dart';
import 'loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'pick_image.dart';

class summaryPage extends StatefulWidget{
  const summaryPage({super.key});
  @override
  State<summaryPage> createState() => summarystate();
}
class summarystate extends State<summaryPage> {

  @override
  void initState() {
    save();
  }
  void save() async
  {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // Name, email address, and profile photo URL
      final email = user.email;
      await FirebaseFirestore.instance.collection('userImages').doc(email).update(
          {
            PickImageState.fileID.toString(): loadingState.summary.toString(),
          }
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.indigo[200],
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
                  const SizedBox(height:10,),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.indigo[50],
                        border: Border.all(color: Colors.black26, width: 3)
                        ,borderRadius: BorderRadius.circular(12)),
                    alignment: Alignment.center,
                    width: 250,
                    height: 55,
                    child: const Text("Generated Summary", style: TextStyle(color: Colors.black, fontSize: 23, fontFamily: 'Alata'),),
                  ),
                  const SizedBox(height:15,),
                  Padding(
                      padding: EdgeInsets.all(13),
                      child: Text(loadingState.summary ,textAlign: TextAlign.center, style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, fontFamily: 'Alata'))
                  )
                ]),
          ),
        ),
      ),
    );
  }
}