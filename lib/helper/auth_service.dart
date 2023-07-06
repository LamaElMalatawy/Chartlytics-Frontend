
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class AuthService{

  // Google Sign In
  signInWithGoogle()async{

    String email;
    String displayName;
    String firstName;
    String lastName;

    // begin interactive sign in process
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
    //obtain auth details from request
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;
    // create a new credential for user
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    // finally, let's sign in
    UserCredential userCred = await FirebaseAuth.instance.signInWithCredential(credential);

    return userCred;
  }

  // Google Sign In
  registerWithGoogle()async{

    String email;
    String displayName;
    String firstName;
    String lastName;

    // begin interactive sign in process
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
    //obtain auth details from request
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;
    // create a new credential for user
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    // finally, let's sign in
    UserCredential userCred = await FirebaseAuth.instance.signInWithCredential(credential);

    // await FirebaseAuth.instance.createUserWithEmailAndPassword(
    //     email: (userCred.user?.email).toString(),
    //     password: "123456",
    // );
    email = (userCred.user?.email).toString();
    displayName = (userCred.user?.displayName).toString();

    firstName = displayName.split(' ')[0];
    lastName = displayName.split(' ')[1];
    await FirebaseFirestore.instance.collection('userImages').doc((userCred.user?.email).toString()).set(
        {
          'first name':firstName,
          'last name':lastName,
        }
    );

    return userCred;
  }
}