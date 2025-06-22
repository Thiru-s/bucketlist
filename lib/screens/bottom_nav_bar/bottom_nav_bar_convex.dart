import 'package:bucket_list_flutter/screens/all_request/all_request.dart';
import 'package:bucket_list_flutter/screens/homescreen/homescreen.dart';
import 'package:bucket_list_flutter/screens/invoices/invoices.dart';
import 'package:bucket_list_flutter/screens/notification/notification_screen.dart';
import 'package:bucket_list_flutter/screens/profile/profile_screen.dart';
import 'package:bucket_list_flutter/utils/resources/resource_imports.dart';
import 'package:bucket_list_flutter/utils/style_sheet.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
class BottomNavBarConvex extends StatefulWidget {
  const BottomNavBarConvex({super.key});

  @override
  State<BottomNavBarConvex> createState() => _BottomNavBarConvexState();
}

class _BottomNavBarConvexState extends State<BottomNavBarConvex>  with SingleTickerProviderStateMixin {
  late TabController _tabController;
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


  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, // Always intercept pop
      onPopInvokedWithResult: (didPop, result) {
        if (_tabController.index != 0) {
          _tabController.animateTo(0);
          return;
        }
        // Allow system back button to work if on home tab
        Navigator.of(context).maybePop();
      },
      child: Scaffold(
        backgroundColor: backgroundclr,
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _tabController,
          children: [
            HomeScreen(controller: _tabController),
            AllRequest(controller: _tabController),
            Invoices(controller: _tabController),
            NotificationScreen(),
            ProfileScreen(),
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
            height: 42,
            backgroundColor: Colors.white,
            style: TabStyle.react,
            color: Colors.grey,
            activeColor: AppColoStyles.primaryColor,
            controller: _tabController,
            curve: Curves.linear,
              curveSize:55,
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