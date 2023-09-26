import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
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
final _signOut = FirebaseAuth.instance;

final ref = FirebaseDatabase.instance.ref('user');
final searchController = TextEditingController();
final editController = TextEditingController();

Future <void> showMyDialog(String edit, String id ) async{
  editController.text = edit;
  return showDialog(context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: const Text('Update'),
          content: TextField(
            controller: editController,
          ),
          actions: [
            TextButton(onPressed: (){
              Navigator.pop(context);
            }, child: const Text('Cancel')),
            TextButton(onPressed: (){
              Navigator.pop(context);
              ref.child(id).update({
                'name': editController.text.toLowerCase(),
              }).then((value){
                ToastMsg().showToastMsg('Updated');
              }).onError((error, stackTrace){
                ToastMsg().showToastMsg(error.toString());
              });
            }, child: const Text('Update'))
          ],
        );
      }

  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        actions: [
          IconButton(onPressed: (){
            _signOut.signOut().then((value){
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context)=>const LoginScreen()));
            }).onError((error, stackTrace){
ToastMsg().showToastMsg(error.toString());
            });
          }, icon: const Icon(Icons.logout_outlined))
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context,
            MaterialPageRoute(builder: (context)=>const PostPage()));
      },child: const Icon(Icons.add),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)
      ),
        backgroundColor: Colors.white,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterFloat,


      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            TextFormField(
              controller: searchController,
              decoration:  InputDecoration(
                hintText: 'search',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(
                    color: Colors.blueAccent
                  )
                ),
              ),
              onChanged: (String value){
                setState(() {

                });
              },
            ),
// Expanded(
//    child:  StreamBuilder(
//      stream: ref.onValue,
//      builder: (context, snapshot){
//          if(!snapshot.hasData){
//            return CircularProgressIndicator();
//          }else{
//            Map<dynamic, dynamic> map = snapshot.data!.snapshot.value as dynamic;
//            List<dynamic> list = [];
//             list.clear(); //clear list to prevent duplication, and data dynamically update
//            list = map.values.toList();
//            return ListView.builder(
//              itemCount: snapshot.data!.snapshot.children.length,
//                itemBuilder: (context,index){
//              return ListTile(
//                title: Text(list[index]['name']),
//                subtitle: Text(list[index]['id'].toString()),
//              );
//              }
//          );
//          }
//      },
//    ),
// ),
Expanded(child: FirebaseAnimatedList(query: ref,
  itemBuilder: (context,snapshot, animation,  index){

  final titles = snapshot.child('name').value.toString();
  if(searchController.text.isEmpty){
    return ListTile(
      title: Text(snapshot.child('name').value.toString()),
      subtitle: Text(snapshot.child('id').value.toString()),
      trailing: PopupMenuButton(

        icon: const Icon(Icons.more_vert),
        itemBuilder: (context)=>[
           PopupMenuItem(
              child: ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Edit'),
                onTap: (){
              Navigator.pop(context);
              showMyDialog(titles, snapshot.child('id').value.toString());
                },
          )),
           PopupMenuItem(child: ListTile(
            leading: const Icon(Icons.delete),
            title: const Text('Delete'),
            onTap: (){
              ref.child(snapshot.child('id').value.toString()).remove();
              Navigator.pop(context);
            },
          ))
        ],
      ),
    );
  }else if(titles.toLowerCase().contains(searchController.text.toLowerCase())){
    return ListTile(
      title: Text(snapshot.child('name').value.toString()),
      subtitle: Text(snapshot.child('id').value.toString()),
      trailing: PopupMenuButton(
        child: Icon(Icons.more_vert),
        itemBuilder: (context)=>[
          PopupMenuItem(
              child: ListTile(
                leading: const Icon(Icons.edit),
                title: const Text('Edit'),
                onTap: (){
                  Navigator.pop(context);
                  showMyDialog(titles, snapshot.child('id').value.toString());
                },
              )),
          PopupMenuItem(child: ListTile(
            leading: const Icon(Icons.delete),
            title: const Text('Delete'),
            onTap: (){
              ref.child(snapshot.child('id').value.toString()).remove();
              Navigator.pop(context);
            },
          ))
        ],
      ),
    );
  }else{
    return Container();
  }

//   final titles = snapshot.child('name').value.toString();
//   if(searchController.text.isEmpty){
//     return ListTile(
//       title: Text(snapshot.child('name').value.toString()),
//       subtitle: Text(snapshot.child('id').value.toString()),
//     );
//   }else if(titles.toLowerCase().contains(searchController.text.toLowerCase())){
// return ListTile(
//   title: Text(snapshot.child('name').value.toString()),
// );
//   }else{
//     return Container();
//   }

  },

))
          ],
        ),
      ),
    );
  }
  

}

