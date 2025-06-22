import 'package:bucket_list_flutter/model/get_notification_response.dart';
import 'package:bucket_list_flutter/screens/reusable_widgets/custom_readmore.dart';
import 'package:bucket_list_flutter/screens/reusable_widgets/empty_list_found.dart';
import 'package:bucket_list_flutter/screens/reusable_widgets/time_rule.dart';
import 'package:bucket_list_flutter/utils/resources/resource_imports.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {

  GetNotificationResponse getNotificationResponse = GetNotificationResponse();
  List<Data> notificationData = [];
  @override
  void initState() {
    _getNotificationApi();
    super.initState();
  }

  Future<void> _getNotificationApi() async {
    await BlocProvider.of<BucketListCubit>(context).notificationListCall();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundclr,
      body: BlocConsumer<BucketListCubit,BucketListState>(
        listener: (context,state){
          print("state.status:${state.status}");
          if (state.status == BucketListStatus.notificationListSuccess){
            getNotificationResponse = state.responseData?.response as GetNotificationResponse;
            notificationData = getNotificationResponse.data ?? [];
          }
          if (state.status == BucketListStatus.deleteAllNotificationSuccess){
            UiHelper.toastMessage(state.responseData?.response ?? '');
            notificationData.clear();
            getNotificationResponse.data = [];
          }
          if (state.status == BucketListStatus.notificationListError){
            UiHelper.toastMessage(state.errorData?.message ?? state.error ?? "");
          }
        },
        builder: (context,state){
          if (state.status == BucketListStatus.notificationListLoading) {return  AppLoader();}
          if (state.status == BucketListStatus.notificationListError) {
            return CustomErrorWidget(
              errorMessage: state.errorData?.message ?? state.error,
              statusCode: state.errorData?.code,
              onRetry: _getNotificationApi,
              onRefresh: _getNotificationApi,
            );
          }

          final isLoading = state.status == BucketListStatus.notificationListLoading ||
              state.status == BucketListStatus.deleteAllNotificationLoading;
          return Stack(
            children: [
              SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.only(top: 72,left: 20,right: 20,bottom: 50),
                  child: Column(
                    children: [
                      Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(),
                          Padding(
                            padding: EdgeInsets.only(left: notificationData.isNotEmpty?22:0),
                            child: mediumText14(context, 'Notification',textColor:textClr1,fontSize:16,fontWeight: FontWeight.w500),
                          ),
                          notificationData.isNotEmpty?MyInkWell(
                              onTap: ()async{
                                BlocProvider.of<BucketListCubit>(context).deleteAllNotificationCall();
                               // loader(context);
                              },
                              child: smallText12(context, 'Clear All',fontWeight: FontWeight.w600)):
                          const SizedBox(),
                        ],
                      ),
                      UiHelper.verticalSpace(height: 28),
                      getNotificationResponse.data!.isEmpty?EmptyListFound(message:'There is no notification'):
                      ListView.builder(
                        padding: EdgeInsets.only(left: 0.5,right: 0.5),
                     //   itemCount: getNotificationResponse.data?.length,
                        itemCount: notificationData.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                        //  final notificationData = getNotificationResponse.data![index];
                          final notificationListData = notificationData[index];
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MyInkWell(
                                onTap: () async {
                                  //   CustomNavigator.push(context: context, screen: TrackingDetails());
                                },
                                child: Container(
                                  width:double.infinity,
                                  padding: const EdgeInsets.only(left:14,right:14,top:10,bottom:14),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                    BorderRadius.circular(12.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color:Colors.black.withOpacity(0.15),
                                        offset: const Offset(1, 2),     // X: 1, Y: 2
                                        blurRadius: 5,                  // Blur: 5
                                        spreadRadius: 0,                // Spread: 0
                                      ),
                                    ],
                                  ),
                                  child:   Stack(
                                    children: [
                                      Column(  crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          UiHelper.verticalSpace(height: 4),
                                          smallText12(context, capsFirstChar(notificationListData.title??''),textColor:Color(0xff222222),maxLines: 1,overflow: TextOverflow.ellipsis),
                                          UiHelper.verticalSpace(height: 3),
                                          ExpandableText(
                                            text: capsFirstChar(notificationListData.description??''),
                                          ),
                                          UiHelper.verticalSpace(height: 7),
                                        ],
                                      ),
                                      Positioned(
                                        top:0,
                                        right: 2,
                                        child: smallText12(context,TimeRule.formatToDdMmmYy(notificationListData.updatedAt??''),textColor:Color(0xff222222),fontSize: 8),
                                      ),
                                      Positioned(
                                        bottom:0,
                                        right: 2,
                                        child: smallText12(context,TimeRule.formatTo12HourTime(notificationListData.updatedAt??''),textColor:Color(0xff222222),fontSize: 8),
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
              ),
              // Loading Spinner Overlay
              if (isLoading)
                Center(
                  child: TweenAnimationBuilder<Color?>(
                    tween: ColorTween(
                      begin: textClr, // Dark Brown for start
                      end: Colors.white, // White for end
                    ),
                    duration: Duration(seconds: 1),
                    builder: (context, color, child) {
                      return LoadingAnimationWidget.fourRotatingDots(
                        color: textClr, // Default to brown if color is null
                        size: 60, // Increased the size for better visibility
                      );
                    },
                  ),
                )
            ],
          );
        },
      ),
    );
  }
}
