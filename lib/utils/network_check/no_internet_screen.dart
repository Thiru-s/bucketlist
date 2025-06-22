
import 'package:flutter/material.dart';
import '../resources/resource_imports.dart';

class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: backgroundclr,
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                UiHelper.verticalSpace(height: screenHeight*0.22),
                Image.asset('assets/no_internet.png',height: 150,width: 150,),
                UiHelper.verticalSpace(height: 35),
                poppinsSmall12(context,'Oops, No Internet Connection',fontWeight: FontWeight.w500,fontSize: 18),
                UiHelper.verticalSpace(height: 16),
                poppinsSmall12(context,
                  "Please check your internet connectivity\nand try again",
                  fontWeight: FontWeight.w400,fontSize: 14,textColor: const Color(0xff404040),
                  textAlign: TextAlign.center,
                ),
                const Spacer(),
                brownButton(context: context, labelText: 'Retry',width: 285 ),
                UiHelper.verticalSpace(height: screenHeight*0.06),
              ],
            ),
          ),
        ),
      ),
    );
  }
}