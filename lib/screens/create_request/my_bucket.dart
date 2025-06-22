import 'package:bucket_list_flutter/model/create_request_response.dart';
import 'package:bucket_list_flutter/screens/bottom_nav_bar/bottom_nav_bar_convex.dart';
import 'package:bucket_list_flutter/screens/create_request/success_created_dialog.dart';
import 'package:bucket_list_flutter/utils/resources/resource_imports.dart';
import 'package:bucket_list_flutter/model/get_all_bucket_response.dart' as dfrAllBucket;

class MyBucket extends StatefulWidget {
  final Map<String, dynamic> updatedRequestDetails;
  const MyBucket({super.key, required this.updatedRequestDetails});

  @override
  State<MyBucket> createState() => _MyBucketState();
}

class _MyBucketState extends State<MyBucket> {
  @override
  Widget build(BuildContext context) {
    final List<dfrAllBucket.Data> selectedBuckets =
    (widget.updatedRequestDetails["bucketInfo"] as List<dynamic>).cast<dfrAllBucket.Data>();
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, selectedBuckets); // Pass back updated list
        return false;
      },
      child: Scaffold(
        backgroundColor: backgroundclr,
        appBar: CustomAppBar(title: 'My Bucket',
          onBackPressed: (){ Navigator.pop(context, selectedBuckets);},),
        body: BlocConsumer<BucketListCubit,BucketListState>(
          listener: (context,state){
            print("state.status:${state.status}");
            if (state.status == BucketListStatus.createRequestSuccess){
              CreateRequestResponse createRequestResponse = state.responseData?.response as CreateRequestResponse;
              UiHelper.toastMessage(createRequestResponse.message??'');
              showDialog(
                context: context,
                barrierDismissible : false,
                builder: (context) => SuccessCreatedDialog(),
              );
            }
            if(state.status == BucketListStatus.createRequestError){
              UiHelper.toastMessage(state.errorData?.message ?? state.error ?? "");
            }
          },
          builder: (context,state){
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 18,right: 18),
                      child: Column(
                        children: [
                          smallText12(context, 'Here is your bucket list. You can add a new client or modify an existing one from this screen. Please review all details carefully before submitting.'),
                          UiHelper.verticalSpace(height: 20),
                          ListView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: selectedBuckets.length,
                            itemBuilder: (context, index) {
                              final bucket = selectedBuckets[index];
                              final bucketColor = parseApiColor(bucket.color);
                              return Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(left:16,right: 16,top: 10,bottom: 10),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.15),
                                          offset: const Offset(1, 2),
                                          blurRadius: 5,
                                        )
                                      ],
                                    ),
                                    child: Row(
                                      children: [
                                        Image.asset('assets/bucket.png', height: 50, width: 50, color: bucketColor),
                                        UiHelper.horizontalSpace(width: 8),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              mediumText14(context, capsFirstChar(bucket.name ?? ''),
                                                  fontWeight: FontWeight.w500, fontSize: 12, textColor: const Color(0xff404040)),
                                              UiHelper.verticalSpace(height: 5),
                                              smallText12(context, capsFirstChar(bucket.description ?? ''),
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 10,
                                                  textColor: const Color(0xff404040),
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis),
                                            ],
                                          ),
                                        ),
                                        UiHelper.horizontalSpace(width: 8),
                                        MyInkWell(
                                            onTap: ()async {
                                              setState(() {
                                                selectedBuckets.removeAt(index);
                                              });
                                            },
                                            child: Image.asset('assets/deleteimg.png',height: 20,width: 20,)),
                                      ],
                                    ),
                                  ),
                                  UiHelper.verticalSpace(height: 16),
                                ],
                              );
                            },
                          ),
                          UiHelper.verticalSpace(height: 16),
                          selectedBuckets.isEmpty?
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(height:screenHeight*0.2),
                              largeText16(context, 'There is no bucket added'),
                              const SizedBox(height: 32,),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: brownButton(context: context, labelText: 'Add Bucket',
                                  onTap: (){
                                    Navigator.pop(context, selectedBuckets); // Pass back updated list
                                  },
                                ),
                              ),
                            ],
                          ):
                          const SizedBox(),
                        ],
                      ),
                    ),
                  ),
                ),
                selectedBuckets.isEmpty?const SizedBox():
                Padding(
                  padding: const EdgeInsets.only(top:20,bottom:80,left: 28,right: 28),
                  child:
                  brownButton(context: context, labelText: 'Submit',
                      isLoading: state.status == BucketListStatus.createRequestLoading,
                      onTap: (){
                        print("updatedRequestDetails:${widget.updatedRequestDetails}");
                        // Make a copy to avoid mutating the original
                        final updatedBucketDetails = Map<String, dynamic>.from(widget.updatedRequestDetails);

                        // Set bucketInfo as list of string IDs
                        updatedBucketDetails['bucketInfo'] = selectedBuckets.map((b) => b.id.toString()).toList();

                        print("updatedRequestDetails: $updatedBucketDetails");
                        BlocProvider.of<BucketListCubit>(context).createRequestCall(updatedBucketDetails);
                      }
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
