import 'package:bucket_list_flutter/utils/resources/resource_imports.dart';

class BucketInfoDialog extends StatelessWidget {
  final String name;
  final String category;
  final String price;
  final String clientName;
  final String clientCompanyName;
  final String description;
  final Color iconColor;
  final String iconAsset;

  const BucketInfoDialog({
    super.key,
    required this.name,
    required this.category,
    required this.price,
    required this.clientName,
    required this.clientCompanyName,
    required this.description,
    required this.iconColor,
    required this.iconAsset,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      elevation: 0,
      insetPadding: const EdgeInsets.all(22),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0),),
      titlePadding: const EdgeInsets.only(left: 16, right: 16, top: 24, bottom: 12),
      contentPadding: const EdgeInsets.only(top:20,bottom:20,left: 25, right: 25),
      alignment: Alignment.center,
      actionsOverflowButtonSpacing: 6.0,
      content: SizedBox(
        width: double.maxFinite,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const SizedBox(width: 8),
                  Image.asset(iconAsset, height: 50, width: 50, color: iconColor),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      mediumText14(context, capsFirstChar(name),fontWeight: FontWeight.w500,textColor: Color(0xff404040)),
                      const SizedBox(height: 4),
                      mediumText14(context, capsFirstChar(category),fontSize:10,fontWeight: FontWeight.w400,textColor: Color(0xff404040)),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 16),
              detailRow(context,"Price", price),
              detailRow(context,"Client Name", capsFirstChar(clientName)),
              detailRow(context,"Company Name", capsFirstChar(clientCompanyName)),
              const SizedBox(height: 20),
              largeText16(context, "Description",fontWeight: FontWeight.w500,textColor: Color(0xff404040)),
              const SizedBox(height: 8),
              smallText12(context, description,textColor: Color(0xff404040))
            ],
          ),
        ),
      ),
      actions: <Widget>[],
    );
  }
}
Widget detailRow(BuildContext context,String title, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        Expanded(
            flex: 5,
            child: mediumText14(context,title,fontWeight: FontWeight.w500, fontSize: 12)),
        mediumText14(context,'-',fontWeight: FontWeight.w500, fontSize: 12),
        UiHelper.horizontalSpace(width: 18),
        Expanded(
          flex: 9,
          child: Text(value,
              style: const TextStyle(
                  fontWeight: FontWeight.w400, fontSize: 13)),
        ),
      ],
    ),
  );
}