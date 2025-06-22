import 'package:flutter/material.dart';

class TrackAndBillingSection extends StatelessWidget {
  final VoidCallback onTrackTap;
  final VoidCallback onBillingTap;
  final Widget Function(String text, {double? fontSize, FontWeight? fontWeight}) mediumText14;
  final Widget Function(String text, {double? fontSize}) smallText12;
  final Widget Function({required BuildContext context, required String labelText, required double width, required double height, required double fontSize, required FontWeight fontWeight, required double borderRadiusValue, required VoidCallback onTap}) brownButton;
  final Widget Function({double height}) verticalSpace;

  const TrackAndBillingSection({
    super.key,
    required this.onTrackTap,
    required this.onBillingTap,
    required this.mediumText14,
    required this.smallText12,
    required this.brownButton,
    required this.verticalSpace,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Track
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2))],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.asset('assets/trackimg.png', height: 20, width: 20),
                      const SizedBox(width: 8),
                      mediumText14("Track Request", fontSize: 14, fontWeight: FontWeight.w500),
                    ],
                  ),
                  const SizedBox(height: 8),
                  smallText12("Monitor the status of your requests in real-time", fontSize: 10),
                  verticalSpace(height: 18),
                  brownButton(
                    context: context,
                    labelText: 'Track',
                    width: 80,
                    height: 28,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    borderRadiusValue: 54,
                    onTap: onTrackTap,
                  ),
                ],
              ),
            ),
          ),
        ),

        const SizedBox(width: 8),

        // Billing
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2))],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.asset('assets/billingimg.png', height: 20, width: 20),
                      const SizedBox(width: 8),
                      mediumText14("Billing", fontSize: 14, fontWeight: FontWeight.w500),
                    ],
                  ),
                  const SizedBox(height: 8),
                  smallText12("View and manage billing information and invoices.", fontSize: 10),
                  verticalSpace(height: 18),
                  brownButton(
                    context: context,
                    labelText: 'Track',
                    width: 80,
                    height: 28,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    borderRadiusValue: 54,
                    onTap: onBillingTap,
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
