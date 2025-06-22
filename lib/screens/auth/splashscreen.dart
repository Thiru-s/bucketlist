
import 'package:bucket_list_flutter/main.dart';
import 'package:bucket_list_flutter/screens/auth/login.dart';
import 'package:bucket_list_flutter/screens/bottom_nav_bar/bottom_nav_bar_convex.dart';
import 'package:bucket_list_flutter/utils/network_check/connectivity_listener.dart';
import 'package:bucket_list_flutter/utils/resources/resource_imports.dart';
import 'package:bucket_list_flutter/utils/shared_preference.dart';
import 'package:flutter/services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    getStoredValue();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (_) => ConnectivityListener(child: const LoginScreen())),
      );
    });
   /* Future.delayed(const Duration(seconds: 3), () {
      if(loginValue && isRememberMe){
        Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (_) => ConnectivityListener(child: const BottomNavBarConvex())),
        );
      }else{
        Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (_) => ConnectivityListener(child: const LoginScreen())),
        );
      }
    });*/
  }

  @override
  Widget build(BuildContext context) {
    return  AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // or whatever you want for splash
        systemNavigationBarIconBrightness:Brightness.dark,
        statusBarIconBrightness:Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: Colors.black, // fallback color while image loads
        body: SizedBox.expand(
          child: Image.asset(
            'assets/splashscreen.png',
            fit: BoxFit.cover, // Or BoxFit.fill if you want exact stretch
          ),
        ),
      ),
    );
  }
}

Future<void> getStoredValue() async {
  var token = PreferenceManager.getStringValue(key: TOKEN) ?? '';
  myUserID = PreferenceManager.getIntegerValue(key: USER_ID) ?? 0;
  isRememberMe = PreferenceManager.getBooleanValue(key: IS_REMEMBER_ME) ?? false;


  print('isRememberMe:$isRememberMe');
  print('myUserID:$myUserID');
  print('tokenMain:$token');
  if (token != '') {
    loginValue = true;
  }
  print('loginValue:$loginValue');
}