import 'package:bucket_list_flutter/utils/appcolor.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

class CAppBar extends StatelessWidget {
  final String text;
  const CAppBar({super.key,this.text=""});

  @override
  Widget build(BuildContext context) {
    return AppBar(

      title: Center(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 15.sp,
            color: textClr, // Example color (replace with your `CustomColors.primaryDark`)
          ),

        ),
      ),
      leading:  GestureDetector(
        onTap: (){
          context.pop();
          //Navigator.of(context).pop();
        },
        child: Padding(
          padding: const EdgeInsets.only(left : 12,top: 3),
          child: Image.asset(
            'assets/backarrow.png',
          ),
        ),
      ),

      backgroundColor: backgroundclr,  // Makes the `AppBar` background transparent to see the Stack
      elevation: 0,  // Removes the shadow
    );
  }
}





PreferredSizeWidget appBarWidgetThree({
  required String title,
  required Color titleColor,
  required Color backgroundColor,
  List<Widget>? actions,
  bool? centerTitle,
  VoidCallback? onBackTap, // Callback for back button tap
  Widget? leading, // Custom leading widget
  String? imagePath, // Path to the image to display at the end of the AppBar
  bool showBorder = false, // Parameter to control border visibility
}) {
  // Default leading widget: Back button
  Widget defaultLeading = IconButton(
    icon: Image.asset(
      'assets/backarrow.png', // Path to your custom back icon image
      width: 30.w,
      height: 30.h,// Set the width of the image
    ),
    onPressed: onBackTap,
  );

  // Add the end image widget to the actions list
  List<Widget> appBarActions = actions ?? [];
  if (imagePath != null) {
    appBarActions.add(
      Padding(
        padding: const EdgeInsets.only(right: 16.0),
        child: Center(
          child: Image.asset(
            imagePath,
            width: 24.0, // Adjust the width of the image as needed
          ),
        ),
      ),
    );
  }

  return PreferredSize(
    preferredSize: const Size.fromHeight(kToolbarHeight),
    child: Container(
      decoration: BoxDecoration(
        border: showBorder
            ? Border(
          bottom: BorderSide(
            color: Colors.grey, // Change color as needed
            width: 1.5, // Adjust the thickness of the divider
          ),
        )
            : null, // No border if showBorder is false
      ),
      child: AppBar(
        elevation: 0.0, // Removes shadow
        backgroundColor: backgroundColor,
        centerTitle: centerTitle,
        title: Text(
          title,
          style: TextStyle(
            color: titleColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: leading ??
            defaultLeading, // Use provided leading widget, otherwise use default
        actions: appBarActions,
      ),
    ),
  );
}


