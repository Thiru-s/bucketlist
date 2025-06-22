import 'package:bucket_list_flutter/model/persons_list_response.dart' as dfrSalesPersons;
import 'package:bucket_list_flutter/model/persons_list_response.dart';
import 'package:bucket_list_flutter/model/sign_up_response.dart';
import 'package:bucket_list_flutter/screens/auth/login.dart';
import 'package:bucket_list_flutter/screens/auth/otp_verification.dart';
import 'package:bucket_list_flutter/screens/auth/widget/my_checkbox.dart';
import 'package:bucket_list_flutter/utils/app_widgets.dart';
import 'package:bucket_list_flutter/utils/mydropdown_all.dart';
import 'package:bucket_list_flutter/utils/resources/resource_imports.dart';
import 'package:bucket_list_flutter/utils/textfield_validator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:collection/collection.dart';


class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  final _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController positionController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  String? selectedSalesPerson;
  bool isPasswordVisible1 = true;
  bool isPasswordVisible2 = true;
  List<dfrSalesPersons.Data> salesPersonsList = [];
  bool haveReferral = false;

  @override
  void initState() {
   /* emailController.text = "thiru@yopmail.com";
    passwordController.text = "Thiru@003";
    confirmPasswordController.text = "Thiru@003";*/
    super.initState();
  }

  void _clearControllers() {
    nameController.clear();
    companyNameController.clear();
    positionController.clear();
    emailController.clear();
    phoneController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    FocusScope.of(context).unfocus(); // Remove focus from text fields
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: backgroundclr,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: BlocConsumer<BucketListCubit,BucketListState>(
          listener: (context,state){
            print("state.status:${state.status}");
            if (state.status == BucketListStatus.signUpSuccess){
              SignUpResponse signUpResponse = state.responseData?.response as SignUpResponse;
              UiHelper.toastMessage(signUpResponse.message??'');
              _clearControllers();
              haveReferral = false;
              selectedSalesPerson = null;
              CustomNavigator.push(context: context,
                      screen: OtpVerification(fromPage:'SignUp',tmpToken:signUpResponse.data?.accessToken??'',tmpOtp:signUpResponse.data?.otp??''), );
            }
            if (state.status == BucketListStatus.personListSuccess){
              PersonsListResponse personsListResponse = state.responseData?.response as PersonsListResponse;
              salesPersonsList = personsListResponse.data ?? [];
            }
            if(state.status == BucketListStatus.signUpError){
              UiHelper.toastMessage(state.errorData?.message ?? state.error ?? "");
            }
            if(state.status == BucketListStatus.personListError){
              UiHelper.toastMessage(state.errorData?.message ?? state.error ?? "");
            }
          },
          builder: (context,state){
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 32,right: 32),
                child: Form(  // <--- Wrap your form here
                  key: _formKey, // <-- Assign the key
                  child: Column(
                    children: [
                      UiHelper.verticalSpace(height: screenHeight * 0.06),
                      Center(
                        child: Image.asset(
                          AppAssets.bucketLogo,height: 137.25,width: 137.25,
                          // height: 14.h,
                        ),
                      ),
                      UiHelper.verticalSpace(height: screenHeight * 0.05),
                      AppWidgets.commonTextField(
                        onTap: () => {},
                        onChanged: (value) {},
                        inputMaxLine: 1,
                        keyboardType: TextInputType.name,
                        bgColor: Colors.transparent,
                        inputHintText: 'name_text',
                        inputController: nameController,
                        textInputAction: TextInputAction.next,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z ]")), // Allows only letters and spaces
                          FilteringTextInputFormatter.deny(RegExp(r"\s{2,}")), // Prevents consecutive spaces
                        ],
                        validator: AppValidator.validatorField( fieldTitle:tr('name_text')),
                      ),
                      UiHelper.verticalSpace(height: screenHeight * 0.013),
                      AppWidgets.commonTextField(
                        inputMaxLine: 1,
                        inputHintText: 'company_name',
                        inputController: companyNameController,
                        textCapitalization: TextCapitalization.sentences,
                        textInputAction: TextInputAction.next,
                        maxLength: 50,
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(RegExp(r"\s{2,}")), // Prevents consecutive spaces
                        ],
                        validator: AppValidator.validatorField( fieldTitle: tr('company_name')),
                      ),
                      UiHelper.verticalSpace(height: screenHeight * 0.013),
                      AppWidgets.commonTextField(
                        inputController: positionController,
                        onTap: () => {},
                        onChanged: (value) {},
                        inputMaxLine: 1,
                        bgColor: Colors.transparent,
                        inputHintText: 'position_at_company',
                        textInputAction: TextInputAction.next,
                        validator: AppValidator.validatorField( fieldTitle: tr('position_at_company')),
                      ),
                      UiHelper.verticalSpace(height: screenHeight * 0.013),
                      AppWidgets.commonTextField(
                        onTap: () => {},
                        onChanged: (value) {},
                        inputMaxLine: 1,
                        bgColor: Colors.transparent,
                        inputHintText: 'email_text',
                        inputController: emailController,
                        textCapitalization: TextCapitalization.none,
                        keyboardType:TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          return AppValidator.validatorEmail!(value);
                        },
                      ),
                      UiHelper.verticalSpace(height: screenHeight * 0.013),
                      AppWidgets.commonTextField(
                        maxLength: 15,
                        onTap: () => {},
                        onChanged: (value) {},
                        inputMaxLine: 1,
                        bgColor: Colors.transparent,
                        keyboardType: TextInputType.phone,
                        inputHintText: 'phone_text',
                        inputController: phoneController,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly, // Allows only numbers
                        ],
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          return AppValidator.validatorPhone!(value);
                        },
                      ),
                      UiHelper.verticalSpace(height: screenHeight * 0.013),
                      AppWidgets.commonTextField(
                        inputController: passwordController,
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
                                      ? AppAssets.passwordEyeHide
                                      : AppAssets.passwordEyeShow,  fit: BoxFit.contain,
                                ),
                              ),
                            )),
                        inputHintText: 'Enter Password',
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          return AppValidator.validatorPassword!(value);
                        },
                      ),
                      UiHelper.verticalSpace(height: screenHeight * 0.013),
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
                                      ? AppAssets.passwordEyeHide
                                      : AppAssets.passwordEyeShow,  fit: BoxFit.contain,
                                ),
                              ),
                            )),
                        inputHintText: 'Re-enter Password',
                        validator: AppValidator.validatorConfirmPassword(passwordController,"pl_re_enter_pw","pw_re_enter_should_match"),
                        // validator: (value) {
                        //   return AppValidator.validatorPassword!(value);
                        // },
                      ),
                      UiHelper.verticalSpace(height: screenHeight * 0.03),
                      MyCheckbox(
                        value: haveReferral,
                        onChanged: (val) {
                          setState(() {
                            haveReferral = val!;
                          });
                          print('haveReferral:$haveReferral');
                          if(haveReferral){
                            BlocProvider.of<BucketListCubit>(context).personListCall();
                          }else{
                            selectedSalesPerson = null;
                          }
                        },
                        textDsc: "do_have_referral",
                        fontWeight: FontWeight.w500,
                      ),
                      UiHelper.verticalSpace(height: screenHeight * 0.013),
                      haveReferral?
                      Column(
                        children: [
                          MyDropDownAll<dfrSalesPersons.Data>(
                            items: salesPersonsList,
                            selectedValue: salesPersonsList.firstWhereOrNull((user) => user.id == selectedSalesPerson),
                            hintText: "Select Sales Person",
                            hintFontSize: 16.sp,
                            textFontSize: 16.sp,
                            borderRadiusValue: 12,
                            dropDownHeight: 50,
                            dropDownWidth: 40,
                            onSelected: (value) {
                              setState(() {
                                selectedSalesPerson = value?.id;
                              });
                              print('selectedSalesPerson:$selectedSalesPerson');
                            },
                            displayText: (item) =>
                            '${item.firstname ?? 'Unknown'} ${item.lastname ?? ''}',
                          ),
                          UiHelper.verticalSpace(height: screenHeight * 0.01),
                        ],
                      ):const SizedBox(),
                      UiHelper.verticalSpace(height: screenHeight * 0.02),
                      brownButton(context: context,
                        isLoading: state.status == BucketListStatus.signUpLoading,
                        labelText: 'sign_up_text',
                          onTap: () {
                        /*    CustomNavigator.push(
                              context: context,
                                screen: OtpVerification(fromPage:'SignUp',tmpToken:'',tmpOtp:''), );*/

                            if (_formKey.currentState?.validate() ?? false) {
                              if (haveReferral==true && selectedSalesPerson == null) {
                                UiHelper.toastMessage('Please select sales person');
                                return;
                              }
                              Map<String, dynamic> signUpDetails = {
                                "name": nameController.text,
                                "email": emailController.text,
                                "password": passwordController.text,
                                "position": positionController.text,
                                "company_name": companyNameController.text,
                                "phone": phoneController.text,
                                "referral":selectedSalesPerson,
                                "fcmToken" : fcmToken==""?"dummyToken":fcmToken,
                              };
                              if (selectedSalesPerson == null || selectedSalesPerson.toString().trim().isEmpty) {
                                signUpDetails.remove("referral");
                              }
                              print('signUpDetails:$signUpDetails');
                              BlocProvider.of<BucketListCubit>(context).signUpCall(signUpDetails);
                            }
                          }
                      ),
                      UiHelper.verticalSpace(height: screenHeight * 0.02),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(fontFamily: "Poppins",fontSize: 12,fontWeight: FontWeight.w400,color:textClr,),
                          children: [
                            TextSpan(
                              text: 'already_have_account'.tr(), // Localized text
                            ),
                            TextSpan(
                              text: "LOG IN",
                              style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,color:textClr),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  _clearControllers();
                                  CustomNavigator.push(context: context, screen: const LoginScreen());
                                },
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
      ),
    );
  }
}
