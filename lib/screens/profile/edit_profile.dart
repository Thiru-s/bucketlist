import 'dart:io';

import 'package:bucket_list_flutter/model/get_profile_response.dart';
import 'package:bucket_list_flutter/model/get_profile_response.dart' as dfrGetProfile;
import 'package:bucket_list_flutter/model/update_profile_response.dart';
import 'package:bucket_list_flutter/screens/reusable_widgets/apptextfield.dart';
import 'package:bucket_list_flutter/screens/reusable_widgets/choose_photo_bottom.dart';
import 'package:bucket_list_flutter/utils/resources/resource_imports.dart';
import 'package:bucket_list_flutter/utils/textfield_validator.dart';
class EditProfile extends StatefulWidget {
  final GetProfileResponse getProfileResponse;
  const EditProfile({super.key, required this.getProfileResponse});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController companyNameController = TextEditingController();
  final TextEditingController positionController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  File? selectedImage; // Variable to store the selected video
  late final dfrGetProfile.Data? profileData;
  @override
  void initState() {
    // TODO: implement initState
    profileData = widget.getProfileResponse.data; // Shorter reference
    nameController.text = profileData?.user?.name??'';
    companyNameController.text = profileData?.user?.companyName??'';
    positionController.text = profileData?.user?.position??'';
    emailController.text = profileData?.user?.email??'';
    phoneController.text = profileData?.user?.phone??'';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: backgroundclr,
      body: BlocConsumer<BucketListCubit,BucketListState>(
        listener: (context,state){
          print("state.status:${state.status}");
          if (state.status == BucketListStatus.updateProfileSuccess){
            UpdateProfileResponse updateProfileResponse = state.responseData?.response as UpdateProfileResponse;
            UiHelper.toastMessage(updateProfileResponse.message??'');
            Navigator.pop(context, updateProfileResponse.data); // Return updated profile data
          }
          if(state.status == BucketListStatus.updateProfileError){
            UiHelper.toastMessage(state.errorData?.message ?? state.error ?? "");
          }
        },
        builder: (context,state){
          return Form(  // <--- Wrap your form here
            key: _formKey,
            child: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 18,right: 18,top: 35,bottom: 18),
                  child: Column(
                    spacing: 14,
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
                            padding: const EdgeInsets.only(right: 30),
                            child:  MyInkWell(
                              onTap: ()async {
                              /*  final image = await showModalBottomSheet<File?>(
                                  isScrollControlled: true,
                                  useRootNavigator: true,
                                  context: context,
                                  builder: (context) => const ChoosePhotoBottom(),
                                );
                                if (image != null) {
                                  setState(() {
                                    selectedImage = image;
                                  });
                                }*/
                              },
                              child:
                              Stack(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(right: 8),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: const Color(0xff404040), width: 0.75), // Border color and width
                                      borderRadius: BorderRadius.circular(50),),
                                    child:  ClipOval(
                                        child:selectedImage!=null?Image.file(selectedImage!, height: 80, width: 80,fit: BoxFit.fill,):
                                        cachedImageWidget(
                                            image:"$BASEURL/${profileData?.user?.image??''}",
                                            hasProfileImg:true,
                                            borderRadiusValue:50,
                                            height: 80,width: 80)
                                    ),),
                                  Positioned(
                                      right: 0,
                                      bottom: 6,
                                      child: MyInkWell(
                                          onTap: ()async{

                                          },
                                          child: Image.asset('assets/camera.png',height: 25,width: 25,)))
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(),
                        ],
                      ),
                      mediumText14(context, capsFirstChar(profileData?.user?.name??''),textColor:textClr1,fontWeight: FontWeight.w600),
                      UiHelper.verticalSpace(height: 18),
                      LabeledTextField(
                        label: "Name",
                        hintText: "Name",
                        controller: nameController,
                        textCapitalization: TextCapitalization.sentences,
                        validator: AppValidator.validatorField( fieldTitle: 'Name'),
                        contentPadding : const EdgeInsets.only(top: 11, bottom: 11, left: 20, right: 20),
                      ),
                      LabeledTextField(
                        label: "Company Name",
                        hintText: "Company Name",
                        controller: companyNameController,
                        textCapitalization: TextCapitalization.sentences,
                        validator: AppValidator.validatorField( fieldTitle: 'Company Name'),
                        contentPadding : const EdgeInsets.only(top: 11, bottom: 11, left: 20, right: 20),
                      ),
                      LabeledTextField(
                        label: "Position at company",
                        hintText: "Position at company",
                        controller: positionController,
                        validator: AppValidator.validatorField( fieldTitle: 'Position at company'),
                        contentPadding : const EdgeInsets.only(top: 11, bottom: 11, left: 20, right: 20),
                      ),
                      LabeledTextField(
                        readOnly: true,
                        label: "Email",
                        hintText: "Email",
                        controller: emailController,
                        textCapitalization: TextCapitalization.none,
                        keyboardType:TextInputType.emailAddress,
                        contentPadding : const EdgeInsets.only(top: 11, bottom: 11, left: 20, right: 20),
                        validator: (value) {
                          return AppValidator.validatorEmail!(value);
                        },
                      ),
                      LabeledTextField(
                        label: "Phone number",
                        hintText: "1234567890",
                        controller: phoneController,
                        keyboardType:TextInputType.phone,
                        validator: (value) {
                          return AppValidator.validatorPhone!(value);
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 46,left: 12,right: 12),
                        child: brownButton(context: context, labelText:'save_txt',height: 48,
                            isLoading: state.status == BucketListStatus.updateProfileLoading,
                            onTap: (){
                              if (_formKey.currentState?.validate() ?? false) {
                                print('selectedImage:$selectedImage');
                                BlocProvider.of<BucketListCubit>(context).updateProfileCall(nameController.text,
                                    emailController.text, positionController.text, companyNameController.text,
                                    phoneController.text, selectedImage);
                              }
                            }
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
