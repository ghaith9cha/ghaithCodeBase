import 'dart:async';

import 'package:geocode/geocode.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapController extends GetxController {
  GeoCode geoCode = GeoCode();
  bool isFirstTime = true;
  late StreamSubscription<LocationData> locationSubscription;
  late LocationData _currentPosition;
  late GoogleMapController mapController;
  late Marker marker;
  final myMarker = [];
  Location location = Location();
  Rx<bool> didChange = true.obs;
  Rx<LatLng> initialCameraPosition = Rx<LatLng>(LatLng(0.5937, 0.9629)).obs();

  @override
  void onInit() {
    getLoc();
    super.onInit();
  }

  //Check Permission and Get the current location
  Future<void> getLoc() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      //If denied ask for permission
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        //if permission denied do nothing
        return;
      } else {
        //if permission granted check the location if it is enabled or not
        _serviceEnabled = await location.serviceEnabled();
        if (!_serviceEnabled) {
          _serviceEnabled = await location.requestService();
          if (!_serviceEnabled) {
            return;
          }
        }

        _currentPosition = await location.getLocation();
        initialCameraPosition.value =
            LatLng(_currentPosition.latitude!, _currentPosition.longitude!);
      }
    } else {
      //if permission granted check the location if it is enabled or not
      _serviceEnabled = await location.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await location.requestService();
        if (!_serviceEnabled) {
          return;
        }
      }

      _currentPosition = await location.getLocation();
      initialCameraPosition.value =
          LatLng(_currentPosition.latitude!, _currentPosition.longitude!);
    }
  }

//Set the marker on tab and change the location of the map
  handleTapped(LatLng tappedPoint) {
    mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(tappedPoint.latitude, tappedPoint.longitude),
            zoom: 15),
      ),
    );

    print("My tapped Point $tappedPoint");

    initialCameraPosition.value =
        LatLng(tappedPoint.latitude, tappedPoint.longitude);
    myMarker.add(Marker(
        onDragEnd: (dragEndPosition) {
          print(dragEndPosition);
        },
        markerId: MarkerId(tappedPoint.toString()),
        position: tappedPoint));
  }

  void onMapCreated(GoogleMapController _cntlr) {
    mapController = _cntlr;

    //make Stream Subscription to zoom to the current location then dispose
    locationSubscription = location.onLocationChanged.listen((l) {
      if (isFirstTime == true) {
        isFirstTime = false;
        initialCameraPosition.value = LatLng(l.latitude!, l.longitude!);
        print("TEST TEST ${l.longitude} : ${l.longitude}");
        mapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(target: LatLng(l.latitude!, l.longitude!), zoom: 15),
          ),
        );
      } else {
        locationSubscription.cancel();
      }
    });
  }
}
