import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ghaith_project/app/modules/map/controllers/map_controller.dart';
import 'package:ghaith_project/app/utility/main_drawer.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Map extends GetView<MapController> {
  @override
  Widget build(BuildContext context) {
    if (controller.isEnvExist == "" || controller.isEnvExist ==null) {
      return Text("Please Create Environment File if not exists and Add your key to .ENV");
    } else {
      return Scaffold(
        drawer: MainDrawer(),
        appBar: AppBar(
          title: Text('MAPS'),
          centerTitle: true,
        ),
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
                        child: Obx(() {
                          return GoogleMap(
                            initialCameraPosition: CameraPosition(
                                target: controller.initialCameraPosition.value),
                            mapType: MapType.normal,
                            onMapCreated: controller.onMapCreated,
                            myLocationEnabled: true,
                            onTap: controller.handleTapped,
                            markers: Set.from(controller.myMarker),
                          );
                        })),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }
  }
}
