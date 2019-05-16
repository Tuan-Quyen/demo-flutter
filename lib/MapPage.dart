import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_app/widgets/CustomAppBar.dart';
//import 'package:location/location.dart';
import 'package:flutter/services.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Map<String,double> currentLocation = new Map();
  StreamSubscription<Map<String,double>> locationSubcription;
  //var location = new Location();
  String error;

  Completer<GoogleMapController> _completer = Completer();

  @override
  void initState() {
    super.initState();
    currentLocation['latitude'] = 0.0;
    currentLocation['longitude'] = 0.0;
    initPermissionCheck();
    /*location.onLocationChanged().listen((currentLocation){
      setState(() {
        this.currentLocation = currentLocation as Map<String, double>;
      });
    });*/
  }

  final CameraPosition _cameraPosition = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  void _onMapCreated(GoogleMapController controller) {
    _completer.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        color: Colors.black,
        title: Text(
          "Map",
          style: TextStyle(color: Colors.white, fontSize: 23),
        ),
        hasLeft: false,
        hasRight: false,
      ),
      body: GoogleMap(
        markers: {
          testMarker
        },
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        mapType: MapType.normal,
        initialCameraPosition: _cameraPosition,
        onMapCreated: _onMapCreated,
      ),
    );
  }

  Marker testMarker = Marker(
    markerId: MarkerId("TestMaker"),
    position: LatLng(37.42796133580664, -122.085749655962),
    infoWindow: InfoWindow(title: "TestMarker")
  );

  void initPermissionCheck() {
    try{

    }on PlatformException catch(e){
      if(e.code == "PERMISSION_DENIED"){
        
      }else if(e.code == "PERMISSION_DENIED_NEVER_ASK"){

      }
    }
  }
}
