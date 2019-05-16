import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/ultils/CheckPermission.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_app/widgets/CustomAppBar.dart';
import 'package:geolocator/geolocator.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Completer<GoogleMapController> _completer = Completer();
  GoogleMapController controller;
  Position location;

  @override
  void initState() {
    super.initState();
    initPermissionCheck();
  }

  static CameraPosition _cameraPosition(double latitude, double longitude) {
    return CameraPosition(target: LatLng(latitude, longitude), zoom: 18);
  }

  Future _onMapCreated(GoogleMapController controller) async {
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
        markers: {testMarker},
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        initialCameraPosition: location != null
            ? _cameraPosition(location.latitude, location.longitude)
            : _cameraPosition(37.42796133580664, -122.085749655962),
        mapType: MapType.normal,
        onMapCreated: _onMapCreated,
      ),
    );
  }

  Marker testMarker = Marker(
      markerId: MarkerId("TestMaker"),
      position: LatLng(37.42796133580664, -122.085749655962),
      infoWindow: InfoWindow(title: "TestMarker"));

  void initPermissionCheck() async {
    final statusLocation = await CheckPermission().checkPermissionLocation();
    if (statusLocation) {
      _currentPosition();
    }
  }

  Future<void> _currentPosition() async {
    controller = await _completer.future;
    await Geolocator().getLastKnownPosition().then((currenLocation) {
      setState(() {
        if (currenLocation == null) {
          Geolocator().getCurrentPosition().then((currenLocation) {
            location = currenLocation;
          });
        } else {
          location = currenLocation;
        }
        controller.animateCamera(CameraUpdate.newCameraPosition(
            _cameraPosition(location.latitude, location.longitude)));
      });
    });
  }
}
