import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ghaith_project/app/modules/camera/views/camera_view.dart';
import 'package:ghaith_project/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:ghaith_project/app/modules/download_manager/views/downloader.dart';
import 'package:ghaith_project/app/modules/home/views/home_view.dart';
import 'package:ghaith_project/app/modules/map/views/map_view.dart';
import 'package:ghaith_project/app/utility/main_drawer.dart';

class DashboardView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashBoardController>(
      builder: (controller) {
        return Scaffold(
          body: SafeArea(
            child: IndexedStack(
              children: [
                HomeView(),
                Map(),
                Downloader(),
                CameraView(),
              ],
              index: controller.indexTap,
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            onTap: controller.changeTabIndex,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.grey,
            unselectedItemColor: Colors.black,
            selectedItemColor: Colors.red,
            items: [
              _bottomNavigationBarItem(
                icon: Icons.home,
                label: 'Home',
              ),
              _bottomNavigationBarItem(
                icon: Icons.map,
                label: 'Maps',
              ),
              _bottomNavigationBarItem(
                icon: Icons.file_download,
                label: 'Downloader',
              ),
              _bottomNavigationBarItem(
                icon: Icons.camera_alt,
                label: 'Camera',
              ),
            ],
          ),
          drawer: MainDrawer(),
        );
      },
    );
  }

  _bottomNavigationBarItem({required IconData icon, required String label}) {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      label: label,
    );
  }
}
