
import 'dart:async';


import 'package:bucket_list_flutter/main.dart';
import 'package:bucket_list_flutter/model/resend_verify_otp_response.dart';
import 'package:bucket_list_flutter/model/verify_otp_response.dart';
import 'package:bucket_list_flutter/screens/auth/reset_password.dart';
import 'package:bucket_list_flutter/screens/bottom_nav_bar/bottom_nav_bar_convex.dart';
import 'package:bucket_list_flutter/utils/AppContainer.dart';
import 'package:bucket_list_flutter/utils/appbar.dart';
import 'package:bucket_list_flutter/utils/resources/resource_imports.dart';
import 'package:bucket_list_flutter/utils/shared_preference.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:pin_code_fields/pin_code_fields.dart';


class OtpVerification extends StatefulWidget {
  final String fromPage;
  final String tmpToken;
  final String tmpOtp;

  const OtpVerification({super.key,required this.fromPage,  required this.tmpToken, required this.tmpOtp});


  @override
  State<OtpVerification> createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {


  int remainingTime = 30; // 5 minutes in seconds
 // late Timer countdownTimer;
  Timer? countdownTimer;
  bool isResendButtonEnabled = false;


  TextEditingController OTPController = TextEditingController();

  Duration duration = const Duration(seconds: 120);
  Timer? timer;
  bool isResendButtonVisible = false;
  String tmpOTP = "";
  String tmpToken = "";
/*  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (duration.inSeconds > 0) {
          duration = Duration(seconds: duration.inSeconds - 1);
        } else {
          timer.cancel();
          isResendButtonVisible = true;
        }
      });
    });
  }*/
  void startCountdown() {
    setState(() {
      isResendButtonEnabled = false;
      remainingTime = 30;
    });

    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return; // 👈 Prevents setState on disposed widget
      if (remainingTime > 0) {
        setState(() {
          remainingTime--;
        });
      } else {
        timer.cancel();
        setState(() {
          isResendButtonEnabled = true;
        });
      }
    });
  }
/*
  void resendOtp() {
    setState(() {
      duration = const Duration(seconds: 120);
      isResendButtonVisible = false;
    });
    startTimer();
    //  verificationCubit.resendOTP(context);
  }*/

  @override
  void initState() {
    tmpOTP = widget.tmpOtp;
    tmpToken = widget.tmpToken;
    startCountdown();
    super.initState();

  }

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    //  textEditingController.dispose();
    timer?.cancel();
    countdownTimer?.cancel(); // 👈 cancel this to prevent setState on disposed widget
  //  OTPController.dispose(); // Good practice
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Stack(
        children: [
          Scaffold(
            backgroundColor: backgroundclr,
            body: BlocConsumer<BucketListCubit,BucketListState>(
              listener: (context,state){
                if (state.status == BucketListStatus.registerVerifyOTPSuccess){
                  VerifyOtpResponse verifyOtpResponse = state.responseData?.response as VerifyOtpResponse;

               //   UiHelper.toastMessage(verifyOtpResponse.message??'');
                  if(widget.fromPage=="ForgotPassword"){
                    CustomNavigator.pushReplacement(context: context, screen: ResetPassword(tempToken:tmpToken));
                  }else{
                    setState(() {
                      loginValue = true;
                    });
                    PreferenceManager.insertValue(key: TOKEN, value: verifyOtpResponse.data?.accessToken.toString());
                    CustomNavigator.pushAndRemoveUntil(
                        context: context,
                        screen: BottomNavBarConvex());
                  }
                }
                if(state.status == BucketListStatus.resendVerifyOTPSuccess){
                  startCountdown();
                  ResendVerifyOtpResponse resendVerifyOtpResponse = state.responseData?.response as ResendVerifyOtpResponse;
                  tmpOTP = resendVerifyOtpResponse.data?.otp.toString()??'';
                  tmpToken = resendVerifyOtpResponse.data?.accessToken.toString()??'';
                  UiHelper.toastMessage(resendVerifyOtpResponse.message??'');
                }

                if(state.status == BucketListStatus.registerVerifyOTPError){
                  print(state.errorData?.message);
                  String message = state.errorData?.message ?? state.error ?? "";
                  UiHelper.toastMessage(message);
                }
              },
              builder: (context,state){
                return SingleChildScrollView(
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
                        UiHelper.verticalSpace(height: screenHeight * 0.05),
                        largeTextLoc16(context, 'verification_text',fontWeight: FontWeight.w500,fontSize: 26,),
                        UiHelper.verticalSpace(height: screenHeight * 0.01),
                        mediumTextLoc14(context, 'pls_enter_code',fontWeight: FontWeight.w300,),
                        UiHelper.verticalSpace(height: screenHeight * 0.01),
                        largeText16(context, "Temporary Received OTP is $tmpOTP",
                          fontWeight: FontWeight.w600,),
                        UiHelper.verticalSpace(height: screenHeight * 0.1),
                        Padding(
                          padding: const EdgeInsets.only(left: 25,right: 25),
                          child: PinCodeTextField(
                            controller : OTPController,
                            cursorColor: textClr,
                            appContext: context,
                            length: 4,
                            obscureText: false,
                            keyboardType: TextInputType.number,
                            animationType: AnimationType.fade,
                            pinTheme: PinTheme(
                              borderWidth: 1,
                              inactiveBorderWidth: 1,
                              selectedBorderWidth: 1,
                              activeBorderWidth: 1,
                              shape: PinCodeFieldShape.box,
                              borderRadius: BorderRadius.circular(10),
                              fieldHeight: 42,
                              fieldWidth:70,
                              activeFillColor: backgroundclr,
                              selectedFillColor: textClr.withOpacity(0.2),
                              inactiveFillColor: backgroundclr,
                              activeColor: textClr,
                              selectedColor: textClr,
                              inactiveColor: textClr,
                            ),
                            animationDuration: const Duration(milliseconds: 300),
                            backgroundColor: backgroundclr,
                            enableActiveFill: true,
                            // validator: (value) {
                            //   return AppValidator.validatorOTP!(value);
                            // },

                            onCompleted: (value) {

                          //    _otp = value ;
                            },
                            onChanged: (value) {
                           //   _otp = value ;
                              // context.read<VerificationCubit>().otp(value);
                            },
                            beforeTextPaste: (text) => true,
                          ),
                        ),
                        smallTextLoc12(context, 'dont_receive_code'),
                        UiHelper.verticalSpace(height: 8),


                        MyInkWell(
                          onTap:()async{
                            if (isResendButtonEnabled) {
                              BlocProvider.of<BucketListCubit>(context).resendVerifyOTPCall(tmpToken);
                              //       startCountdown();
                            }

                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              isResendButtonEnabled?
                              state.status==BucketListStatus.resendVerifyOTPLoading?
                              const SizedBox( height:20,width: 20,
                                child: CircularProgressIndicator(color: textClr,strokeWidth: 3.0,),):
                              smallText12(context,
                                  'Resend OTP',fontWeight: FontWeight.w500):
                              smallText12(context,
                                  formatTime(remainingTime),fontWeight: FontWeight.w500,),
                            ],
                          ),
                        ),

                      /*  isResendButtonVisible
                            ? GestureDetector(
                          onTap: () {
                            resendOtp();
                          },
                          child:mediumText14(context, 'resend_code',fontWeight: FontWeight.w500, ),
                        )
                            : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            buildTime(),
                            mediumText14(context, 'second_text',fontWeight: FontWeight.w500,)
                          ],
                        ),*/

                        UiHelper.verticalSpace(height: screenHeight * 0.1),

                        brownButton(context: context,
                            labelText: 'verify_text',width: 300,
                            isLoading: state.status == BucketListStatus.registerVerifyOTPLoading,
                            onTap: (){
                              if(OTPController.text.isEmpty){
                                UiHelper.toastMessage("Please enter OTP");
                              }
                              else if(OTPController.text.length != 4){
                                UiHelper.toastMessage("Please enter valid Verification Code");
                              }else{
                              //  CustomNavigator.push(context: context, screen: ResetPassword(tempToken:widget.tempToken));
                                print("OTPController.text:${OTPController.text}");
                                BlocProvider.of<BucketListCubit>(context).registerOTPVerifyCall(OTPController.text,tmpToken);
                              }
                            }
                        ),
                        UiHelper.verticalSpace(height: screenHeight * 0.1),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTimeCard({required String time, required String header}) =>
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          mediumText14(context, time,fontWeight: FontWeight.bold,),
        ],
      );
  Widget buildTime() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(width: 1),
        buildTimeCard(time: minutes, header: 'MM'),
        const SizedBox(width: 2),
        mediumText14(context, ":",fontWeight: FontWeight.bold,),
        const SizedBox(width: 1),
        buildTimeCard(time: seconds, header: 'SS'),
      ],
    );
  }
}
