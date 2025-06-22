import 'package:bucket_list_flutter/model/forgot_password_response.dart';
import 'package:bucket_list_flutter/screens/auth/otp_verification.dart';
import 'package:bucket_list_flutter/utils/app_widgets.dart';
import 'package:bucket_list_flutter/utils/resources/resource_imports.dart';
import 'package:bucket_list_flutter/utils/textfield_validator.dart';
import 'package:flutter/services.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    //emailController.text = "thiru@yopmail.com";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: backgroundclr,
      body: BlocConsumer<BucketListCubit,BucketListState>(
        listener: (context,state){
          if (state.status == BucketListStatus.forgotPasswordSuccess){
            ForgotPasswordResponse forgotPasswordResponse = state.responseData?.response as ForgotPasswordResponse;
            UiHelper.toastMessage(forgotPasswordResponse.message??'');
            emailController.clear();
            CustomNavigator.push(
                context: context,
                screen: OtpVerification(fromPage:'ForgotPassword',
                    tmpToken:forgotPasswordResponse.data?.accessToken??'',
                    tmpOtp:forgotPasswordResponse.data?.otp??'',),);
          }
          else if (state.status == BucketListStatus.forgotPasswordError){
            print(state.errorData?.message);
            String message = state.errorData?.message ?? state.error ?? "";
            UiHelper.toastMessage(message);
          }
        },
        builder: (context,state){
          return SingleChildScrollView(
            child:Form(  // <--- Wrap your form here
              key: _formKey, // <-- Assign the key
              child: Padding(
                padding: const EdgeInsets.only(left: 18,right: 18,top: 75),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MyInkWell(
                            onTap:()async{
                              Navigator.of(context).pop();
                            },
                            child: Image.asset( 'assets/backarrow.png',height: 38,width: 38,)),
                        Padding(
                          padding: const EdgeInsets.only(right: 40),
                          child: Center(child: Image.asset(AppAssets.bucketLogo,height: 102.94,width:  102.94,)),
                        ),
                        const SizedBox(),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 18,right: 18),
                      child: Column(
                        children: [
                          UiHelper.verticalSpace(height: screenHeight * 0.06),
                          largeText16(context, 'Forgot Password',fontWeight: FontWeight.w500,fontSize: 26,),
                          UiHelper.verticalSpace(height: screenHeight * 0.01),
                          mediumTextLoc14(context, 'pl_enter_your_email',fontWeight: FontWeight.w300,),
                          UiHelper.verticalSpace(height: screenHeight * 0.12),
                          AppWidgets.commonTextField(
                            onTap: () => {},
                            onChanged: (value) {},
                            inputMaxLine: 1,
                            bgColor: Colors.transparent,
                            inputHintText: 'Email',
                            inputController:emailController,
                            textCapitalization: TextCapitalization.none,
                            validator: (value) {
                              return AppValidator.validatorEmail!(value);
                            },
                          ),
                          UiHelper.verticalSpace(height: screenHeight * 0.2),
                          brownButton(context: context,
                              labelText: 'send_otp',width: 300,
                              isLoading: state.status == BucketListStatus.forgotPasswordLoading,
                              onTap: (){
                                 if (_formKey.currentState?.validate() ?? false) {
                                   String input = emailController.text.trim();
                                   // Proceed with API call if either email or phone number is valid
                                   BlocProvider.of<BucketListCubit>(context).forgotPasswordCall(input);
                                  }
                              }
                          ),
                        ],
                      ),
                    ),



                    UiHelper.verticalSpace(height: screenHeight * 0.1),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}