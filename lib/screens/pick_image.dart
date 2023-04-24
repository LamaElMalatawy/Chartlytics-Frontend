import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' ;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'classification.dart';

class PickImage extends StatefulWidget {
  const PickImage({super.key});
  @override
  State<PickImage> createState() => PickImageState();
}

class PickImageState extends State<PickImage> {

  File? image;
  XFile? imageX;
  static String? imageUrl;


  Future getImage() async {
    imageX = await ImagePicker().pickImage(source: ImageSource.gallery);
    try {
      setState(() {
        // setting file instance to display the image chosen in the image widget
        image = File(imageX!.path);
      });
    }
    catch(e)
    {
      _showNoImgDialog(context);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.indigo[200],
        title: const Center(
            child: Text('Chartlytics', style: TextStyle(color: Colors.black54,fontSize: 50,fontWeight: FontWeight.bold,fontFamily: 'Alata'))
        ),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height:40,),
            image!= null ? Image.file(image!,width: 200,height:200,):Image.asset('assets/images/unnamed.png',width: 200,height:200),
            const SizedBox(height:20,),
            ElevatedButton.icon(
              onPressed: () => {
                getImage()
              },
              label: const Text('Upload Your Image Here', style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontFamily: 'Alata') ),
              icon: const ImageIcon(
                AssetImage('assets/images/upload.png'),
                color: Colors.black,
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.indigo[50], shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),// Background color
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                if(image == null)
                {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('No Image Chosen'),
                        content: Text("Please Choose a Valid Image"),
                        actions: [
                          TextButton(onPressed: () => Navigator.pop(context), child: Text('OK'))
                        ],
                      )
                  );
                }
                else {
                  // Upload to firebase Storage
                  Reference referenceRoot = FirebaseStorage.instance.ref();
                  Reference referenceDirImages = referenceRoot.child("images");
                  Reference referenceImageToUpload = referenceDirImages.child("Input Image");
                  try {
                    await referenceImageToUpload.putFile(File(image!.path));
                    imageUrl = await referenceImageToUpload.getDownloadURL();
                  }
                  catch (error) {}

                  Navigator.of(context).push(
                      MaterialPageRoute(
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
              child: const Text('Submit',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold, fontFamily: 'Alata'),),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items:  <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.home,size: 60),
            label: "",
            backgroundColor: Colors.indigo[200],
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person,size: 60),
            label: "",
            backgroundColor: Colors.indigo[200],
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.settings,size: 60,),
            label: "",
            backgroundColor: Colors.indigo[200],
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.menu,size: 60),
            label: "",
            backgroundColor: Colors.indigo[200],
          ),
        ],
      ),
    );


  }
  _showNoImgDialog(BuildContext context){
    showDialog(
        context: context,
        barrierColor: Colors.white.withOpacity(0),
        builder: (context){
          Future.delayed(Duration(milliseconds: 1000), ()
          {
            Navigator.of(context).pop(true);
          });
          return AlertDialog(
            backgroundColor: Colors.grey[100],
            elevation: 0,
            title: Text('No Image Chosen', textAlign: TextAlign.center, style: TextStyle(color: Colors.black54,fontSize: 20, fontFamily: 'Alata')),
            alignment: Alignment.bottomCenter,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),);
        });
  }
}
