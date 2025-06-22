import 'package:bucket_list_flutter/main.dart';
import 'package:bucket_list_flutter/model/sign_in_response.dart';
import 'package:bucket_list_flutter/screens/auth/client/become_client_login.dart';
import 'package:bucket_list_flutter/screens/auth/forgot_password.dart';
import 'package:bucket_list_flutter/screens/auth/otp_verification.dart';
import 'package:bucket_list_flutter/screens/auth/sign_up.dart';
import 'package:bucket_list_flutter/screens/auth/splashscreen.dart';
import 'package:bucket_list_flutter/screens/auth/widget/my_checkbox.dart';
import 'package:bucket_list_flutter/screens/bottom_nav_bar/bottom_nav_bar_convex.dart';
import 'package:bucket_list_flutter/screens/homescreen/homescreen.dart';
import 'package:bucket_list_flutter/utils/app_widgets.dart';
import 'package:bucket_list_flutter/utils/resources/resource_imports.dart';
import 'package:bucket_list_flutter/utils/shared_preference.dart';
import 'package:bucket_list_flutter/utils/textfield_validator.dart';

import '../bottom_nav_bar/bottom_bar_new.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isPasswordVisible = true;
  bool rememberTapped = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    getStoredValue();
  emailController.text = "moorthy@yopmail.com";
  passwordController.text = "Thiru@003";
    super.initState();
  }

   _validateAndSubmit() {
    String input = emailController.text.trim();
    String password = passwordController.text.trim();
    if (_formKey.currentState?.validate() ?? false) {
      Map<String, dynamic> signInDetails = {
        "email": input,
        "password": password,
        "fcmToken" : fcmToken==""?"dummyToken":fcmToken,
      };
      print('SignIn Details: $signInDetails');
      BlocProvider.of<BucketListCubit>(context).signInCall(signInDetails);
    }
  }
  void _clearControllers() {
    emailController.clear();
    passwordController.clear();
    FocusScope.of(context).unfocus(); // Remove focus from text fields
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundclr,
      body: SafeArea(
        child: BlocConsumer<BucketListCubit,BucketListState>(
          listener: (context,state){
            if (state.status == BucketListStatus.signInSuccess){
              SignInResponse signInResponse = state.responseData?.response as SignInResponse;
              if(isRememberMe){
                PreferenceManager.insertValue(key: EMAIL_ID, value: emailController.text);
                PreferenceManager.insertValue(key: PASSWORD, value: passwordController.text);
              }
              if(signInResponse.data?.isStatus == "active"){
                setState(() {
                  loginValue = true;
                });
                PreferenceManager.insertValue(key: TOKEN, value: signInResponse.data?.accessToken.toString());
                CustomNavigator.pushAndRemoveUntil(
                  context: context,
                  screen: BottomNavBarConvex());
              }else{
                CustomNavigator.push(
                  context: context,
                  screen: OtpVerification(fromPage:'Login',
                    tmpToken:signInResponse.data?.accessToken??'',
                    tmpOtp:signInResponse.data?.otp??'',),);
              }
            }
            if(state.status == BucketListStatus.signInError){
              print(state.errorData?.message);
              String message = state.errorData?.message ?? state.error ?? "";
              UiHelper.toastMessage(message);
            }
          },
          builder: (context,state){
            return SingleChildScrollView(
              child: Form(  // <--- Wrap your form here
                key: _formKey, // <-- Assign the key
                child: Padding(
                    padding: const EdgeInsets.only(left: 32,right: 32),
                    child: Column(
                      children: [
                        UiHelper.verticalSpace(height: screenHeight * 0.06),
                        Center(
                          child: Image.asset(
                            AppAssets.bucketLogo,height: 137.25,width: 137.25,
                            // height: 14.h,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 11.h, bottom: 15.sp),
                          child:  AppWidgets.commonTextField(
                            onTap: () => {},
                            onChanged: (value) {},
                            inputMaxLine: 1,
                            bgColor: Colors.transparent,
                            inputHintText: 'email_text',
                            inputController: emailController,
                            textCapitalization: TextCapitalization.none,
                            textInputAction:TextInputAction.next,
                            validator: (value) {
                              return AppValidator.validatorEmail!(value);
                            },
                          ),
                        ),
                        AppWidgets.commonTextField(
                          obscureText: isPasswordVisible,
                          bgColor: Colors.transparent,
                          onTap: () => {},
                          onChanged: (value) {},
                          inputMaxLine: 1,
                          textCapitalization: TextCapitalization.none,
                          suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  isPasswordVisible = !isPasswordVisible;
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(right: 18.0), // adjust as needed
                                child: SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: Image.asset(
                                    isPasswordVisible
                                        ? AppAssets.passwordEyeHide
                                        : AppAssets.passwordEyeShow,  fit: BoxFit.contain,
                                  ),
                                ),
                              )),
                          inputHintText: 'password_text',
                          inputController: passwordController,
                          validator: (value) {
                            return AppValidator.validatorPassword1!(value);
                          },
                        ),
                        UiHelper.verticalSpace(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            MyCheckbox(
                              value: rememberTapped,
                              onChanged: (val) {
                                setState(() {
                                  rememberTapped = val!;
                                  isRememberMe = rememberTapped;
                                  PreferenceManager.insertValue(key: IS_REMEMBER_ME, value: isRememberMe);
                                });
                              },
                              textDsc: 'Remember me',
                            ),
                            Spacer(),
                            TextButton(
                              onPressed: () {
                                _clearControllers();
                                CustomNavigator.push(context: context, screen: const ForgotPassword());
                              },
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,        // Remove internal padding
                                minimumSize: Size.zero,          // Remove minimum size constraints
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap, // Shrink tap target
                                visualDensity: VisualDensity.compact, // Reduce spacing around button
                              ),
                              child: mediumText14(context, 'Forgot the password?'),
                            ),
                          ],
                        ),
                        UiHelper.verticalSpace(height:  screenHeight * 0.10),
                        brownButton(context: context,
                            isLoading: state.status == BucketListStatus.signInLoading,
                            onTap: _validateAndSubmit,
                            labelText:'Login'),
                        UiHelper.verticalSpace(height:  screenHeight * 0.022),
                        RichText(
                          text: TextSpan(
                            style: TextStyle(fontFamily: "Poppins",fontSize: 14,fontWeight: FontWeight.w400,color:textClr,),
                            children: [
                              const TextSpan(
                                text: "Don’t have an account?  ",
                              ),
                              TextSpan(
                                text: "SIGN UP",
                                style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color:textClr),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    _clearControllers();
                                    CustomNavigator.push(context: context, screen: const SignupScreen());
                                  },
                              ),
                            ],
                          ),
                        ),
                        UiHelper.verticalSpace(height:  screenHeight * 0.015),
                        TextButton(
                          onPressed: () {
                            CustomNavigator.push(context: context, screen: BecomeClientLogin());
                          },
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,        // Remove internal padding
                            minimumSize: Size.zero,          // Remove minimum size constraints
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap, // Shrink tap target
                            visualDensity: VisualDensity.compact, // Reduce spacing around button
                          ),
                          child: largeTextLoc16(context, 'be_a_client',fontWeight: FontWeight.w600),
                        ),
                      ],
                    )
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> getStoredValue() async {
    var token = PreferenceManager.getStringValue(key: TOKEN) ?? '';
    myUserID = PreferenceManager.getIntegerValue(key: USER_ID) ?? 0;
    isRememberMe = PreferenceManager.getBooleanValue(key: IS_REMEMBER_ME) ?? false;


    print('isRememberMe:$isRememberMe');
    if(isRememberMe){
      emailController.text = PreferenceManager.getStringValue(key: EMAIL_ID) ?? '';
      passwordController.text = PreferenceManager.getStringValue(key: PASSWORD) ?? '';
      rememberTapped = true;
    }

    if (token != '') {
      loginValue = true;
    }
    print('loginValue:$loginValue');
  }
}




