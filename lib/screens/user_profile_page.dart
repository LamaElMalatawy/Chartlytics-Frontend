import 'package:flutter/material.dart';
import 'package:pick_image/screens/information_page.dart';
import 'loading_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'pick_image_page.dart';
import 'history_page.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});
  @override
  State<UserPage> createState() => UserPageState();
}

class UserPageState extends State<UserPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  WillPopScope(
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
              child: Column(children: [
                Icon(
                  Icons.person_2,
                  size: 70,
                  color: Colors.deepPurple[300],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Center(
                  child: Text(
                    "User Info",
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 40,
                        fontFamily: 'Alata',
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text("First Name:  ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Alata')),
                    Text(PickImageState.userName,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Alata')),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text("Last Name:  ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Alata')),
                    Text(PickImageState.lastName,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Alata')),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                    height: 50, //height of button
                    width: 150,
                    child: ElevatedButton(
                        onPressed: () => {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const History(),
                          ))
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black54,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        child: const Text('History',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Alata')))),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 50, //height of button
                  width: 150,
                  child: ElevatedButton(
                    onPressed: () => {
                      FirebaseAuth.instance.signOut(),
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red[300],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    // Background color
                    child: const Text('Sign Out',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Alata')),
                  ),
                ),


              ]),
            ),
          ),
        ),
        bottomNavigationBar:SizedBox(height: 70, child:  BottomNavigationBar(
          onTap: (value) {
            if (value == 0) {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const PickImage(),));

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
