import 'package:bucket_list_flutter/utils/appcolor.dart';
import 'package:bucket_list_flutter/utils/custom_widgets.dart';
import 'package:bucket_list_flutter/utils/style_sheet.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
class MyDropDownAll<T> extends StatefulWidget {
  final List<T> items;
  final T? selectedValue;
  final String hintText;
  final double hintFontSize;
  final double textFontSize;
  final double borderRadiusValue;
  final double dropDownHeight;
  final double dropDownWidth;
  final Color? menuBgColor;
  final Function(T?) onSelected;
  final String Function(T item) displayText;

  const MyDropDownAll({
    super.key,
    required this.items,
    this.selectedValue,
    required this.hintText,
    required this.hintFontSize,
    this.textFontSize = 14,
    required this.borderRadiusValue,
    required this.dropDownHeight,
    required this.dropDownWidth,
    this.menuBgColor,
    required this.onSelected,
    required this.displayText,
  });

  @override
  State<MyDropDownAll<T>> createState() => _MyDropDownJsonProductState<T>();
}

class _MyDropDownJsonProductState<T> extends State<MyDropDownAll<T>> {
  bool isDropdownOpened = false;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<T>(
        isExpanded: true,
        hint:mediumText14(context, widget.hintText,
            textColor: AppColoStyles.hintTextColor,fontWeight: FontWeight.w400,),
        buttonStyleData: ButtonStyleData(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadiusValue),
            color: backgroundclr,
            border: Border.all( // 👈 Add this line
              color: AppColoStyles.primaryColor,
              width: 1.0,         // Optional: customize thickness
            ),
           /* boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                blurRadius: 3,
                offset: const Offset(0, 2),
              ),
            ],*/
          ),
          elevation: 0,
        ),
        items: widget.items
            .map((item) => DropdownMenuItem<T>(
          value: item,
          child:mediumText14(context, widget.displayText(item),
              fontSize: 14, fontWeight: FontWeight.w400,
              textColor: blackColor
          )
        ))
            .toList(),
        value: widget.selectedValue,
        onChanged: (value) {
          widget.onSelected(value);
        },
        onMenuStateChange: (isOpen) {
          setState(() {
            isDropdownOpened = isOpen;
          });
        },
        dropdownStyleData: DropdownStyleData(
          maxHeight: 200,
          offset: const Offset(0, -3),
          padding:const EdgeInsets.only(top:2,bottom: 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
          /*  borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(12),
              bottomLeft: Radius.circular(12),
            ),*/
          //  color: Colors.white,
           /* boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                blurRadius: 3,
                offset: const Offset(0, 2),
              ),
            ],*/
          ),
          scrollbarTheme: ScrollbarThemeData(
            radius: const Radius.circular(40),
            thickness: WidgetStateProperty.all(6),
            thumbVisibility: WidgetStateProperty.all(true),
          ),
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 35,
          padding: EdgeInsets.only(left: 14, right: 14),
        ),
        iconStyleData: IconStyleData(
          icon: SizedBox(
            child: Padding(
              padding: const EdgeInsets.only(right: 12,top: 14,bottom: 14),
              child: Transform.rotate(
                  angle: isDropdownOpened?3.1416:0.0,
                  child: Image.asset('assets/downicon.png',height: 15,width: 15,)),
            ),
          ),
        ),
      ),
    );
  }
}
