import 'package:bucket_list_flutter/model/become_a_client_response.dart';
import 'package:bucket_list_flutter/model/get_service_list_response.dart';
import 'package:bucket_list_flutter/model/persons_list_response.dart' as dfrSalesPersons;
import 'package:bucket_list_flutter/model/get_service_list_response.dart' as dfrServiceList;
import 'package:bucket_list_flutter/model/persons_list_response.dart';
import 'package:bucket_list_flutter/model/sign_up_response.dart';
import 'package:bucket_list_flutter/screens/auth/login.dart';
import 'package:bucket_list_flutter/screens/auth/otp_verification.dart';
import 'package:bucket_list_flutter/screens/auth/widget/my_checkbox.dart';
import 'package:bucket_list_flutter/utils/app_loader.dart';
import 'package:bucket_list_flutter/utils/app_widgets.dart';
import 'package:bucket_list_flutter/utils/mydropdown_all.dart';
import 'package:bucket_list_flutter/utils/resources/resource_imports.dart';
import 'package:bucket_list_flutter/utils/textfield_validator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:collection/collection.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
class BecomeClientLogin extends StatefulWidget {
  const BecomeClientLogin({super.key});

  @override
  State<BecomeClientLogin> createState() => _BecomeClientLoginState();
}

class _BecomeClientLoginState extends State<BecomeClientLogin> {

  final _formKey = GlobalKey<FormState>();

  TextEditingController contactNameController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController jobTitleController = TextEditingController();
  TextEditingController cityStateZipController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController websiteController = TextEditingController();
  TextEditingController companyInfoController = TextEditingController();


  String? selectedSalesPerson;
  String? selectedService;
  bool isPasswordVisible1 = true;
  List<dfrSalesPersons.Data> salesPersonsList = [];
  List<dfrServiceList.Data> serviceListData = [];
  bool haveReferral = false;


  @override
  void initState() {
    _getServiceTypeAPi();
 //   emailController.text = "thiru@yopmail.com";
    super.initState();
  }

  Future<void> _getServiceTypeAPi() async {
    await BlocProvider.of<BucketListCubit>(context).getServiceListCall();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: backgroundclr,
      resizeToAvoidBottomInset: true,
      appBar: CustomAppBar(title: "",arrowBeforeWidth:12),
      body: SafeArea(
        child: BlocConsumer<BucketListCubit,BucketListState>(
          listener: (context,state){
            print("state.status:${state.status}");
            if (state.status == BucketListStatus.becomeAClientSuccess){
              BecomeAClientResponse becomeAClientResponse = state.responseData?.response as BecomeAClientResponse;
              UiHelper.toastMessage(becomeAClientResponse.message??'');
              CustomNavigator.pushAndRemoveUntil(context: context, screen:LoginScreen());
              //  _clearControllers();
            }
            if (state.status == BucketListStatus.personListSuccess){
              Loader.hide();
              PersonsListResponse personsListResponse = state.responseData?.response as PersonsListResponse;
              salesPersonsList = personsListResponse.data ?? [];
            }
            if (state.status == BucketListStatus.getServiceListSuccess){
              BlocProvider.of<BucketListCubit>(context).personListCall();
              Loader.hide();
              GetServiceListResponse personsListResponse = state.responseData?.response as GetServiceListResponse;
              serviceListData = personsListResponse.data ?? [];
            }
            if(state.status == BucketListStatus.signUpError){
              UiHelper.toastMessage(state.errorData?.message ?? state.error ?? "");
            }
            if(state.status == BucketListStatus.becomeAClientError){
              UiHelper.toastMessage(state.errorData?.message ?? state.error ?? "");
            }
            if(state.status == BucketListStatus.personListError){
              UiHelper.toastMessage(state.errorData?.message ?? state.error ?? "");
            }
          },
          builder: (context,state){
            if (state.status == BucketListStatus.getServiceListLoading || state.status == BucketListStatus.personListLoading) {
              return  AppLoader();
            }
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 32,right: 32),
                child: Form(  // <--- Wrap your form here
                  key: _formKey, // <-- Assign the key
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      UiHelper.verticalSpace(height: 2),
                      largeTextLoc16(context, 'be_a_client',fontSize: 20,fontWeight: FontWeight.w500),
                      UiHelper.verticalSpace(height: 6),
                      mediumText14(context, 'Lorem ipsum dolor sit amet consectetur. Mus donec faucibus nisl aenean at. Nibh cras odio posuere penatibus proin sed. Parturient purus mattis nunc nec ipsum sed hendrerit. Est'),
                      UiHelper.verticalSpace(height: 16),
                      AppWidgets.commonTextField(
                        onTap: () => {},
                        onChanged: (value) {},
                        inputMaxLine: 1,
                        keyboardType: TextInputType.name,
                        bgColor: Colors.transparent,
                        inputHintText: 'contact_name_text',
                        inputController: contactNameController,
                        textInputAction: TextInputAction.next,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z ]")), // Allows only letters and spaces
                        ],
                        validator: AppValidator.validatorField( fieldTitle:tr('contact_name_text')),
                      ),
                      UiHelper.verticalSpace(height: screenHeight * 0.013),
                      AppWidgets.commonTextField(
                        inputHintText: 'company_name',
                        inputController: companyNameController,
                        textCapitalization: TextCapitalization.sentences,
                        textInputAction: TextInputAction.next,
                        validator: AppValidator.validatorField( fieldTitle: tr('company_name')),
                      ),
                      UiHelper.verticalSpace(height: screenHeight * 0.013),
                      AppWidgets.commonTextField(
                        inputHintText: 'address_txt',
                        inputController: addressController,
                        textCapitalization: TextCapitalization.sentences,
                        inputMaxLine: 4,
                        maxLength: 250,
                        validator: AppValidator.validatorAddressField( fieldTitle: tr('address_txt')),
                      ),
                      UiHelper.verticalSpace(height: screenHeight * 0.013),
                      AppWidgets.commonTextField(
                        inputHintText: 'job_title_txt',
                        inputController: jobTitleController,
                        textInputAction: TextInputAction.next,
                        validator: AppValidator.validatorField( fieldTitle: tr('job_title_txt')),
                      ),
                      UiHelper.verticalSpace(height: screenHeight * 0.013),
                      AppWidgets.commonTextField(
                        inputHintText: 'city_state_zip_txt',
                        inputController: cityStateZipController,
                        textInputAction: TextInputAction.next,
                        validator: AppValidator.validatorField( fieldTitle: tr('city_state_zip_txt')),
                      ),
                      UiHelper.verticalSpace(height: screenHeight * 0.013),
                      AppWidgets.commonTextField(
                        maxLength: 16,
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
                        inputController: passwordController,
                        obscureText: isPasswordVisible1,
                        maxLength: 16,
                        bgColor: Colors.transparent,
                        textCapitalization: TextCapitalization.none,
                        onTap: () => {},
                        onChanged: (value) {},
                        inputMaxLine: 1,
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
                        inputHintText: 'website_txt',
                        inputController: websiteController,
                        keyboardType:TextInputType.url,
                        textCapitalization: TextCapitalization.none,
                        textInputAction: TextInputAction.next,
                        validator: AppValidator.validatorWebsite( fieldTitle: tr('website_txt')),
                      ),
                      UiHelper.verticalSpace(height: screenHeight * 0.013),
                      largeTextLoc16(context, 'company_info_text'),
                      UiHelper.verticalSpace(height: 12),
                      AppWidgets.commonTextField(
                        inputMaxLine: 5,
                        inputHintText: 'Enter your compnay info',
                        inputController: companyInfoController,
                        textCapitalization: TextCapitalization.sentences,
                        maxLength:256,
                       // validator: AppValidator.validatorField( fieldTitle: tr('company_info_text')),
                        validator: AppValidator.validatorAddressField( fieldTitle: tr('company_info_text')),
                      ),
                      UiHelper.verticalSpace(height: screenHeight * 0.02),
                      MyDropDownAll<dfrServiceList.Data>(
                        items: serviceListData,
                        selectedValue: serviceListData.firstWhereOrNull((user) => user.id == selectedService),
                        hintText: "Select Service Type",
                        hintFontSize: 16.sp,
                        textFontSize: 16.sp,
                        borderRadiusValue: 12,
                        dropDownHeight: 50,
                        dropDownWidth: 40,
                        onSelected: (value) {
                          setState(() {
                            selectedService = value?.id;
                          });
                          print('selectedService:$selectedService');
                        },
                        displayText: (item) =>
                        item.name ?? 'Unknown',
                      ),
        
                      UiHelper.verticalSpace(height: screenHeight * 0.02),
                      MyCheckbox(
                        value: haveReferral,
                        onChanged: (val) {
                          setState(() {
                            haveReferral = val!;
                          });
                          print('haveReferral:$haveReferral');
                          if(haveReferral){
                          //  BlocProvider.of<BucketListCubit>(context).personListCall();
                           // loader(context);
                          }else{
                            selectedSalesPerson = null;
                          }
                        },
                        textDsc: "do_have_referral",
                        fontWeight: FontWeight.w500,
                      ),
                      UiHelper.verticalSpace(height: screenHeight * 0.025),
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
                          isLoading: state.status == BucketListStatus.becomeAClientLoading,
                          labelText: 'next_txt',
                          onTap: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              if (selectedService == null) {
                                UiHelper.toastMessage('Please select service type');
                                return;
                              }
                              if (haveReferral==true && selectedSalesPerson == null) {
                                UiHelper.toastMessage('Please select sales person');
                                return;
                              }
                              Map<String, dynamic> clientDetails =
                                  {
                                  "name": contactNameController.text,
                                  "company_name": companyNameController.text,
                                  "email": emailController.text,
                                  "phone": phoneController.text,
                                  "password": passwordController.text,
                                  "category": selectedService,
                                  "address": addressController.text,
                                  "company_information": companyInfoController.text,
                                  "job_title": jobTitleController.text,
                                  "sales_person": selectedSalesPerson,
                                  "website": websiteController.text,
                                  "city_zip": cityStateZipController.text,
                                };
                              // Remove "sales_person" if it's null or empty
                              if (selectedSalesPerson == null || selectedSalesPerson.toString().trim().isEmpty) {
                                clientDetails.remove("sales_person");
                              }
                              print('clientDetails:$clientDetails');
                              BlocProvider.of<BucketListCubit>(context).becomeAClient(clientDetails);
                            }
                          }
                      ),
                      UiHelper.verticalSpace(height: screenHeight * 0.15),
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