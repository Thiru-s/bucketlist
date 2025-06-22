import 'package:bucket_list_flutter/screens/bottom_nav_bar/bottom_nav_bar_convex.dart';
import 'package:bucket_list_flutter/utils/resources/resource_imports.dart';
import 'package:flutter/services.dart';

class SuccessCreatedDialog extends StatefulWidget {
  const SuccessCreatedDialog({super.key});

  @override
  State<SuccessCreatedDialog> createState() => _SuccessCreatedDialogState();
}

class _SuccessCreatedDialogState extends State<SuccessCreatedDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      contentPadding: EdgeInsets.only(left:60,right:60,top: 30,bottom: 0),
      insetPadding: EdgeInsets.only(left: 5,right: 5,),
      actionsAlignment: MainAxisAlignment.center,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset('assets/created.png',height: 65,width: 65,),
          UiHelper.verticalSpace(height: 18),
          largeText16(context, 'Request Successfully Shared With Client',fontSize: 20,
              fontWeight: FontWeight.w500,textColor: Color(0xff404040),textAlign: TextAlign.center),
          UiHelper.verticalSpace(height: 18),
        ],
      ),
      actions: [
        TextButton(
          onPressed: (){
            CustomNavigator.pushAndRemoveUntil(
                context: context,
                screen: BottomNavBarConvex());
          },
          child: Text( "Home >>",style: TextStyle(
            fontWeight: FontWeight.w500,fontFamily: "Poppins",fontSize: 16,
            decoration: TextDecoration.underline,
            decorationColor: Colors.black,
            decorationThickness: 1.8,
            decorationStyle: TextDecorationStyle.solid,
            color: Colors.transparent,
            shadows: [
              Shadow(
                  color: textClr,
                  offset: Offset(0, -3))
            ],
          )),
        ),
      ],
    );
  }
}
