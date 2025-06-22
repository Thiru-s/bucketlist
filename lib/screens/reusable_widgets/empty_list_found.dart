import 'package:bucket_list_flutter/utils/appcolor.dart';
import 'package:bucket_list_flutter/utils/custom_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class EmptyListFound extends StatelessWidget {
  final double topHeight;
  final String message;
  final double fontSize;
  final Color textColor;

  const EmptyListFound({
    super.key,
    this.topHeight = 150,
    this.message = 'There is no suggestion list',
    this.fontSize = 18,
    this.textColor = appBlackColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(

      children: [
        SizedBox(height: topHeight,),
        SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              Center(
                child: mediumText14(context, message, fontSize: fontSize,textColor: textColor,textAlign: TextAlign.center),
              ),
            ],
          ),
        ),
      ],
    );
  }
}


class EmptyListFollowing extends StatelessWidget {
  final double topPadding;
  final String message;
  final double fontSize;
  final Color textColor;

  const EmptyListFollowing({
    super.key,
    this.topPadding = 150,
    this.message = 'There is no suggestion list',
    this.fontSize = 18,
    this.textColor = appBlackColor,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.only(top: topPadding),
        child: Center(
          child: mediumText14(context, message, fontSize: fontSize,textColor: textColor,textAlign: TextAlign.center),
        ),
      ),
    );
  }
}