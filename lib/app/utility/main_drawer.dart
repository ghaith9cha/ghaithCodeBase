import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ghaith_project/app/modules/dashboard/controllers/dashboard_controller.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DashBoardController controller = Get.find();

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('Drawer'),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            title: Text('Home'),
            tileColor: Get.currentRoute == '/home' ? Colors.grey[300] : null,
            onTap: () {
              print(Get.currentRoute);
              controller.changeTabIndex(0);
              controller.update();
            },
          ),
          ListTile(
            title: Text('Map'),
            tileColor: Get.currentRoute == '/page1' ? Colors.grey[300] : null,
            onTap: () {
              controller.changeTabIndex(1);
              controller.update();
            },
          ),
          ListTile(
            title: Text('Downloader'),
            tileColor: Get.currentRoute == '/page2' ? Colors.grey[300] : null,
            onTap: () {
              controller.changeTabIndex(2);
              controller.update();
            },
          ),
          ListTile(
            title: Text('Camera'),
            tileColor: Get.currentRoute == '/page2' ? Colors.grey[300] : null,
            onTap: () {
              controller.changeTabIndex(3);
              controller.update();
            },
          ),
        ],
      ),
    );
  }
}
