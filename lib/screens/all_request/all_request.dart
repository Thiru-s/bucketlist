import 'package:bucket_list_flutter/screens/homescreen/homescreen.dart';
import 'package:bucket_list_flutter/utils/resources/resource_imports.dart';

import 'package:bucket_list_flutter/model/get_all_request_response.dart';
import 'package:bucket_list_flutter/screens/create_request/create_request.dart';
import 'package:bucket_list_flutter/screens/homescreen/tracking_details.dart';
import 'package:bucket_list_flutter/screens/reusable_widgets/empty_list_found.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
class AllRequest extends StatefulWidget {
  final TabController controller;
  const AllRequest({super.key,required this.controller});

  @override
  State<AllRequest> createState() => _AllRequestState();
}

class _AllRequestState extends State<AllRequest> {
  bool showLoader = true;
  GetAllRequestResponse getAllRequestResponse = GetAllRequestResponse();
  @override
  void initState() {
    _getAllRequestApi();
    super.initState();
  }

  Future<void> _getAllRequestApi() async {
    await BlocProvider.of<BucketListCubit>(context).getAllRequestCall();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundclr,
      body: SafeArea(
        child: BlocConsumer<BucketListCubit,BucketListState>(
          listener: (context,state){
            print("state.status:${state.status}");
            if (state.status == BucketListStatus.getAllRequestSuccess){
              showLoader = false;
              getAllRequestResponse = state.responseData?.response as GetAllRequestResponse;
              // allBuckets = getAllBucketResponse.data ?? [];
            }
            if (state.status == BucketListStatus.getAllRequestError){
              UiHelper.toastMessage(state.errorData?.message ?? state.error ?? "");
              Loader.hide();
            }
          },
          builder: (context,state){
            if (state.status == BucketListStatus.getAllRequestLoading || showLoader) return AppLoader();
            if (state.status == BucketListStatus.getAllRequestError) {
              return CustomErrorWidget(
                errorMessage: state.errorData?.message ?? state.error,
                statusCode: state.errorData?.code,
                onRetry: _getAllRequestApi,
                onRefresh: _getAllRequestApi,
              );
            }
            return RefreshIndicator(
              color:textClr,
              onRefresh: _getAllRequestApi,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.only(top: 38,left: 20,right: 20,bottom: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildHeader(context),
                    UiHelper.verticalSpace(height: 26),
                    getAllRequestResponse.data!.isEmpty?EmptyListFound(message:"There is no request created",topHeight: 80,):
                    ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: getAllRequestResponse.data?.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        final requestData = getAllRequestResponse.data![index];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MyInkWell(
                              onTap: () async {
                                CustomNavigator.push(context: context, screen: TrackingDetails(requestPartData:requestData));
                              },
                              child: Container(
                                padding: const EdgeInsets.all(14.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                  BorderRadius.circular(12.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color:Colors.black.withOpacity(0.25),
                                      offset: const Offset(1, 2),     // X: 1, Y: 2
                                      blurRadius: 5,                  // Blur: 5
                                      spreadRadius: 0,                // Spread: 0
                                    ),
                                  ],
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.asset('assets/metalbucket.png', height: 30,width: 30,),
                                    UiHelper.horizontalSpace(width: 8),
                                    Expanded(
                                      flex: 4,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          smallText12(context,"Company Name",fontWeight: FontWeight.w500,fontSize:12),
                                          UiHelper.verticalSpace(height: 6),
                                          smallText12(context,"Request ID",fontWeight: FontWeight.w500,fontSize:10),
                                          UiHelper.verticalSpace(height: 4),
                                          smallText12(context,"Status",fontWeight: FontWeight.w500,fontSize:10),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        smallText12(context,"-",fontWeight: FontWeight.w500,fontSize:12),
                                        UiHelper.verticalSpace(height: 8),
                                        smallText12(context,"-",fontWeight: FontWeight.w500,fontSize:10),
                                        UiHelper.verticalSpace(height: 4),
                                        smallText12(context,"-",fontWeight: FontWeight.w500,fontSize:10),
                                      ],
                                    ),
                                    UiHelper.horizontalSpace(width: 18),
                                    Expanded(
                                      flex: 6,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          smallText12(context,capsFirstChar(requestData.companyName??''),fontWeight: FontWeight.w500,fontSize:12,maxLines: 1,overflow: TextOverflow.ellipsis),
                                          UiHelper.verticalSpace(height: 8),
                                          smallText12(context,requestData.requestId??'',fontWeight: FontWeight.w500,fontSize:10),
                                          UiHelper.verticalSpace(height: 4),
                                          smallText12(context,requestData.isStatus??'',fontWeight: FontWeight.w500,fontSize:10),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 12,)
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: FloatingActionButton(
          elevation: 0,
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder:
                (context) => CreateRequest(),),);
          },
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
              side: const BorderSide(color: Colors.black, width: 5)),
          backgroundColor: Colors.white,
          child: Icon(Icons.add, size: 45, color: btnclr),
        ),
      ),
    );
  }
}