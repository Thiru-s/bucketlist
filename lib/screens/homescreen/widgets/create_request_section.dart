import 'package:bucket_list_flutter/screens/create_request/create_request.dart';
import 'package:bucket_list_flutter/utils/resources/resource_imports.dart';

class CreateRequestSection extends StatelessWidget {
  const CreateRequestSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
                Image.asset('assets/requestimg.png', height: 20,width: 20,),
                const SizedBox(width: 8),
                mediumText14(context, "Create request/ Manage requests",fontWeight: FontWeight.w500),
              ],
            ),
            UiHelper.verticalSpace(height: 8),
            smallText12(context, 'Upload a bid proposal to be bid out or manage existing requests.'),
            UiHelper.verticalSpace(height: 18),
            brownButton(context: context, labelText: 'Create /Manage',width: 130,height: 27,fontSize: 12,fontWeight: FontWeight.w400,borderRadiusValue:54,
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder:
                  (context) => CreateRequest(),),);
               }
            ),
          ],
        ),
      ),
    );
  }
}
