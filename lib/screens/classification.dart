import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;
import 'pick_image.dart';
import 'loading.dart';

class Classification extends StatefulWidget {
  const Classification({super.key});



  @override
  ClassificationState createState() => ClassificationState();
}

class ClassificationState extends State<Classification> {

  @override
  void initState(){
    super.initState();

    uploadImage();

  }

  static int chartIdx=-1;

  final loadingPage load = const loadingPage();
  String chartType = "";
  var response;
  Future uploadImage() async {

    try
    {
      response = await http.post(
          Uri.parse("http://10.0.2.2:5000/upload"),
          body: jsonEncode({
            'URL': PickImageState.imageUrl,
          }));

      chartType = response.body;

      if(chartType=='Pie') {
        chartIdx=0;
      } else if(chartType=='Vertical Bar Chart') {
        chartIdx=1;
      } else if(chartType=='Horizontal Bar Chart') {
        chartIdx=2;
      }


    }
    catch(e){ print(e);}

    setState(() {

    });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.indigo[200],
        title: const Center(
          child: Text(
            'Chartlytics',
            style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Center(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 100,
            ),
            SizedBox(
                width: 500,
                height: 250,
                child: Lottie.network(
                    'https://assets5.lottiefiles.com/packages/lf20_yMpiqXia1k.json')),
            const SizedBox(
              height: 10.0,
            ),
            Text(
              chartType,
              style: const TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const loadingPage(),
                    ));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo[200], // Background color
              ),
              child: const Text('Proceed to Summary'),
            )
          ],
        ),
        //child: Text('Hello'),
      ),
    );
  }
}
