import 'package:flutter/material.dart';
import 'loading.dart';

class summaryPage extends StatelessWidget {
  const summaryPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 100,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.indigo[200],
          title: const Center(
              child: Text('Chartlytics', style: TextStyle(color: Colors.black54,fontSize: 50,fontWeight: FontWeight.bold,fontFamily: 'Alata'))
          ),
        ),
        body:
        Column(
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
            ])
    );
  }
}