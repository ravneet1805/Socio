import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socio/auth/auth_service.dart';
import 'package:socio/pages/signupPage.dart';
import 'package:socio/utils/constants.dart';
import 'package:socio/utils/inputField.dart';


class LoginPage extends StatefulWidget {
  final void Function()? onTap;

  LoginPage({Key? key, required this.onTap}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> signIn() async {
    final authService = Provider.of<AuthService>(context, listen: false);

    try{
      await authService.signInWithEmailandPassword(
          emailController.text,
          passwordController.text);
    } catch (e){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString()))
      );
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBgcolor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(50.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Image(
                      height: 80,
                      width: 80,
                      image: AssetImage('assets/images/socio logo.png'),
                    ),
                    // const SizedBox(
                    //   width: 10,
                    // ),
                    Text(
                      'Socio',
                      style: klogoStyle,
                    )
                  ],
                ),
              ),
              SizedBox(height: 50,),
              const Center(
                  child: Text(
                    'Login',
                    style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'Rubik Medium',
                        color: Color(0xff2D3142)),
                  )),
              const Center(
                  child: Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Text(
                      'Enter Your Email and Password',
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Rubik Regular',
                          color: Color(0xff4C5980)),
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: InputField(
                  passwordcontroller: passwordController,
                  emailcontroller: emailController,),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 30.0),
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Rubik Regular',
                        color: kPrimarycolor,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 130,
              ),
              GestureDetector(
                onTap: (){
                  signIn();
                },
                child: Container(
                  width: 300,
                  height: 50,
                  decoration: BoxDecoration(
                    color: kPrimarycolor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Text(
                      'login',
                      style: TextStyle(
                        fontFamily: 'Rubik Regular',
                        fontSize: 20,
                        color: kBgcolor,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:  [
                    Text(
                      'Dont have an account?',
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Rubik Regular',
                          color: Color(0xff4C5980)),
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        ' Signup',
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Rubik Medium',
                            color: kPrimarycolor),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
