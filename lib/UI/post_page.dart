import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_pract/UI/home_page.dart';
import 'package:firebase_pract/UI/utilis/toast_msg.dart';
import 'package:flutter/material.dart';

import 'Widget/rounded_btn.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  bool loading = false;
  final databaseRef = FirebaseDatabase.instance.ref('user');
  final textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 15,),

            TextFormField(
              controller: textController,
              maxLines: 4,
              decoration: const InputDecoration(
                hintText: 'Enter your data',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15,),
            RoundedBtn(btnName: 'Add',
                isLoading: loading,
                ontap: (){
                  setState(() {
                    loading= true;
                  });
                  String id = DateTime.now().millisecondsSinceEpoch.toString();
                  databaseRef.child(id).set({
                    'name': textController.text.toString(),
                    'id': id,
                  }
                  ).then((value){
                    ToastMsg().showToastMsg('Added');
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context)=>const HomeScreen()));
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
