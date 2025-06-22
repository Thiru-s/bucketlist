
import 'package:bucket_list_flutter/cubit/bucket_list_cubit.dart';
import 'package:bucket_list_flutter/firebase_msg.dart';
import 'package:bucket_list_flutter/firebase_options.dart';
import 'package:bucket_list_flutter/repository/bucket_list_respository.dart';
import 'package:bucket_list_flutter/screens/auth/splashscreen.dart';
import 'package:bucket_list_flutter/utils/appcolor.dart';
import 'package:bucket_list_flutter/utils/constants.dart';
import 'package:bucket_list_flutter/utils/network_check/connectivity_listener.dart';
import 'package:bucket_list_flutter/utils/shared_preference.dart';
import 'package:bucket_list_flutter/utils/style_sheet.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:easy_localization/easy_localization.dart';

bool loginValue = false;
bool isIOSDevice = true;
String deviceType = "";
String userName = "";
bool isRememberMe = false;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  if (defaultTargetPlatform == TargetPlatform.android) {
    await FirebaseMessageService.initFCM();
  }

  await EasyLocalization.ensureInitialized();
 // await FirebaseMsg().initFCM();
  // Ensure EasyLocalization is initialized

  await PreferenceManager.init();

  SystemChrome.setSystemUIOverlayStyle(
  SystemUiOverlayStyle(
    statusBarColor: backgroundclr, // Green status bar
    systemNavigationBarIconBrightness:Brightness.dark,
    statusBarIconBrightness:Brightness.dark,
  ));

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(EasyLocalization(
      supportedLocales: [Locale('en', 'US'), Locale('es', 'US')],
      path: 'assets/translations', // Make sure your translations are in this directory
      fallbackLocale: Locale('en', 'US'),
      child:  MyApp())));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize screen dimensions
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    final repository = BucketListRepository();

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => BucketListCubit(repository)),
      ],
      child: Sizer(
        builder: (context, orientation, deviceType) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaleFactor: 0.8, // Avoid large system fonts breaking layout
            ),
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Bucket List',
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              theme: ThemeData(
                primaryColor: AppColoStyles.primaryColor,
                appBarTheme: AppBarTheme(
                  color: AppColoStyles.white,
                  elevation: 0,
                  iconTheme: IconThemeData(color: AppColoStyles.black),
                ),
              ),
              home: ConnectivityListener(child: const SplashScreen()),
            //  home: ConnectivityListener(child: HelloConvexAppBar()),
            ),
          );
        },
      ),
    );
  }
}
