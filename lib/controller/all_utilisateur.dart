import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ipssisqy2023/controller/firestore_helper.dart';
import 'package:ipssisqy2023/globale.dart';
import 'package:ipssisqy2023/model/my_user.dart';

import '../view/user_profile.dart';

class AllUsers extends StatefulWidget {
  const AllUsers({super.key});

  @override
  State<AllUsers> createState() => _AllUsersState();
}

class _AllUsersState extends State<AllUsers> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirestoreHelper().cloudUsers.snapshots(),
        builder: (context,snap){
          List documents = snap.data?.docs ?? [];
          if(documents == []){
            return const Center(
              child: Text("Pas de donnée"),
            );
          }
          else
            {
              return ListView.builder(

                itemCount: documents.length,
                  itemBuilder: (context,index){
                    MyUser autreUtilisateur = MyUser(documents[index]);
                    if(me.id == autreUtilisateur.id){
                      return Container();
                    }
                    else
                      {
                        return ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent),
                            onPressed: (){
                              Navigator.push(context,MaterialPageRoute(
                              builder : (context){
                                return UserProfileView(user: autreUtilisateur);
                              }
                              ));
                            },
                            child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                color: Colors.white,
                                child: ListTile(
                                  leading: Container(
                                    height: 120,
                                    width: 120,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: NetworkImage(autreUtilisateur.avatar ?? defaultImage),
                                        fit: BoxFit.fill
                                      )
                                    ),
                                  ),
                                  title: Text(autreUtilisateur.fullName),
                                  subtitle: Text(autreUtilisateur.mail),
                                  trailing: IconButton(
                                    icon: Icon(Icons.favorite,color: (me.favoris!.contains(autreUtilisateur.id))?Colors.red:Colors.grey,),
                                    onPressed: (){
                                      setState(() {
                                        if(me.favoris!.contains(autreUtilisateur.id)){

                                          me.favoris!.remove(autreUtilisateur.id);
                                        }
                                        else
                                        {
                                          me.favoris!.add(autreUtilisateur.id);
                                        }
                                        Map<String,dynamic> map = {
                                          "FAVORIS":me.favoris
                                        };
                                        FirestoreHelper().updateUser(me.id, map);
                                      });
                                    }
                                  ),
                          ),
                        )
                        );
                      }

                  }
              );
            }
        }
    );
  }
}
