import 'package:bucket_list_flutter/utils/appcolor.dart';
import 'package:bucket_list_flutter/utils/custom_widgets.dart';
import 'package:flutter/material.dart';

class BucketColorReuse extends StatelessWidget {
  final String label;
  final Color? dotColor;
  final bool isSelected;
  const BucketColorReuse({
    super.key,
    required this.label,
    this.dotColor,
    this.isSelected = false,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
     // margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isSelected ? dotColor ?? Colors.transparent : Colors.transparent,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            spreadRadius: 0,
            offset: Offset(1, 2),
          )
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          dotColor==null?const SizedBox():
          CircleAvatar(
            radius: 6,
            backgroundColor: dotColor,
          ),
          const SizedBox(width: 6),
          smallText12(context, label,
            textColor: isSelected ? dotColor ?? textClr : textClr,
          ),
        ],
      ),
    );
  }
}

