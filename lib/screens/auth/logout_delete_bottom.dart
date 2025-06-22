

import 'package:bucket_list_flutter/screens/auth/login.dart';
import 'package:bucket_list_flutter/utils/resources/resource_imports.dart';
import 'package:bucket_list_flutter/utils/shared_preference.dart';

class LogoutDeleteBottom extends StatefulWidget {
  final String fromMenu;
  const LogoutDeleteBottom({super.key, required this.fromMenu});

  @override
  State<LogoutDeleteBottom> createState() => _LogoutDeleteBottomState();
}

class _LogoutDeleteBottomState extends State<LogoutDeleteBottom> {

  @override
  Widget build(BuildContext context) {
    double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    return BlocConsumer<BucketListCubit,BucketListState>(
        listener: (context, state) async {
          if (state.status == BucketListStatus.logoutSuccess) {
            PreferenceManager.clearPreferences();
            CustomNavigator.pushAndRemoveUntil(context: context, screen: const LoginScreen());
          } else if (state.status == BucketListStatus.logoutError) {
            UiHelper.toastMessage(state.error ?? 'Something went wrong');
          }
        },
      builder: (context, state) {
        return SingleChildScrollView(
          reverse: true,
          child: IntrinsicHeight(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.only(
                bottom: keyboardHeight, // Add padding for the keyboard
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top:12,left: 28, right: 28, bottom: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    UiHelper.verticalSpace(height: 12),
                    largeText16(context, widget.fromMenu=="logout"?'Logout':'Delete Account',
                        fontSize: 20,
                        fontWeight: FontWeight.w600,textColor: const Color(0xff424242)),
                    UiHelper.verticalSpace(height: 18),
                    mediumText14(context,  widget.fromMenu=="logout"?'Are you sure you want to log out?':'Are you sure you want to Delete your account permanently?',
                        textAlign: TextAlign.center,fontWeight: FontWeight.w500,textColor: const Color(0xff424242)),
                    UiHelper.verticalSpace(height: 40),
                    Row( mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        brownButton(context: context,
                          width: 120,height: 40,
                          labelText: 'Yes',fontSize:18,
                          fontWeight: FontWeight.w500,
                          isLoading: state.status == BucketListStatus.logoutLoading,
                          borderRadiusValue: 30,
                          onTap: (){
                            BlocProvider.of<BucketListCubit>(context).logoutCall();
                          },
                        ),
                        const SizedBox(width: 60,),
                        brownButton(context: context,
                          width: 120,height: 40,
                          labelText: 'No',fontSize:18,
                          fontWeight: FontWeight.w500,
                          borderRadiusValue: 30,
                          buttonColor: Colors.white,
                          textColor: textClr,
        
        
                         /* backgroundColor:Colors.white,textColor:buttonColor,
                          border: Border.all(color: buttonColor, width: 1.0),
                          padding :const EdgeInsets.symmetric(horizontal: 38, vertical: 4),
                          borderRadius: const BorderRadius.all(Radius.circular(22.5),),*/
                          onTap: (){
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                    UiHelper.verticalSpace(height: 18),
                  ],
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}