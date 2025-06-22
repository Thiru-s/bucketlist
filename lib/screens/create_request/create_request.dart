import 'package:bucket_list_flutter/screens/create_request/listed_buckets.dart';
import 'package:bucket_list_flutter/screens/reusable_widgets/apptextfield.dart';
import 'package:bucket_list_flutter/screens/reusable_widgets/bottom_calender_picker.dart';
import 'package:bucket_list_flutter/screens/reusable_widgets/custom_appbar.dart';
import 'package:bucket_list_flutter/utils/resources/resource_imports.dart';
import 'package:bucket_list_flutter/utils/textfield_validator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:table_calendar/table_calendar.dart';

class CreateRequest extends StatefulWidget {
  const CreateRequest({super.key});

  @override
  State<CreateRequest> createState() => _CreateRequestState();
}

class _CreateRequestState extends State<CreateRequest> {

  final TextEditingController companyNameController = TextEditingController();
  final TextEditingController companyEmployeeController = TextEditingController();
  final TextEditingController jobTitleController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController dateRequestedController = TextEditingController();
  final TextEditingController scopeOfWorkController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController costCodeController = TextEditingController();
  final TextEditingController purchaseOrWorkController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String? formattedDateAPI;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;



  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundclr,
      appBar: const CustomAppBar(title: "Create Request"),
      body:  SingleChildScrollView(
        child: Form(  // <--- Wrap your form here
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.only(left: 18,right: 18,bottom: 70),
            child: Column(
              spacing: 16,
              children: [
                LabeledTextField(
                  label: "Company Name",
                  hintText: "Company Name",
                  controller: companyNameController,
                  textCapitalization: TextCapitalization.sentences,
                  validator: AppValidator.validatorField( fieldTitle: tr('company_name')),
                ),
                LabeledTextField(
                  label: "Company Employee Name",
                  hintText: "Company Employee Name",
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z ]")), // Allows only letters and spaces
                    FilteringTextInputFormatter.deny(RegExp(r"\s{2,}")), // Prevents consecutive spaces
                  ],
                  controller: companyEmployeeController,
                  validator: AppValidator.validatorField( fieldTitle: 'Company Employee Name'),
                ),
                LabeledTextField(
                  label: "Job Title ",
                  hintText: "Job Title ",
                  controller: jobTitleController,
                  validator: AppValidator.validatorField( fieldTitle: 'Job Title'),
                ),
                LabeledTextField(
                  label: "Email",
                  hintText: "Email",
                  controller: emailController,
                  textCapitalization: TextCapitalization.none,
                  keyboardType:TextInputType.emailAddress,
                  validator: (value) {
                    return AppValidator.validatorEmail!(value);
                  },
                ),
                LabeledTextField(
                  label: "Phone number",
                  hintText: "1234567890",
                  controller: phoneController,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly, // Allows only numbers
                  ],
                  maxLength: 15,
                  keyboardType:TextInputType.phone,
                  validator: (value) {
                    return AppValidator.validatorPhone!(value);
                  },
                ),
                LabeledTextField(
                  controller: dateRequestedController,
                  label: "Date Requested",
                  hintText: "dd/mm/yy",
                  readOnly: true, // Prevent manual editing
                //  onTap: _pickDate,
                  onTap: _pickDateWithCalendar,
                  validator: AppValidator.validatorField( fieldTitle: 'Date Requested'),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(right: 16.0), // adjust as needed
                    child: SizedBox(
                      height: 20,
                      width: 20,
                      child: Image.asset('assets/calender.png',fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                LabeledTextField(
                  label: "Scope of Work",
                  hintText: "Enter your requirement here",
                  controller: scopeOfWorkController,
                  inputMaxLine: 5,
                  textCapitalization: TextCapitalization.sentences,
                  maxLength:256,
                  keyboardType: TextInputType.multiline,
               //   textInputAction: TextInputAction.,
                  validator: AppValidator.validatorField( fieldTitle: 'Scope of Work'),
                ),
                LabeledTextField(
                  label: "Location",
                  hintText: "Location",
                  controller: locationController,
                  validator: AppValidator.validatorField( fieldTitle: 'Location'),
                ),
                LabeledTextField(
                  label: "Cost Code",
                  hintText: "afe,loe",
                  controller: costCodeController,
                  validator: AppValidator.validatorField( fieldTitle: 'Cost Code'),
                ),
                LabeledTextField(
                  label: "Purchase Order/ Work Order",
                  hintText: "Enter Purchase Order or Work Order",
                  controller: purchaseOrWorkController,
                  textInputAction: TextInputAction.done,
                  validator: AppValidator.validatorField( fieldTitle: 'Purchase Order/ Work Order'),
                ),
                UiHelper.verticalSpace(height: 8),
                brownButton(context: context, labelText: 'next_txt',
                onTap: (){
                /*  Map<String, dynamic> requestDetails = {
                    "company_name": companyNameController.text,
                    "company_employee": companyEmployeeController.text,
                    "job_title": jobTitleController.text,
                    "email": emailController.text,
                    "phone": phoneController.text,
                    "requested_date": formattedDateAPI,
                    "work_scope": scopeOfWorkController.text,
                    "location": locationController.text,
                    "cost_code": costCodeController.text,
                    "purchase_order": purchaseOrWorkController.text,
                  };
                  CustomNavigator.push(context: context, screen: ListedBuckets(requestDetails:requestDetails));*/
                  if (_formKey.currentState?.validate() ?? false) {
                    Map<String, dynamic> requestDetails = {
                      "company_name": companyNameController.text,
                      "company_employee": companyEmployeeController.text,
                      "job_title": jobTitleController.text,
                      "email": emailController.text,
                      "phone": int.parse(phoneController.text),
                      "requested_date": formattedDateAPI,
                      "work_scope": scopeOfWorkController.text,
                      "location": locationController.text,
                      "cost_code": costCodeController.text,
                      "purchase_order": purchaseOrWorkController.text,
                    };
                    print('requestDetails:$requestDetails');
                    CustomNavigator.push(context: context, screen: ListedBuckets(requestDetails:requestDetails));
                  }
                }
                ),
                UiHelper.verticalSpace(height: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      String formattedUI = DateFormat('dd/MM/yy').format(pickedDate);
      dateRequestedController.text = formattedUI;
      formattedDateAPI = DateFormat('yyyy-MM-dd').format(pickedDate);
      print('"requested_date": "$formattedDateAPI"');
    }
  }

  void _pickDateWithCalendar() async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return BottomCalendarPicker(
          initialSelectedDate: _selectedDay ?? DateTime.now(), // fallback if null
          onDateSelected: (selectedDate, formattedUI, formattedAPI) {
            setState(() {
              _selectedDay = selectedDate;
              _focusedDay = selectedDate;
              dateRequestedController.text = formattedUI;
              formattedDateAPI = formattedAPI;
            });
          },
        );
      },
    );
  }
}
