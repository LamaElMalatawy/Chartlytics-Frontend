import 'package:flutter/material.dart';
import 'package:pick_image/components/custom_textfield.dart';
import 'package:pick_image/components/custom_button.dart';
import 'package:pick_image/components/square_tile.dart';
import 'package:pick_image/screens/sign_up.dart';



class LogIn extends StatefulWidget {

  //final Function()? onTap;

  const LogIn({
    super.key,
    //required this.onTap,

});
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {

  // text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();



  // TODO: Sign In Method
  bool SignUserIn(){
    throw UnimplementedError('Sign In Method is not implemented yet');
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
                const Icon(
                  Icons.bar_chart_outlined,
                  size: 100,
                ),
                const SizedBox(
                  height: 40,
                ),

              // welcome back
              const Text('Welcome back, you\'ve been missed!',
                style: TextStyle(
                  fontSize: 16
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
                  children:[
                    Text('Forgot Password?',
                    style: TextStyle(color: Colors.grey[600]))
                  ],
                ),
              ),
                const SizedBox(height: 15,),
              // sign in button
              CustomButtonWidget(
                onTap: SignUserIn,
                label: 'Sign In',
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

              // google & facebook sign in
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  SquareTileWidget(imgPath: 'assets/images/google.png'),
                  SizedBox(width: 25,),
                  SquareTileWidget(imgPath: 'assets/images/facebook.png'),
                ],
              ),
                const SizedBox(height: 20,),

                // not a member? register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Not a member?',
                    style: TextStyle(
                      color: Colors.grey[700],
                    ),),
                    const SizedBox(width: 4,),
                    GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                        Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const SignUp(),
                            ));
                      },
                      child:
                      const Text(
                        'Register Now',
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
