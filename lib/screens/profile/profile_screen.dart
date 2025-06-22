
import 'package:bucket_list_flutter/model/get_profile_response.dart';
import 'package:bucket_list_flutter/screens/auth/logout_delete_bottom.dart';
import 'package:bucket_list_flutter/screens/profile/edit_profile.dart';
import 'package:bucket_list_flutter/screens/profile/faq.dart';
import 'package:bucket_list_flutter/screens/profile/help_and_support.dart';
import 'package:bucket_list_flutter/screens/profile/termscondition.dart';
import 'package:bucket_list_flutter/utils/resources/resource_imports.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool showLoader = true;
  GetProfileResponse getProfileResponse = GetProfileResponse();
  @override
  void initState() {
    _getProfileApi();
    super.initState();
  }

  Future<void> _getProfileApi() async {
    await BlocProvider.of<BucketListCubit>(context).getProfileCall();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundclr,
      body: BlocConsumer<BucketListCubit,BucketListState>(
        listener: (context,state){
          print("state.status:${state.status}");
          if (state.status == BucketListStatus.getProfileSuccess){
            showLoader = false;
            getProfileResponse = state.responseData?.response as GetProfileResponse;
          }
        },
        builder: (context,state){
          if (state.status == BucketListStatus.getProfileLoading || showLoader) return AppLoader();
          if (state.status == BucketListStatus.getProfileError) {
            return CustomErrorWidget(
              errorMessage: state.errorData?.message ?? state.error,
              statusCode: state.errorData?.code,
              onRetry: _getProfileApi,
              onRefresh: _getProfileApi,
            );
          }
          return RefreshIndicator(
            onRefresh: _getProfileApi,
            child: SingleChildScrollView(
              child: SafeArea(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left:18,right: 18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        UiHelper.verticalSpace(height: screenHeight * 0.06),
                        MyInkWell(
                          onTap: () async {
                            final result = await Navigator.push(context, MaterialPageRoute(builder:
                                (context) => EditProfile(getProfileResponse: getProfileResponse),),);
                            print('result123:$result');
                            print('Updated Profile: ${jsonEncode(result.toJson())}');
                            // If user saved changes
                            if (result != null) {
                              setState(() {
                                getProfileResponse.data?.user?.image = result.image;
                                getProfileResponse.data?.user?.name = result.name;
                                getProfileResponse.data?.user?.companyName = result.companyName;
                                getProfileResponse.data?.user?.position = result.position;
                                getProfileResponse.data?.user?.email = result.email;
                                getProfileResponse.data?.user?.phone = result.phone;
                              });
                            }
                          },
                          child: Stack(
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: 8),
                                  child: ClipOval(child:
                                  cachedImageWidget(
                                      image:"$BASEURL/${getProfileResponse.data?.user?.image??''}",
                                      hasProfileImg:true,
                                      borderRadiusValue:50,
                                      height: 80,width: 80))),
                              Positioned(
                                  right: 0,
                                  bottom: 6,
                                  child: Image.asset('assets/edit.png',height: 25,width: 25,))
                            ],
                          ),
                        ),
                        UiHelper.verticalSpace(height:6),
                        mediumText14(context,capsFirstChar(getProfileResponse.data?.user?.name??''), fontWeight: FontWeight.w600,),
                        UiHelper.verticalSpace(height: screenHeight * 0.06),
                        _buildOptionItem(
                          onTap: () async {
                            final result = await Navigator.push(context, MaterialPageRoute(builder:
                                (context) => EditProfile(getProfileResponse: getProfileResponse),),);
                            print('result123:$result');
                            print('Updated Profile: ${jsonEncode(result.toJson())}');
                            // If user saved changes
                            if (result != null) {
                              setState(() {
                                getProfileResponse.data?.user?.image = result.image;
                                getProfileResponse.data?.user?.name = result.name;
                                getProfileResponse.data?.user?.companyName = result.companyName;
                                getProfileResponse.data?.user?.position = result.position;
                                getProfileResponse.data?.user?.email = result.email;
                                getProfileResponse.data?.user?.phone = result.phone;
                              });
                            }
                          },
                          iconPath: 'assets/edituser.png',
                          label: "Profile Management",
                        ),
                        _buildOptionItem(
                          onTap: () {
                            CustomNavigator.push(context: context, screen: TermsCondition(title: "Terms and Conditions"));
                          },
                          iconPath: 'assets/termsimg.png',
                          label: "Terms and Conditions",
                        ),
                        _buildOptionItem(
                          onTap: () {
                            CustomNavigator.push(context: context, screen: TermsCondition(title: "Privacy Policy"));
                          },
                          iconPath: 'assets/privacyimg.png',
                          label: "Privacy Policy",
                        ),
                        _buildOptionItem(
                          onTap: () {
                            CustomNavigator.push(context: context, screen: Faq());
                          },
                          iconPath: 'assets/faq.png',
                          label: "FAQs",
                        ),
                        _buildOptionItem(
                          onTap: () { CustomNavigator.push(context: context, screen: HelpAndSupport());},
                          iconPath: 'assets/helpimg.png',
                          label: "Help & Support",
                        ),
                        _buildOptionItem(
                          onTap: ()async {
                            final result = await showModalBottomSheet(
                              isScrollControlled: true,
                              useRootNavigator: true,
                              context: context,
                              builder: (context) => const LogoutDeleteBottom(fromMenu:'logout'),
                            );
                            if (result != null) {
                              setState(() {
                              });
                              //      Navigator.pop(context); // Close the bottom sheet
                            }
                          },
                          iconPath: 'assets/logoutimg.png',
                          label: "Logout",
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
  // Method to build the options in profile menu
  Widget _buildOptionItem({
    required Function() onTap,
    required String iconPath,
    required String label,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.only(left: 12,right: 12),
        margin: EdgeInsets.only(bottom: 14),
        height: 5.2.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color:Colors.black.withOpacity(0.15),
              offset: const Offset(1, 2),     // X: 1, Y: 2
              blurRadius: 3,                  // Blur: 5
              spreadRadius: 0,                // Spread: 0
            ),
          ],
        ),
        child: Row(
          children: [
            Image.asset(iconPath, height: 10.h, width: 20,),
            UiHelper.horizontalSpace(width: 8),
            smallText12(context, label, fontWeight: FontWeight.w500,)
          ],
        ),
      ),
    );
  }
}

