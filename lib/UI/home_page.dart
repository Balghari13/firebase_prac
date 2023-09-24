import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_pract/UI/Widget/rounded_btn.dart';
import 'package:firebase_pract/UI/login_screen.dart';
import 'package:firebase_pract/UI/utilis/toast_msg.dart';
import 'package:flutter/material.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
FirebaseAuth _signOut = FirebaseAuth.instance;
bool loading = false;
final databaseRef = FirebaseDatabase.instance.ref('user');
final textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        actions: [
          IconButton(onPressed: (){
            _signOut.signOut().then((value){
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context)=>LoginScreen()));
            }).onError((error, stackTrace){
ToastMsg().showToastMsg(error.toString());
            });
          }, icon: Icon(Icons.logout_outlined))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 15,),

TextFormField(
  controller: textController,
  maxLines: 4,
  decoration: InputDecoration(
    hintText: 'Enter your data',
    border: OutlineInputBorder(),
  ),
),
            SizedBox(height: 15,),
            RoundedBtn(btnName: 'Add',
                isLoading: loading,
                ontap: (){
              setState(() {
                loading= true;
              });
            databaseRef.child(DateTime.now().millisecondsSinceEpoch.toString()).set({
              'name': textController.text.toString(),
                'id': DateTime.now().millisecondsSinceEpoch,
            }
            ).then((value){
              ToastMsg().showToastMsg('Added');
              setState(() {
                loading = false;
              });
            }).onError((error, stackTrace){
              ToastMsg().showToastMsg(error.toString());
              setState(() {
                loading= false;
              });
            });

            })
          ],
        ),
      ),
    );
  }
}
