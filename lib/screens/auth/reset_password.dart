import 'package:bucket_list_flutter/screens/auth/login.dart';
import 'package:bucket_list_flutter/utils/app_widgets.dart';
import 'package:bucket_list_flutter/utils/resources/resource_imports.dart';
import 'package:bucket_list_flutter/utils/textfield_validator.dart';
import 'package:flutter/services.dart';
class ResetPassword extends StatefulWidget {
  final String tempToken;
  const ResetPassword({super.key, required this.tempToken});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {


  final _formKey = GlobalKey<FormState>();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  String? selectedSalesPerson;
  bool isPasswordVisible1 = true;
  bool isPasswordVisible2 = true;

  // bool value = false;
  // bool value1 = false;

  bool referral = false;
  String type = "0";

  @override
  void initState() {
 /*   newPasswordController.text = "Thiru@003";
    confirmPasswordController.text = "Thiru@003";*/
    // TODO: implement initState
    super.initState();
  }

  void _clearControllers() {
    newPasswordController.clear();
    confirmPasswordController.clear();
    FocusScope.of(context).unfocus(); // Remove focus from text fields
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: backgroundclr,
      resizeToAvoidBottomInset: true,
      body: BlocConsumer<BucketListCubit,BucketListState>(
        listener: (context,state){
          if (state.status == BucketListStatus.resetPasswordSuccess){
            UiHelper.toastMessage(state.responseData?.response ?? '');
            CustomNavigator.pushAndRemoveUntil(context: context, screen: const LoginScreen());
          }
          else if (state.status == BucketListStatus.resetPasswordError){
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
                padding: const EdgeInsets.only(left: 18,right: 18,top: 75),
                child: Column(
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
                    largeTextLoc16(context, 'update_pw',fontWeight: FontWeight.w500,fontSize: 26,),
                    UiHelper.verticalSpace(height: screenHeight * 0.01),
                    mediumTextLoc14(context, 'pls_crete_new_pw',fontWeight: FontWeight.w300,),
                    UiHelper.verticalSpace(height: screenHeight * 0.1),
                    Padding(
                      padding: const EdgeInsets.only(left: 18,right: 18),
                      child: Column(
                        children: [
                          AppWidgets.commonTextField(
                            inputController: newPasswordController,
                            obscureText: isPasswordVisible1,
                            maxLength: 16,
                            bgColor: Colors.transparent,
                            onTap: () => {},
                            onChanged: (value) {},
                            inputMaxLine: 1,
                            textCapitalization: TextCapitalization.none,
                            suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isPasswordVisible1 = !isPasswordVisible1;
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 18.0), // adjust as needed
                                  child: SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: Image.asset(
                                      isPasswordVisible1
                                          ? 'assets/passwrdhide2.png'
                                          : AppAssets.passwordEyeShow,  fit: BoxFit.contain,
                                    ),
                                  ),
                                )),
                            inputHintText: 'New Password',
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              return AppValidator.validatorPassword!(value);
                            },
                          ),
                          UiHelper.verticalSpace(height: screenHeight * 0.014),
                          AppWidgets.commonTextField(
                            inputController: confirmPasswordController,
                            obscureText: isPasswordVisible2,
                            bgColor: Colors.transparent,
                            maxLength: 16,
                            onTap: () => {},
                            onChanged: (value) {},
                            inputMaxLine: 1,
                            textCapitalization: TextCapitalization.none,
                            suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isPasswordVisible2 = !isPasswordVisible2;
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 18.0), // adjust as needed
                                  child: SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: Image.asset(
                                      isPasswordVisible2
                                          ? 'assets/passwrdhide2.png'
                                          : AppAssets.passwordEyeShow,  fit: BoxFit.contain,
                                    ),
                                  ),
                                )),
                            inputHintText: 'Confirm Password',
                            validator: AppValidator.validatorConfirmPassword(newPasswordController,"pl_enter_confirm_pw","pw_should_match"),

                            // validator: (value) {
                            //   return AppValidator.validatorConfirmPassword!(value);
                            // },
                          ),
                          UiHelper.verticalSpace(height: screenHeight * 0.2),
                          brownButton(context: context,
                              isLoading: state.status == BucketListStatus.resetPasswordLoading,
                              labelText: 'continue_text',
                              onTap: (){
                                if (_formKey.currentState?.validate() ?? false) {
                                  // if (newPasswordController.text != confirmPasswordController.text) {
                                  //   UiHelper.toastMessage(MATCHING_PASSWORD_VALIDATION ?? '');
                                  //   return;
                                  // }
                                  BlocProvider.of<BucketListCubit>(context).resetPasswordCall(widget.tempToken,newPasswordController.text);
                                }
                              }
                          ),
                          UiHelper.verticalSpace(height: screenHeight * 0.02),
                        ],
                      ),
                    ),
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