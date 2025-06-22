import 'package:bucket_list_flutter/utils/apptext.dart';
import 'package:bucket_list_flutter/utils/resources/resource_imports.dart';
import 'package:bucket_list_flutter/utils/style_sheet.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

abstract class AppWidgets {



  static Widget commonTextField({
    FocusNode? focusNode,
    int? inputMaxLine,
    Widget? suffixIcon,
    bool? obscureText,
    Widget? prefixIcon,
    TextEditingController? inputController,
    String? inputHintText,
    int? maxLength,
    String? Function(String?)? validator,
    bool readOnly = false,
    Key? key,
    void Function()? onTap,
    void Function(String)? onChanged,
    TextInputType? keyboardType,
    TextInputAction? textInputAction,
    void Function()? onEditingComplete,
    Color? bgColor,
    void Function(String?)? onSaved,
    List<TextInputFormatter>? inputFormatters,
    TextCapitalization textCapitalization = TextCapitalization.words,
    Color? borderColor,

  }) =>
      TextFormField(
        key: key,
        readOnly: readOnly,
        obscureText: obscureText ?? false,
        onTap: onTap,
        onChanged: onChanged,
        onEditingComplete: onEditingComplete,
        onSaved: onSaved,
        maxLines: inputMaxLine,
        maxLength: maxLength??50,
        validator: validator,
        controller: inputController,
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, fontFamily: "Poppins",
            color: blackColor),
   //     keyboardType: keyboardType ?? TextInputType.text,
        keyboardType: keyboardType ??
            (inputMaxLine != null && inputMaxLine > 1
                ? TextInputType.multiline
                : TextInputType.text),
      //  textInputAction: textInputAction ?? TextInputAction.done,
        textInputAction: textInputAction ??
            (inputMaxLine != null && inputMaxLine > 1
                ? TextInputAction.newline
                : TextInputAction.done),
        textCapitalization:textCapitalization,
        autovalidateMode: AutovalidateMode.onUserInteraction,
     //   inputFormatters: inputFormatters, // Pass input formatters here
        inputFormatters: [
          ...?inputFormatters,
          NoLeadingSpaceFormatter(),
          FilteringTextInputFormatter.deny(RegExp(r"\s{2,}")),
        ],
        cursorColor: AppColoStyles.primaryColor,
        decoration: InputDecoration(
          isDense: true,
          suffixIcon: suffixIcon,
          suffixIconConstraints: BoxConstraints(
            minHeight: 20,
            minWidth: 20,
          ),
          prefixIcon: prefixIcon,
          filled: true,
          fillColor: bgColor ?? Colors.transparent,
         // contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          contentPadding: EdgeInsets.only(top: 13, bottom: 13, left: 20, right: 20),

          // hintText: inputHintText,
          hintText: inputHintText?.tr(),
         // hintStyle: AppTextStyle.hintTextStyle,
          hintStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, fontFamily: "Poppins",
              color: AppColoStyles.hintTextColor),
          errorMaxLines: 3, // 👈 ADD THIS LINE
          border: OutlineInputBorder(
            borderRadius:
            BorderRadius.circular(inputMaxLine == 1 ? 10 : 10),
            borderSide: BorderSide(color: borderColor ?? AppColoStyles.primaryColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius:
            BorderRadius.circular(inputMaxLine == 1 ? 10 : 10),
            borderSide: BorderSide(color: borderColor ?? AppColoStyles.primaryColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius:
            BorderRadius.circular(inputMaxLine == 1 ? 10 : 10),
            borderSide: BorderSide(color: borderColor ?? AppColoStyles.primaryColor),
          ),
          counterText: ""
        ),
      );


  static void showSentDialog(BuildContext context,{
  required  String titleText ,
  }) {

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
            backgroundColor: Colors.white,
            title: AppText(
              fontWeight: FontWeight.w500,
              size: 14.sp,
              text: titleText,
              maxlin: 5,
              textAlign: TextAlign.center,
            ),
            content: GestureDetector(
              onTap: () async {
                context.pop();
                //Navigator.pop(context);
              },
              child: Padding(
                padding:EdgeInsets.only(left: 2.w,top: 4.h),
                child: Container(
                  height: 4.5.h,
                  width: 50.w,
                  decoration: BoxDecoration(
                    border: Border.all(color: buttonColor), // Gray border
                    borderRadius: BorderRadius.circular(30),
                    color: buttonColor
                  ),
                  padding: EdgeInsets.all(8.0),
                  child: AppText(
                    fontWeight: FontWeight.w500,
                    size: 13.sp,
                    text: 'Okay!',
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          );
      },
    );
  }


}