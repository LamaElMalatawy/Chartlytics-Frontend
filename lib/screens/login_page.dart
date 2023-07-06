import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pick_image/components/custom_textfield.dart';
import 'package:pick_image/components/custom_button.dart';
import 'package:pick_image/components/square_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pick_image/helper/auth_service.dart';
import 'package:pick_image/screens/register_page.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'pick_image_page.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);
  @override
  _LogInState createState() => _LogInState();
}
class _LogInState extends State<LogIn> {
  Map<String, dynamic> map = {};
  String userName = "";
  final FlutterTts flutterTts = FlutterTts();

  // text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  void retrieve() async
  {
    DocumentSnapshot doc = await FirebaseFirestore.instance.collection('userImages').doc(PickImageState.email).get();
    map = doc.data() as Map<String, dynamic>;

    userName = map["first name"];
    setState(() {});

  }

  Future userLogin() async{
    try{
      if (!EmailValidator.validate(emailController.text))
      {
        showErrorMessage("Invalid Email", "Please make sure you enter a valid email format.");
      }
      else if ( passwordController.text == "")
      {
        showErrorMessage("Invalid Password", "Please enter a valid password.");
      }
      else
      {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim()
        );
      }
    }
    on FirebaseAuthException catch(e)
    {
      if (e.code == "user-not-found")
      {
        showErrorMessage("User Doesn't Exist",
            "There is no user record corresponding to this identifier. "
                "The user may have been deleted.");
      }
      else {
        showErrorMessage("Something is Wrong", e.code);
      }
    }
  }

  void showErrorMessage(String message,String details){
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(message),
          content: Text(details),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK'))
          ],
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children:  [
                const SizedBox(height: 40,),
                //logo
                 Icon(
                  Icons.bar_chart_outlined,
                  color: Colors.deepPurple[400],
                  size: 100,
                ),
                const SizedBox(
                  height: 40,
                ),

                // welcome back
                const Text('Welcome back, you\'ve been missed!',
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Alata'
                  ),
                ),

                const SizedBox(
                  height: 25,
                ),

                // username
                CustomTextFieldWidget(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                ),
                const SizedBox(height: 15,),
                // password
                CustomTextFieldWidget(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),
                const SizedBox(height: 10,),
                // forgot password?
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children:const [
                      Text('Forgot Password?',
                          style: TextStyle(color: Colors.deepPurple,fontFamily: 'Alata'))
                    ],
                  ),
                ),
                const SizedBox(height: 15,),
                // sign in button
                CustomButtonWidget(
                  onTap: userLogin,
                  label: 'Sign In',
                ),
                const SizedBox(height: 20,),
                // or continue with
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Or continue with',
                          style: TextStyle(
                              color: Colors.grey[700],
                              fontFamily: 'Alata'
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                      ),),
                    ],
                  ),
                ),
                const SizedBox(height: 20,),

                // google & facebook sign in
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SquareTileWidget(
                        imgPath: 'assets/images/google.png',
                    onTap: ()=> AuthService().signInWithGoogle()
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    SquareTileWidget(
                        imgPath: 'assets/images/facebook.png',
                    onTap: ()=> AuthService().signInWithGoogle(),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),

                // not a member? register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Not a member?',
                      style: TextStyle(
                          color: Colors.grey[700],
                          fontFamily: 'Alata'
                      ),),
                    const SizedBox(width: 4,),
                    GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                        Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const RegisterPage(),
                            ));
                      },
                      child:
                      const Text(
                        'Register Now',
                        style: TextStyle(
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
