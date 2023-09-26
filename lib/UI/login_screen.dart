import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_pract/UI/Widget/rounded_btn.dart';
import 'package:firebase_pract/UI/home_page.dart';
import 'package:firebase_pract/UI/signup_screen.dart';
import 'package:firebase_pract/UI/utilis/toast_msg.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool loading = false;

  final FirebaseAuth _logIn = FirebaseAuth.instance;

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
        automaticallyImplyLeading: false,
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  hintText: 'Enter Email',
                  prefixIcon: Icon(Icons.email),
                  helperText: 'asj@gma.com',
                ),
                validator: (value){
                  if(value!.isEmpty){
                    return 'Enter email';
                  }
                },
              ),
              const SizedBox(height: 15,),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: "Enter Password",
                  prefixIcon: Icon(Icons.lock)
                ),
                validator: (value){
                  if(value!.isEmpty){
                    return 'Enter password';
                  }
                },
              ),

              const SizedBox(height: 20,),
              RoundedBtn(btnName: 'Log In',isLoading: loading, ontap: (){
                  if(_formKey.currentState!.validate()){
                    setState(() {
                      loading = true;
                    });

                    _logIn.signInWithEmailAndPassword(
                        email: emailController.text.toString(),
                        password: passwordController.text.toString())
                        .then((value){
                          ToastMsg().showToastMsg(value.user!.email.toString());
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context)=>const HomeScreen()));

  setState(() {
    loading = false;
  });
                    })
                        .onError((error, stackTrace){
                          ToastMsg().showToastMsg(error.toString());
                          setState(() {
                            loading= false;
                          });
                    });
                  }
              }),
              const SizedBox(height: 15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Don\'t have any account?'),
                  TextButton(onPressed: (){
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context)=>const SignUpScreen()));
                  }, child: const Text('Sign Up'))
                ],
              )
            ],
          ),

        ),
      ),
    );
  }
}
