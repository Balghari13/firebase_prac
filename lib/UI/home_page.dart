import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_pract/UI/Widget/rounded_btn.dart';
import 'package:firebase_pract/UI/login_screen.dart';
import 'package:firebase_pract/UI/post_page.dart';
import 'package:firebase_pract/UI/utilis/toast_msg.dart';
import 'package:flutter/material.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
FirebaseAuth _signOut = FirebaseAuth.instance;

final ref = FirebaseDatabase.instance.ref('user');

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
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context,
            MaterialPageRoute(builder: (context)=>PostPage()));
      },child: Icon(Icons.add),),
      body: Column(
        children: [
Expanded(
   child:  StreamBuilder(
     stream: ref.onValue,
     builder: (context, snapshot){
       if(!snapshot.hasData){
         return CircularProgressIndicator();
       }else{
         Map<dynamic, dynamic> map = snapshot.data!.snapshot.value as dynamic;
         List<dynamic> list = [];
         list.clear();
        list = map.values.toList();
        return ListView.builder(
          itemCount: snapshot.data!.snapshot.children.length,
            itemBuilder: (context,index){
          return ListTile(
            title: Text(list[index]['name']),
            subtitle: Text(list[index]['id'].toString()),
          );

        });
       }
     },
   ),
),
Expanded(child: FirebaseAnimatedList(query: ref,
  itemBuilder: (context,snapshot, animation,  index){
  return ListTile(
    title: Text(snapshot.child('name').value.toString()),
    subtitle: Text(snapshot.child('id').value.toString()),
  );
  },

))
        ],
      ),
    );
  }
}
