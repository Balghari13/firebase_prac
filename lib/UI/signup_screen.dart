import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_pract/UI/Widget/rounded_btn.dart';
import 'package:firebase_pract/UI/home_page.dart';
import 'package:firebase_pract/UI/login_screen.dart';
import 'package:firebase_pract/UI/utilis/toast_msg.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool loading = false;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: Form(
        key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
        children: [
            TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: 'Enter Email',
                helperText: 'qw@gm.com',
                prefixIcon: Icon(Icons.email),

              ),
              validator: (value){
                if(value!.isEmpty){
                  return "Enter Email";
                }else{
                  return null;
                }
              },
            ),
            const SizedBox(height: 15,),
            TextFormField(
              controller: passwordController,
              obscureText: true,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: 'Enter Password',
                prefixIcon: Icon(Icons.lock),
              ),
              validator: (value){
                if(value!.isEmpty){
                  return 'Enter password';
                }else{
                  return null;
                }
              },
            ),
          const SizedBox(height: 20,),
          RoundedBtn(btnName: 'Sign Up',isLoading: loading ,ontap: (){
            if(_formKey.currentState!.validate()){
              setState(() {
                loading= true;
              });
                _firebaseAuth.createUserWithEmailAndPassword(
                    email: emailController.text.toString(),
                    password: passwordController.text.toString())
                    .then((value){
                      ToastMsg().showToastMsg(value.user!.email.toString());
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context)=>const HomeScreen()));
                      setState(() {
                        loading=false;
                      });

                })
                    .onError((error, stackTrace){
                      ToastMsg().showToastMsg(error.toString());
                      setState(() {
                        loading = false;
                      });
                });

            }

          }),
          const SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Already having an account?'),
              TextButton(onPressed: (){
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context)=>const LoginScreen()));
              }, child: const Text('LogIn'))
            ],
          )

        ],
      ),
          )),
    );
  }
}
