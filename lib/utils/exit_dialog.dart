import 'package:bucket_list_flutter/utils/resources/resource_imports.dart';
import 'package:flutter/services.dart';

class ExitConfirmationDialog extends StatelessWidget {
  const ExitConfirmationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: largeText16(context, 'Bucket App', fontSize: 20, fontWeight: FontWeight.bold),
      content: mediumText14(context, 'Do you want to exit the app?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: largeText16(context, "No", fontWeight: FontWeight.w600),
        ),
        TextButton(
          onPressed: () => SystemNavigator.pop(),
          child: largeText16(context, "Yes", textColor: Colors.red, fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}
