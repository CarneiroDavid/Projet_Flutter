import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ipssisqy2023/controller/firestore_helper.dart';

import '../model/my_user.dart';

class CarteGoogle extends StatefulWidget {
  Position location;
  CarteGoogle({super.key, required this.location});

  @override
  State<CarteGoogle> createState() => _CarteGoogleState();
}

class _CarteGoogleState extends State<CarteGoogle> {
  // Variables
  Completer<GoogleMapController> completer = Completer();
  Stream<QuerySnapshot> listeUser = FirestoreHelper().cloudUsers.snapshots();
  late CameraPosition camera;

  Set<Marker> markers = {};

  void initialisation(){
    camera = CameraPosition(
      target: LatLng(widget.location.latitude, widget.location.longitude),
      zoom: 4,
    );

    addMarkers();
  }

  @override
  void initState() {
    initialisation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return GoogleMap(
      initialCameraPosition: camera,
      mapToolbarEnabled: true,
      markers: markers,
      myLocationButtonEnabled: true,
      myLocationEnabled: true,
      onMapCreated: (control) async {
        String newStyle = await DefaultAssetBundle.of(context).loadString("lib/mapStyle.json");
        control.setMapStyle(newStyle);
        completer.complete(control);
      },

    );
  }

  void addMarkers() {
    // Récupération info de user
    listeUser.listen((QuerySnapshot snapshot) {
      markers.clear();

      // Boucle sur les user
      snapshot.docs.forEach((DocumentSnapshot doc) {
        //Concat Nom complet
        String fullName = doc['NOM'] + doc['PRENOM'];

        // Récupération champ GEOPOINT
        GeoPoint? geoPoint = doc['LOCALISATION'] as GeoPoint?;


        // Création du marqueur
        if (geoPoint != null) {
          LatLng latLng = LatLng(geoPoint.latitude, geoPoint.longitude);
          setState(() {
            markers.add(
              Marker(
                markerId: MarkerId(doc.id),
                position: latLng,
                infoWindow: InfoWindow(title: fullName),
              ),
            );
          });
        }
      });
    });
  }
}


