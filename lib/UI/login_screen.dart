import 'package:firebase_pract/UI/Widget/rounded_btn.dart';
import 'package:firebase_pract/UI/Widget/text_form_field.dart';
import 'package:firebase_pract/UI/signup_screen.dart';
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
              SizedBox(height: 15,),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Enter Password",
                  prefixIcon: Icon(Icons.lock)
                ),
                validator: (value){
                  if(value!.isEmpty){
                    return 'Enter password';
                  }
                },
              ),

              SizedBox(height: 20,),
              RoundedBtn(btnName: 'Log In', ontap: (){
                  if(_formKey.currentState!.validate()){

                  }
              }),
              SizedBox(height: 15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Don\'t have any account?'),
                  TextButton(onPressed: (){
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context)=>SignUpScreen()));
                  }, child: Text('Sign Up'))
                ],
              )
            ],
          ),

        ),
      ),
    );
  }
}
