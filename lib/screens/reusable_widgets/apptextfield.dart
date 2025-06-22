
import 'package:bucket_list_flutter/utils/resources/resource_imports.dart';
import 'package:flutter/services.dart';



class LabeledTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController? controller;
  final bool? readOnly;
  final bool isEnabled;
  final int maxLines;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  final int? inputMaxLine;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool? obscureText;
  final Color? borderColor;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final TextCapitalization textCapitalization;
  final EdgeInsets contentPadding;
  final void Function()? onTap;
  final void Function(String)? onChanged;

  const LabeledTextField({
    super.key,
    required this.label,
    this.hintText = '',
    this.controller,
    this.readOnly = false,
    this.isEnabled = true,
    this.maxLines = 1,
    this.textInputAction,
    this.validator,
    this.focusNode,
    this.inputMaxLine,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText,
    this.borderColor,
    this.keyboardType,
    this.inputFormatters,
    this.maxLength,
    this.textCapitalization = TextCapitalization.words,
    this.contentPadding = const EdgeInsets.only(top: 12.5, bottom: 12.5, left: 20, right: 20),
    this.onTap,
    this.onChanged
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: smallText12(context, label),
        ),
        UiHelper.verticalSpace(height: 6),
        TextFormField(
          controller: controller,
          readOnly: readOnly??false,
          enabled: isEnabled,
          textCapitalization: textCapitalization,
          textInputAction: textInputAction ??
              (keyboardType == TextInputType.multiline ? TextInputAction.newline : TextInputAction.next),
          cursorColor: Colors.grey,
          validator: validator,
          onTap: onTap,
          onChanged: onChanged,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          maxLines: inputMaxLine,
          maxLength: maxLength??50,
          style:TextStyle(fontSize: 14, fontWeight: FontWeight.w400, fontFamily: "Poppins",
              color: textClr) ,
          inputFormatters: [
            ...?inputFormatters,
            NoLeadingSpaceFormatter(),
            FilteringTextInputFormatter.deny(RegExp(r"\s{2,}")),
          ],
          keyboardType: keyboardType ??
              (inputMaxLine != null && inputMaxLine! > 1
                  ? TextInputType.multiline
                  : TextInputType.text),
          decoration: InputDecoration(
              isDense: true,
              suffixIcon: suffixIcon,
              suffixIconConstraints: BoxConstraints(
                minHeight: 20,
                minWidth: 20,
              ),
              prefixIcon: prefixIcon,
              filled: true,
              fillColor:readOnly==true?Colors.grey.shade100: Colors.white,
             // contentPadding: EdgeInsets.only(top: 13, bottom: 13, left: 20, right: 20),
              contentPadding: contentPadding,
              hintText: hintText,
              hintStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, fontFamily: "Poppins",
                  color: Color(0xffc8c8c8)),
              errorMaxLines: 3, // 👈 ADD THIS LINE
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: borderColor ?? Colors.grey.shade400,width: 0.2),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius:
                BorderRadius.circular(10),
                borderSide: BorderSide(color: borderColor ?? Colors.grey.shade400,width: 0.2),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius:
                BorderRadius.circular(10),
                borderSide: BorderSide(color: borderColor ?? Colors.grey.shade400,width: 0.2),
              ),
              counterText: ""
          ),
        ),
      ],
    );
  }
}



class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final bool? readOnly;
  final bool isEnabled;
  final int maxLines;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  final int? inputMaxLine;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool? obscureText;
  final Color? borderColor;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final TextCapitalization textCapitalization;
  final EdgeInsets contentPadding;
  final void Function()? onTap;
  final void Function(String)? onChanged;
  const CustomTextFormField({
    super.key,
    this.hintText = '',
    this.controller,
    this.readOnly = false,
    this.isEnabled = true,
    this.maxLines = 1,
    this.textInputAction,
    this.validator,
    this.focusNode,
    this.inputMaxLine,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText,
    this.borderColor,
    this.keyboardType,
    this.inputFormatters,
    this.maxLength,
    this.textCapitalization = TextCapitalization.words,
    this.contentPadding = const EdgeInsets.only(top: 12, bottom: 12, left: 20, right: 20),
    this.onTap,
    this.onChanged
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: readOnly??false,
      enabled: isEnabled,
      textCapitalization: textCapitalization,
      textInputAction: textInputAction ??
          (keyboardType == TextInputType.multiline ? TextInputAction.newline : TextInputAction.next),
      cursorColor: Colors.grey,
      validator: validator,
      onTap: onTap,
      onChanged: onChanged,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      maxLines: inputMaxLine,
      maxLength: maxLength??50,
      inputFormatters: [
        ...?inputFormatters,
        NoLeadingSpaceFormatter(),
        FilteringTextInputFormatter.deny(RegExp(r"\s{2,}")),
      ],
      keyboardType: keyboardType ??
          (inputMaxLine != null && inputMaxLine! > 1
              ? TextInputType.multiline
              : TextInputType.text),
      decoration: InputDecoration(
          isDense: true,
          suffixIcon: suffixIcon,
          suffixIconConstraints: BoxConstraints(
            minHeight: 20,
            minWidth: 20,
          ),
          prefixIcon: prefixIcon,
          filled: true,
          fillColor:readOnly==true?Colors.grey.shade100: Colors.white,
          // contentPadding: EdgeInsets.only(top: 13, bottom: 13, left: 20, right: 20),
          contentPadding: contentPadding,
          hintText: hintText,
          hintStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, fontFamily: "Poppins",
              color: textClr),
          errorMaxLines: 3, // 👈 ADD THIS LINE
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: borderColor ?? Colors.grey.shade400,width: 0.2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius:
            BorderRadius.circular(10),
            borderSide: BorderSide(color: borderColor ?? Colors.grey.shade400,width: 0.2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius:
            BorderRadius.circular(10),
            borderSide: BorderSide(color: borderColor ?? Colors.grey.shade400,width: 0.2),
          ),
          counterText: ""
      ),
    );
  }
}




