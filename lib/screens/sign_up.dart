import 'package:flutter/material.dart';
import 'package:pick_image/components/custom_textfield.dart';
import 'package:pick_image/components/custom_button.dart';
import 'package:pick_image/components/square_tile.dart';
import 'package:pick_image/screens/login.dart';

class SignUp extends StatefulWidget {

  //final Function()? onTap;

  const SignUp({
    super.key,
    //required this.onTap,
});

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  // text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // TODO: Sign Up Method
  bool SignUserUp(){
    throw UnimplementedError('Sign Up Method is not implemented yet');
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
                const Icon(
                  Icons.pie_chart_outline,
                  size: 50,
                ),
                const SizedBox(
                  height: 40,
                ),

                // welcome back
                const Text('Let\'s create an account for you!',
                  style: TextStyle(
                      fontSize: 16
                  ),
                ),

                const SizedBox(
                  height: 25,
                ),

                // email
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
                const SizedBox(height: 15,),
                // confirm password
                CustomTextFieldWidget(
                  controller: confirmPasswordController,
                  hintText: 'Confirm password',
                  obscureText: true,
                ),

                const SizedBox(height: 15,),
                // sign in button
                CustomButtonWidget(
                  onTap: SignUserUp,
                  label: 'Sign Up',
                ),
                const SizedBox(height: 50,),
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
                const SizedBox(height: 40,),

                // google & facebook sign up
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    SquareTileWidget(imgPath: 'assets/images/google.png'),
                    SizedBox(width: 25,),
                    SquareTileWidget(imgPath: 'assets/images/facebook.png'),
                  ],
                ),
                const SizedBox(height: 20,),

                // already have an account? login now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already have an account?',
                      style: TextStyle(
                        color: Colors.grey[700],
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
                          color: Colors.blue,
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