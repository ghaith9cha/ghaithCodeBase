import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geocode/geocode.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Map extends StatefulWidget {
  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
  GeoCode geoCode = GeoCode();
  bool isFirstTime = true;
  late StreamSubscription<LocationData> locationSubscription;
  late LocationData _currentPosition;
  late GoogleMapController mapController;
  late Marker marker;
  final myMarker = [];
  Location location = Location();
  late GoogleMapController _controller;
  LatLng _initialcameraposition = LatLng(0.5937, 0.9629);

  @override
  void initState() {
    // TODO: implement initState
    getLoc();
    super.initState();
  }

  //Setup Map controller
  void _onMapCreated(GoogleMapController _cntlr) {
    _controller = _cntlr;

    //make Stream Subscription to zoom to the current location then dispose
    locationSubscription = location.onLocationChanged.listen((l) {
      if (isFirstTime == true) {
        isFirstTime = false;
        _initialcameraposition = LatLng(l.latitude!, l.longitude!);
        print("TEST TEST ${l.longitude} : ${l.longitude}");
        _controller.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(target: LatLng(l.latitude!, l.longitude!), zoom: 15),
          ),
        );
      } else {
        locationSubscription.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SafeArea(
          child: Container(
            color: Colors.blueGrey.withOpacity(.8),
            child: Center(
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: _initialcameraposition,
                      ),
                      mapType: MapType.normal,
                      onMapCreated: _onMapCreated,
                      myLocationEnabled: true,
                      onTap: _handleTapped,
                      markers: Set.from(myMarker),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
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
        _initialcameraposition =
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
      _initialcameraposition =
          LatLng(_currentPosition.latitude!, _currentPosition.longitude!);
    }
  }
//Set the marker on tab and change the location of the map
  _handleTapped(LatLng tappedPoint) {
    _controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(tappedPoint.latitude, tappedPoint.longitude), zoom: 15),
      ),
    );

    print("My tapped Point $tappedPoint");
    setState(() {
      _initialcameraposition =
          LatLng(tappedPoint.latitude, tappedPoint.longitude);
      myMarker.add(Marker(
          onDragEnd: (dragEndPosition) {
            print(dragEndPosition);
          },
          markerId: MarkerId(tappedPoint.toString()),
          position: tappedPoint));
    });
  }
}
