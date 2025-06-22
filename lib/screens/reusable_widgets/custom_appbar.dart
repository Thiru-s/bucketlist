import 'package:bucket_list_flutter/utils/appcolor.dart';
import 'package:bucket_list_flutter/utils/custom_widgets.dart';
import 'package:bucket_list_flutter/utils/ui_helper.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final double height;
  final Color? appBarBgColor;
  final Color? textColor;
  final double fontSize;
  final FontWeight fontWeight;
  final VoidCallback? onBackPressed;
  final Widget? actionWidget;
  final double arrowBeforeWidth;
  //final Widget? settingsWidget; // Optional notification widget


  const CustomAppBar({
    super.key,
    required this.title,
    this.height = 68.0,
    this.appBarBgColor = whiteColor,
    this.textColor = appBlackColor,
    this.fontSize=20.0,
    this.fontWeight= FontWeight.w500,
    this.onBackPressed,
    this.actionWidget,
    this.arrowBeforeWidth =4.0
  //  this.settingsWidget,

  });

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: backgroundclr,
      elevation: 0.0,
      centerTitle: true,
      flexibleSpace: Padding(
        padding: const EdgeInsets.only(top: 43.0), // Adjust padding for vertical alignment
        child: Row(
       //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            UiHelper.horizontalSpace(width: arrowBeforeWidth),
            IconButton(
              onPressed: onBackPressed ?? () => Navigator.of(context).pop(),
               icon: Image.asset(
                  "assets/backarrow.png",
                  height: 38, // Adjust these sizes if needed
                  width: 38,
                ),
              ),
            Expanded(
              child: Center(
                child: Padding(
                  padding:  EdgeInsets.only(right: title.length > 8?0:0),
                  child: mediumText14(
                    context,
                    title,
                    fontSize: fontSize,
                    fontWeight: fontWeight,
                    maxLines: 1,
                    textColor: textColor ?? appBlackColor,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            actionWidget != null
                ? actionWidget!
                : const SizedBox(),
         /*  settingsWidget != null
                ? settingsWidget!
                : const SizedBox(),*/
            UiHelper.horizontalSpace(width:actionWidget != null?24:60),// Placeholder space for alignment
          ],
        ),
      ),
    );
  }
}
