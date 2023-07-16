import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../auth/auth_service.dart';
import '../utils/constants.dart';
import '../utils/inputField.dart';
import 'loginPage.dart';


class SignupPage extends StatefulWidget {
  final void Function()? onTap;

  const SignupPage({Key? key, required this.onTap}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();
  final usernameController = TextEditingController();

  void signUp() async{
    if(passwordController.text != confirmController.text){
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Passwords donot match!")
          )
      );
      return;
    }

    //get auth service
    final authService = Provider.of<AuthService>(context, listen: false);

    try{
      await authService.signUpWithEmailandPassword(emailController.text, passwordController.text, usernameController.text);
    }catch (e){
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString()))
      );
    }


  }

  bool passwordVisible=false;

  @override
  void initState(){
    super.initState();
    passwordVisible=true;
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
                    'Signup',
                    style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'Rubik Medium',
                        color: Color(0xff2D3142)),
                  )),
              const Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 20.0),
                    child: Text(
                      'Create your Account',
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Rubik Regular',
                          color: Color(0xff4C5980)),
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0,vertical: 20),
                child: TextFormField(
                  controller: usernameController ,
                  decoration: InputDecoration(
                    hintText: 'Username',
                    fillColor: kSecondaryColor,
                    filled: true,
                    prefixIcon: const Icon(
                      Icons.person,
                      color: kPrimarycolor,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0xffE4E7EB),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0xffE4E7EB),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              InputField(
                passwordcontroller: passwordController,
                emailcontroller: emailController),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: TextFormField(
                  obscureText: passwordVisible,
                  controller: confirmController ,
                  decoration: InputDecoration(
                    hintText: 'Confirm Password',
                    fillColor: kSecondaryColor,

                    filled: true,
                    prefixIcon: const Icon(
                      Icons.lock,
                      color: kPrimarycolor,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(passwordVisible
                          ? Icons.visibility_off
                          : Icons.visibility),color: kPrimarycolor,
                      onPressed: () {
                        setState(
                              () {
                            passwordVisible = !passwordVisible;
                          },
                        );
                      },
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0xffE4E7EB),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0xffE4E7EB),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: [
              //     Padding(
              //       padding: const EdgeInsets.only(right: 30.0),
              //       child: Text(
              //         'Forgot Password?',
              //         style: TextStyle(
              //           fontSize: 16,
              //           fontFamily: 'Rubik Regular',
              //           color: kPrimarycolor,
              //           decoration: TextDecoration.underline,
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              const SizedBox(
                height: 100,
              ),
              GestureDetector(
                onTap: (){
                  signUp();

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
                      'Signup',
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
                      'Already a member?',
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Rubik Regular',
                          color: Color(0xff4C5980)),
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        ' Login',
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
    );;
  }
}
