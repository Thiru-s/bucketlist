import 'package:bucket_list_flutter/screens/create_request/success_created_dialog.dart';
import 'package:bucket_list_flutter/utils/exit_dialog.dart';
import 'package:bucket_list_flutter/utils/resources/resource_imports.dart';

class TrackAndBillingSection extends StatefulWidget {
  final TabController controller;
  const TrackAndBillingSection({super.key,required this.controller});

  @override
  State<TrackAndBillingSection> createState() => _TrackAndBillingSectionState();
}

class _TrackAndBillingSectionState extends State<TrackAndBillingSection> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/trackimg.png',height: 20,width: 20,
                        //   height: 2.h,
                      ),
                      const SizedBox(width: 8),
                      mediumText14(context, "Track Request",fontSize: 14,fontWeight: FontWeight.w500),
                    ],
                  ),
                  const SizedBox(height: 8),
                  smallText12(context, "Monitor the status of your requests in real-time",fontSize: 10),
                  UiHelper.verticalSpace(height: 18),
                  brownButton(context: context, labelText: 'Track',width: 80,height: 28,fontSize: 12,fontWeight: FontWeight.w400,borderRadiusValue: 54,
                    onTap: () {
                      widget.controller.animateTo(1); // Switch to Home tab
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/billingimg.png',height: 20,width: 20,
                        //   height: 2.h,
                      ),
                      const SizedBox(width: 8),
                      mediumText14(context, "Billing",fontSize: 14,fontWeight: FontWeight.w500),
                    ],
                  ),
                  const SizedBox(height: 8),
                  smallText12(context, "View and manage billing information and invoices.",fontSize: 10),
                  UiHelper.verticalSpace(height: 18),
                  brownButton(context: context, labelText: 'View Billing',width: 116,height: 28,fontSize: 12,fontWeight: FontWeight.w400,borderRadiusValue: 54,
                    onTap: () {
                      widget.controller.animateTo(2); // Switch to Home tab
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
