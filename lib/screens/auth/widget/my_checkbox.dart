
import 'package:bucket_list_flutter/utils/resources/resource_imports.dart';
import 'package:easy_localization/easy_localization.dart';

class MyCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;
  final String? textDsc;
  final FontWeight? fontWeight;


  const MyCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    this.textDsc,
    this.fontWeight,
  });



  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: 20,width: 20,
          child: Checkbox(
            activeColor: textClr,
            value: value,
            onChanged: onChanged,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap, // 👈 This reduces the default padding
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.0),
            ),
            side: WidgetStateBorderSide.resolveWith(
                  (states) => const BorderSide(
                  width: 1.0, color: buttonColor),
            ),
          ),
        ),
        SizedBox(width: 10),
        mediumText14(
          context, (textDsc ?? '').tr(), // ✅ Correct usage
          fontWeight: fontWeight??FontWeight.w400,
          fontSize: 14,
          textColor: textClr,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
