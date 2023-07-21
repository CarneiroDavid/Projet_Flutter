import 'package:flutter/material.dart';
import 'package:ipssisqy2023/controller/chat.dart';
import 'package:ipssisqy2023/controller/firestore_helper.dart';
import 'package:ipssisqy2023/globale.dart';
import 'package:ipssisqy2023/model/my_user.dart';
import 'package:ipssisqy2023/view/user_profile.dart';

class MyFavorites extends StatefulWidget {
  const MyFavorites({super.key});

  @override
  State<MyFavorites> createState() => _MyFavoritesState();
}

class _MyFavoritesState extends State<MyFavorites> {
  List<MyUser> maListeAmis = [];

  @override
  void initState() {
    // TODO: implement initState
    for(String uid in me.favoris!){
      FirestoreHelper().getUser(uid).then((value){
        setState(() {
          maListeAmis.add(value);
        });
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: maListeAmis.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1,crossAxisSpacing: 5,mainAxisSpacing: 5),
        itemBuilder: (context,index){
        MyUser otherUser = maListeAmis[index];
          return ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent),
            onPressed: (){
              Navigator.push(context,MaterialPageRoute(
                  builder : (context){
                    return UserProfileView(user: otherUser);
                  }
              ));
            },
            child: Container(
              padding: const EdgeInsets.all(10),
             height:230,
             decoration: BoxDecoration(
               color: Colors.white,
               borderRadius: BorderRadius.circular(15)
             ),
              child: Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(otherUser.avatar ?? defaultImage,),
                    ),
                    Text(otherUser.fullName, style: TextStyle(color: Colors.black)),
                    ElevatedButton(
                        style:ElevatedButton.styleFrom(
                          backgroundColor : Colors.purple,
                          shape : const StadiumBorder()
                        ),
                        onPressed: (){
                          Navigator.push(context,MaterialPageRoute(
                              builder : (context){
                                return UserChat(user:otherUser);
                              }
                          ));
                        },
                        child: const Text('Discuter'),

                    )
                  ],
                ),
              ),
            ),
          );
      }
    );
  }
}
