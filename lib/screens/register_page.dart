import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pick_image/components/custom_textfield.dart';
import 'package:pick_image/components/custom_button.dart';
import 'package:pick_image/components/square_tile.dart';
import 'package:pick_image/helper/auth_service.dart';
import 'package:pick_image/screens/login_page.dart';
import 'package:email_validator/email_validator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterPage extends StatefulWidget {


  const RegisterPage({
    super.key,
    //required this.onTap,
  });
  @override
  _registerPageState createState() => _registerPageState();
}

class _registerPageState extends State<RegisterPage> {

  // text editing controllers
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  void save() async{
    // Name, email address, and profile photo URL
    final email = emailController.text;
    await FirebaseFirestore.instance.collection('userImages').doc(email).set(
        {
          'first name':firstNameController.text.trim(),
          'last name':lastNameController.text.trim(),
        }
    );
  }

  Future register() async {
    try{
      if (!EmailValidator.validate(emailController.text))
      {
        showErrorMessage("Invalid Email", "Please make sure you enter a valid email format.");
      }
      else if (passwordController.text == "" || firstNameController.text == "" || firstNameController.text == "")
      {
        showErrorMessage("Invalid Password", "Please enter a valid password.");
      }
      else if (passwordController.text.length < 6)
      {
        showErrorMessage("Weak Password", "Please make sure your password contains 6 or more characters.");

      }
      else
      {
        if(passwordController.text == confirmPasswordController.text)
        {
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: emailController.text.trim(),
              password: passwordController.text.trim()
          );
        }
        else {
          showErrorMessage("Passwords Don't Match", "Please make sure to confirm you password.");
        }
      }
    }
    on FirebaseAuthException catch(e)
    {
      if(e.code =="email-already-in-use")
      {
        showErrorMessage("Email address is already in use by another account", "Please enter another Email.");
      }
      else {
        showErrorMessage("Something is Wrong", e.code);
      }
    }
    save();

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
              children: [
                const SizedBox(height: 40,),
                //logo
                 Icon(
                  Icons.pie_chart_outline,
                  color: Colors.deepPurple[400],
                  size: 100,
                ),
                const SizedBox(
                  height: 25,
                ),

                // welcome back
                const Text('Let\'s create an account for you!',
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Alata',
                    fontWeight: FontWeight.bold
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),
                CustomTextFieldWidget(
                  controller: firstNameController,
                  hintText: 'First Name',
                  obscureText: false,
                ),
                const SizedBox(height: 10,),
                CustomTextFieldWidget(
                  controller: lastNameController,
                  hintText: 'Last Name',
                  obscureText: false,
                ),
                const SizedBox(height: 10,),
                // email
                CustomTextFieldWidget(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                ),
                const SizedBox(height: 10,),
                // password
                CustomTextFieldWidget(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),
                const SizedBox(height: 10,),
                // confirm password
                CustomTextFieldWidget(
                  controller: confirmPasswordController,
                  hintText: 'Confirm password',
                  obscureText: true,
                ),

                const SizedBox(height: 15,),
                // sign in button
                CustomButtonWidget(
                  onTap: register,
                  label: 'Sign Up',
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
                      Expanded(child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),),
                    ],
                  ),
                ),
                const SizedBox(height: 10,),

                // google & facebook sign up
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SquareTileWidget(
                        imgPath: 'assets/images/google.png',
                    onTap: ()=> AuthService().registerWithGoogle(),),
                    const SizedBox(width: 25,),
                    SquareTileWidget(
                        imgPath: 'assets/images/facebook.png',
                    onTap: ()=> AuthService().registerWithGoogle(),),
                  ],
                ),
                const SizedBox(height: 15,),

                // already have an account? login now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already have an account?',
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
                              builder: (context) => const LogIn(),
                            ));
                      }
                      ,
                      child: const Text(
                        'Login Now',
                        style: TextStyle(
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Alata'
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