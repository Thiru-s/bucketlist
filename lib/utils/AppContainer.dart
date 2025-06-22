import 'package:bucket_list_flutter/utils/resources/resource_imports.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
//import 'package:sizer/sizer.dart';
import 'apptext.dart';
// ignore: must_be_immutable
class AppContainer extends StatelessWidget {
  final double? width;
  final double? height;
  final String text;
  double size;


  AppContainer({Key? key, this.width, required this.text,required this.size, this.height,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(

      height: height,
      width: width,
      decoration:
      BoxDecoration(borderRadius: BorderRadius.circular(32), color: buttonColor),
      child: Center(
          child: AppText(
            fontWeight: FontWeight.w500,
            size: size,
            text: text,
            color: Colors.white,
          )),
    );
  }
}




class Appcontainer extends StatelessWidget {
  final String text;
  final bool isEnable;
  final VoidCallback? onPressed; // Add onPressed callback

  const Appcontainer({
    Key? key,
    required this.text,
    this.isEnable = true,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
   //   padding: EdgeInsets.only(left: 4.w, right: 4.w),
      padding: EdgeInsets.only(left: 4, right: 4),
      child: Container(

        width: MediaQuery.of(context).size.width,
        height: 60,
        decoration: BoxDecoration(
            color: buttonColor,
          borderRadius: BorderRadius.circular(30),
          boxShadow: kElevationToShadow[3],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: isEnable ? onPressed : null, // Handle button press
            borderRadius: BorderRadius.circular(30),
            child: Center(
              child: Text(
                text.tr(),
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontFamily: 'Nunito Sans',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
