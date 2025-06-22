import 'package:bucket_list_flutter/utils/style_sheet.dart';
import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';

class HelloConvexAppBar extends StatefulWidget {
  @override
  State<HelloConvexAppBar> createState() => _HelloConvexAppBarState();
}

class _HelloConvexAppBarState extends State<HelloConvexAppBar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this, initialIndex: 0);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<bool> _onWillPop() async {
    if (_tabController.index != 0) {
      _tabController.animateTo(0); // Move to Home tab
      return false; // Prevent app from exiting
    }
    return true; // Exit app
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: TabBarView(
          controller: _tabController,
          children: const [
            Center(child: Text("Home Screen")),
            Center(child: Text("Add Screen")),
            Center(child: Text("Book Screen")),
            Center(child: Text("Notification")),
            Center(child: Text("Profile")),
          ],
        ),
        bottomNavigationBar:
        Container(
        //  margin: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30), // Circular border
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 5,
                spreadRadius: 2,
              ),
            ], // Optional shadow effect
          ),
          child: ConvexAppBar(
            height: 60,
            backgroundColor: Colors.white,
            style: TabStyle.react,
            color: Colors.grey,
            activeColor: AppColoStyles.primaryColor,
            controller: _tabController,
            curve: Curves.easeInBack,
            items: const [
              TabItem(icon: Icons.home_outlined,
                  activeIcon: Icons.home_filled),
              TabItem(icon: Icons.radar_outlined,
                  activeIcon: Icons.radar),
              TabItem(icon: Icons.file_copy_outlined,
                  activeIcon: Icons.file_copy_rounded),
              TabItem(icon: Icons.notifications_none,
                  activeIcon: Icons.notifications),
              TabItem(icon: Icons.person_outline_rounded,
                  activeIcon: Icons.person),
            ],
            onTap: (int i) {
              _tabController.animateTo(i);
            },
          ),
        ),

      ),
    );
  }
}


/* bottomNavigationBar: ConvexAppBar(
          height: 60,
          backgroundColor: Colors.white,
          style: TabStyle.react,
          color: Colors.grey,
          activeColor: AppColoStyles.primaryColor,
          controller: _tabController,
          items: const [
            TabItem(icon: Icons.home_outlined,
                activeIcon: Icons.home_filled),
            TabItem(icon: Icons.radar_outlined,
                activeIcon: Icons.radar),
            TabItem(icon: Icons.file_copy_outlined,
                activeIcon: Icons.file_copy_rounded),
            TabItem(icon: Icons.notifications_none,
                activeIcon: Icons.notifications),
            TabItem(icon: Icons.person_outline_rounded,
                activeIcon: Icons.person),
          ],
          onTap: (int i) {
            _tabController.animateTo(i);
          },
        ),*/