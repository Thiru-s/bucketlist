import "package:bucket_list_flutter/screens/reusable_widgets/apptextfield.dart";
import "package:bucket_list_flutter/utils/resources/resource_imports.dart";
import "package:bucket_list_flutter/utils/textfield_validator.dart";
import "package:flutter/services.dart";


class HelpAndSupport extends StatefulWidget {
  const HelpAndSupport({super.key});

  @override
  State<HelpAndSupport> createState() => _HelpAndSupportState();
}

class _HelpAndSupportState extends State<HelpAndSupport> {

  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController queryController = TextEditingController();
  @override
  void initState() {
    _getTermsAndCondApi();
    super.initState();
  }

  Future<void> _getTermsAndCondApi() async {
    await BlocProvider.of<BucketListCubit>(context).termsAndConditionsCall();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundclr,
      appBar: CustomAppBar(title: "Help & Support"),
      body: BlocConsumer<BucketListCubit,BucketListState>(
        listener: (context,state){
          print("state.status:${state.status}");
          if (state.status == BucketListStatus.helpCenterSuccess){
            UiHelper.toastMessage(state.responseData?.response ?? '');
            Navigator.of(context).pop();
          }
          if (state.status == BucketListStatus.helpCenterError){
            UiHelper.toastMessage(state.errorData?.message ?? state.error ?? "");
          }
        },
        builder: (context,state){
          return SingleChildScrollView(
            child: Form(  // <--- Wrap your form here
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.only(left: 24,right: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    UiHelper.verticalSpace(height: 14),
                    CustomTextFormField(
                      hintText: "Name ",
                      controller: nameController,
                      validator: AppValidator.validatorField( fieldTitle: 'Name'),
                    ),
                    UiHelper.verticalSpace(height: 14),
                    CustomTextFormField(
                      hintText: "Email",
                      controller: emailController,
                      textCapitalization: TextCapitalization.none,
                      keyboardType:TextInputType.emailAddress,
                      validator: (value) {
                        return AppValidator.validatorEmail!(value);
                      },
                    ),
                    UiHelper.verticalSpace(height: 14),
                    CustomTextFormField(
                      hintText: "Phone",
                      controller: phoneController,
                      textCapitalization: TextCapitalization.none,
                      keyboardType: TextInputType.phone,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly, // Allows only numbers
                      ],
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        return AppValidator.validatorPhone!(value);
                      },
                    ),
                    UiHelper.verticalSpace(height: 32),
                    Center(child: largeText16(context, 'Query',fontWeight: FontWeight.w500)),
                    UiHelper.verticalSpace(height: 12),
                    CustomTextFormField(
                      hintText: "Enter your Query",
                      controller: queryController,
                      inputMaxLine: 5,
                      textCapitalization: TextCapitalization.sentences,
                      maxLength:256,
                      keyboardType: TextInputType.multiline,
                      //   textInputAction: TextInputAction.,
                      validator: AppValidator.validatorField( fieldTitle: 'your Query'),
                    ),
                    UiHelper.verticalSpace(height: 50),
                    brownButton(context: context, labelText: 'send_txt',
                        isLoading: state.status == BucketListStatus.helpCenterLoading,
                        onTap: (){
                          if (_formKey.currentState?.validate() ?? false) {
                            Map<String, dynamic> helpDetails = {
                              "name": nameController.text,
                              "email": emailController.text,
                              "mobile": phoneController.text,
                              "message": queryController.text,
                            };
                            print('helpDetails:$helpDetails');
                            BlocProvider.of<BucketListCubit>(context).helpCenterCall(helpDetails);
                          }
                        }
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