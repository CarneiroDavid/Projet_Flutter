//classe qui va nou aider à la gestion de la base de donnée
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:ipssisqy2023/model/my_user.dart';
import 'package:geolocator/geolocator.dart';


class FirestoreHelper{
  final auth = FirebaseAuth.instance;
  final storage = FirebaseStorage.instance;
  final cloudUsers = FirebaseFirestore.instance.collection("UTILISATEURS");

  //inscription
   Future <MyUser> register(String email , String password, String nom, String prenom) async {
    UserCredential resultat = await auth.createUserWithEmailAndPassword(email: email, password: password);

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    double latitude = position.latitude;
    double longitude = position.longitude;

    String uid = resultat.user?.uid ?? "";
    Map<String,dynamic> map = {
      "EMAIL":email,
      "NOM": nom,
      "PRENOM":prenom,
      "LOCALISATION": GeoPoint(latitude, longitude),
    };
    addUser(uid, map);
    return getUser(uid);


  }

  Future<String> stockageData(String ref, String uid, String nameData, Uint8List bytesData) async{

     TaskSnapshot snapshot= await storage.ref("$ref/$uid/$nameData").putData(bytesData);
     String urlData = await snapshot.ref.getDownloadURL();
     return urlData;

  }

  updateUser(String uid , Map<String,dynamic> data){
     cloudUsers.doc(uid).update(data);

  }

  Future<MyUser>connect(String email , String password) async {
     UserCredential resultat = await auth.signInWithEmailAndPassword(email: email, password: password);
     String uid = resultat.user?.uid ?? "";
     return getUser(uid);

  }


  Future<MyUser>getUser(String uid) async {
     DocumentSnapshot snapshot = await cloudUsers.doc(uid).get();
     return MyUser(snapshot);
  }
  createMessage(String userId, map){
     cloudUsers.doc(userId).update({
       "convs": FieldValue.arrayUnion([map])
     });
     return map;
  }
  addUser(String uid, Map<String,dynamic> data){
    cloudUsers.doc(uid).set(data);

  }



  //connexion







}