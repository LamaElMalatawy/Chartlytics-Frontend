import 'package:flutter/material.dart';
import 'package:pick_image/screens/pick_image_page.dart';
import 'package:pick_image/screens/user_profile_page.dart';
import 'package:flutter_tts/flutter_tts.dart';


class AboutChartlytics extends StatefulWidget {
  const AboutChartlytics({Key? key}) : super(key: key);

  @override
  _AboutChartlyticsState createState() => _AboutChartlyticsState();
}

class _AboutChartlyticsState extends State<AboutChartlytics> {

  final FlutterTts flutterTts = FlutterTts();
  final TextEditingController textControl = TextEditingController();

  speak(String text) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setVolume(1);
    await flutterTts.setPitch(1.1);
    await flutterTts.speak(text);
  }
    String aboutTheApp = "Chart images play a vital role in visualizing data,"
    " but automatically extracting the values from these charts poses a"
    " significant challenge. The diverse range of chart styles makes it"
    " difficult to employ pure rule-based data extraction methods effectively. "
    "Developing a system that generates textual descriptions of images would "
    "improve the accessibility of digital content for individuals with visual "
    "impairments. \n To address this issue, we developed Chartlytics,"
    " a user-friendly, accessible application that can create textual "
    "descriptions for given a chart image and display them for the user in"
    " the form of a plain understandable text or a sound that people with "
    "complete loss of vision can easily hear.";
  @override
  void initState() {
    super.initState();
    flutterTts.stop();

    String title = "About the app";

    speak("$title  \n$aboutTheApp");
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
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.deepPurple[50],
                        border: Border.all(color: Colors.black45, width: 3)
                        ,borderRadius: BorderRadius.circular(12)),
                    alignment: Alignment.center,
                    width: 250,
                    height: 55,
                    child: const Text("About The App", style: TextStyle(color: Colors.black, fontSize: 23, fontFamily: 'Alata',fontWeight: FontWeight.bold),),
                  ),
                  const SizedBox(height:13,),
                  Padding(
                      padding: EdgeInsets.all(5),
                      child: Text(
                        aboutTheApp,
                      textAlign: TextAlign.center, style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, fontFamily: 'Alata'))
                  ),
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
}
