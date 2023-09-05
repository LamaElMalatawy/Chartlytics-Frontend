import 'dart:convert';
import 'pick_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'summary_generation.dart';
import 'package:lottie/lottie.dart';
import 'classification.dart';
import 'package:flutter_tts/flutter_tts.dart';

class loadingPage extends StatefulWidget {
  const loadingPage({super.key});
  @override
  State<loadingPage> createState() => loadingState();
}

class loadingState  extends State<loadingPage>
{
  final FlutterTts flutterTts = FlutterTts();
  final TextEditingController textControl = TextEditingController();

  Speak(String text) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setVolume(1);
    await flutterTts.setPitch(1.2);
    await flutterTts.setSpeechRate(0.4);
    await flutterTts.speak(text);

  }
  static String summary= "";
  var response;
  @override
  void initState() {
    super.initState();
    extractData();
    // Speak("Generating your Chart Summary.");
  }

  extractData() async {
    try
    {
      response = await http.post(
          Uri.parse("http://10.0.2.2:5000/ExtractData"),
          body: jsonEncode({
            'URL': PickImageState.imageUrl,
            'type': ClassificationState.chartIdx,
          }));
      print(response.body);
    }
    catch(e){
      print(e);
    }

    summary = await response.body as String;

    while (summary == "") {}
    setState(() {});
    if (summary == "Sorry :(  Could not Summarise your Chart Image")
    {
      show_noSummary_Dialog(context);
      setState(() {});
    }
    else
    {
      Navigator.pop(context);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const summaryPage()),);        // Navigator.pop(context);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body:
        Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      width: 500,
                      height: 450,
                      child: Lottie.network('https://assets3.lottiefiles.com/packages/lf20_n2cwrc3i.json')),
                  const Text("Generating your Chart Summary", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 23, fontFamily: 'Alata'),),
                ]
            ))

      // make the couldnt summarize message in a pop up dialog
    );
  }
  show_noSummary_Dialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(
              title: const Text('Sorry :('),
              content: const Text("Could not Summarise your Chart Image"),
              actions: [
                TextButton(onPressed: () {
                  Navigator.pop(context); //poping the message
                  Navigator.pop(context); //poping the loading page
                  Navigator.pop(context); // poping the previous main page where there's a chosen image
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const PickImage()),);        // Navigator.pop(context);
                },
                    child: Text('Back'))
              ],
            )
    );
  }

}