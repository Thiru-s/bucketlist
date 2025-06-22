import 'package:bucket_list_flutter/utils/resources/resource_imports.dart';
import 'package:flutter/material.dart';

class CustomSearchField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final Color? borderColor;
  final Color? fieldColor;
  final bool? showBoxShadow;

  const CustomSearchField({
    super.key,
    required this.hintText,
    required this.controller,
    this.onChanged,
    this.borderColor,
    this.fieldColor = Colors.white,
    this.showBoxShadow = true,

  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      decoration: BoxDecoration(
        color: fieldColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all( // 👈 Add this line
          color:borderColor??Colors.transparent,
          width: 0.8,         // Optional: customize thickness
        ),
        boxShadow: [
          if (showBoxShadow ?? true)
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            offset: Offset(1, 2),
            blurRadius: 5,
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        onChanged: onChanged,
        cursorColor: Colors.grey,
        maxLength: 50,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Icon(Icons.search, color: Colors.black),
          ),
          border: InputBorder.none,
          hintStyle: TextStyle(
            fontFamily: "Poppins",
            color: textClr, // or your textClr
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 11, horizontal: 16),
          counterText: "",
        ),
        style: TextStyle(
          fontFamily: "Poppins",
          color: textClr, // or your textClr
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
