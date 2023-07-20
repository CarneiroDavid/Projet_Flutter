import 'package:flutter/material.dart';
import 'package:ipssisqy2023/controller/all_utilisateur.dart';
import 'package:ipssisqy2023/controller/mes_favoris.dart';
import 'package:ipssisqy2023/model/my_user.dart';
import 'package:ipssisqy2023/view/my_drawer.dart';
import 'package:ipssisqy2023/view/resgister_view.dart';

import '../controller/animation_controller.dart';
import '../globale.dart';
import 'dashboard_view.dart';

class UserProfileView extends StatefulWidget {
  MyUser user;
  UserProfileView({super.key, required this.user});

  @override
  State<UserProfileView> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfileView> {
  //variable
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Container(
        width: MediaQuery.of(context).size.width *0.75,
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: const MyDrawer(),
      ),
      appBar: AppBar(
        backgroundColor: Colors.cyan[100],
        elevation: 0,
      ),
      backgroundColor : Colors.grey[100],
      body:  SingleChildScrollView(

          child : Padding(
              padding : const EdgeInsets.all(10),
              child : Center(
                  child :   Column(
                      children: [
                          Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                              color: Colors.white,
                              child: Column(
                                children: [
                                  Column(
                                    children: [
                                      InkWell(
                                        child: CircleAvatar(
                                          radius: 80,
                                          backgroundImage: NetworkImage(me.avatar ?? defaultImage),
                                        ),
                                      ),
                                    ],
                                  ),
                                  ListTile(
                                    title: Text("Nom complet : ${widget.user.fullName}"),
                                  ),
                                  ListTile(
                                    title: Text("Adresse email : ${widget.user.mail}"),
                                  ),
                                  ListTile(
                                    title: Text("Date : ${widget.user.birthday}"),
                                  )
                                ],
                              ),

                          ),
                        MyAnimationController(
                          delay: 0,
                          child: ElevatedButton(
                              style : ElevatedButton.styleFrom(
                                  backgroundColor : Colors.cyan,
                                  shape : const StadiumBorder()
                              ),
                              onPressed : (){
                                  Navigator.push(context,MaterialPageRoute(
                                      builder : (context){
                                        return const MyDashBoardView();
                                      }
                                  ));
                              },
                              child : const Text("Accueil")
                          ),
                        ),
                      ]
                  )
              )
          )
      )
    );
  }
}
