import 'package:bucket_list_flutter/utils/resources/resource_imports.dart';
import 'package:easy_localization/easy_localization.dart';

abstract class AppValidator {
  static String? Function(String?)? validatorPassword = (value) {
    if (value == null || value.isEmpty) {
      return "pl_enter_pw".tr();
    }

    final passwordRegExp = RegExp(
        r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@\$!%*?&#!])[A-Za-z\d@$!%*?&#]{8,}$');
    if (!passwordRegExp.hasMatch(value)) {
      return "ps_error_msg".tr();
    }

    return null;
  };
  static String? Function(String?)? validatorPassword1 = (value) {
    if (value == null || value.isEmpty) {
      return "pl_enter_pw".tr();
    }
    return null;
  };

  // static String? Function(String?)? validatorConfirmPassword = (value) {
  //   if (value == null || value.isEmpty) {
  //     return "pl_enter_confirm_pw".tr();
  //   }
  //   return null;
  // };

  static String? Function(String?) validatorConfirmPassword(TextEditingController passwordController,String errorText,String validationError) {
    return (value) {
      if (value == null || value.isEmpty) {
        return errorText.tr();
      }
      if (value != passwordController.text) {
        return validationError.tr(); // Or return a hardcoded string: "Passwords do not match"
      }
      return null;
    };
  }


  static String? Function(String?)? validatorOTP = (value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the OTP';
    }

    final otpRegExp = RegExp(r'^\d{4}$');
    if (!otpRegExp.hasMatch(value)) {
      return 'OTP must be exactly 4 digits';
    }

    return null;
  };

  static String? Function(String?) validatorFieldOLD(
      {required String fieldTitle}) {
    return (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter $fieldTitle';
      }
      // Example of additional validation rules
      // if (value.length < 5) {
      //   return '$fieldTitle must be at least 5 characters long';
      // }
      return null;
    };
  }

  static String? Function(String?) validatorField(
      {required String fieldTitle}) {
    return (value) {
      if (value == null || value.isEmpty) {
       // return tr('pl_enter', args: [fieldTitle]);
        return 'Please enter $fieldTitle';
      }
      return null;
    };
  }

  static String? Function(String?) validatorAddressField({
    required String fieldTitle,
    int minLength = 3,
    int maxLength = 250,
  }) {
    return (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter $fieldTitle';
        // Or using localization: return tr('pl_enter', args: [fieldTitle]);
      } else if (value.length < minLength) {
        return '$fieldTitle must be at least $minLength characters';
      } else if (value.length > maxLength) {
        return '$fieldTitle cannot exceed $maxLength characters';
      }
      return null;
    };
  }

  static String? Function(String?) validatorWebsite({required String fieldTitle}) {
    return (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter $fieldTitle'; // or tr('pl_enter', args: [fieldTitle]);
      }
      final pattern =
          r'^(https?:\/\/)?'                 // Optional http or https
          r'([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,}'  // Domain name
          r'(\/[^\s]*)?$';                  // Optional path
      final regex = RegExp(pattern);
      if (!regex.hasMatch(value)) {
        return 'Please enter a valid $fieldTitle';
      }
      return null;
    };
  }



  static String? Function(String?)? validatorEmail = (value) {
    if (value!.isEmpty) {
      return "pl_enter_email".tr();
    }
    final emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    if (!emailRegExp.hasMatch(value)) {
      return "invalid_email".tr();
    }
    return null;
  };

  static String? Function(String?)? validatorPhone = (value) {
    String pattern = r'^[0-9]+$';
    RegExp regex = RegExp(pattern);

    if (value == null || value.isEmpty) {
      return "pl_enter_phone".tr(); // "Please enter phone number"
    } else if (!regex.hasMatch(value)) {
      return "Enter a valid phone number"; // "Enter a valid phone number"
    } else if (value.length < 5 || value.length > 15) {
      return "Phone number must be between 5 and 15 digits"; // "Phone number must be between 5 and 15 digits"
    } else if (RegExp(r'^0+$').hasMatch(value)) {
      return "Phone number cannot be all zeros"; // "Phone number cannot be all zeros"
    }

    return null;
  };

  // static String? Function(String?)? validatorPhone = (value) {
  //   String pattern = r'^[0-9]+$';
  //   RegExp regex = RegExp(pattern);
  //
  //   if (value!.isEmpty) {
  //     return "pl_enter_phone".tr();
  //   } else if (!regex.hasMatch(value)) {
  //     return "invalid_phone".tr(); //'Enter Valid Phone Number';
  //   } else if (value.length > 16) {
  //     return "max_phone_er_msg".tr();
  //   }
  //
  //   return null;
  // };

  static String? Function(String?)? validatorEmailOrPhone = (value) {
    if (value!.isEmpty) {
      return "Please Enter Email or Phone Number".tr();
    }
   /* final emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    if (!emailRegExp.hasMatch(value)) {
      return "invalid_email".tr();
    }*/
    return null;
  };

//
// /******************** Version 2 Validations ********************/
// static String? Function(String?)? v2EmailPhoneValidator = (value) {
//   if (value!.isEmpty) {
//     return 'Please enter a valid phone no.';
//   }
//   bool isEmail(String input) => RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$').hasMatch(input);
//   bool isPhone(String input) => RegExp(
//       r'^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$'
//   ).hasMatch(input);
//
//   if (!isEmail(value) && !isPhone(value)) {
//     return 'Please enter a valid email or phone number.';
//   }
//   return null;
// };

// static String? Function(String?)? validatorLoginPass = (value) {
//   if (value!.isEmpty) {
//     return 'Password is required';
//   }
//   if (value.length < 6) {
//     return 'Password must be at least 8 characters long';
//   }
//   // You can add more password criteria here, such as requiring special characters, numbers, etc.
//   return null; // Return null if the password is valid
// };

// static String? Function(String?)? validatorName({String? data}) => (value) {
//   if (value!.isEmpty) {
//     return '${data ?? 'First Name'} is required';
//   }
//   if (value.length < 2) {
//     return '${data ?? 'First Name'} must be at least 2 characters long';
//   }
//
//   String pattern = r'^[a-zA-Z]+$';
//   RegExp regex = RegExp(pattern);
//   if (!regex.hasMatch(value)) {
//     return 'Enter Valid ${data ?? 'Name'}';
//   }
//
//   // You can add more first name criteria here, such as disallowing special characters and numbers.
//   return null; // Return null if the first name is valid
// };
//

// static String? Function(String?)? validatorUserName = (value) {
//   if (value!.isEmpty) {
//     return 'First Name is required';
//   }
//   // if (value.length < 5) {
//   //   return 'Username must be at least 5 characters long';
//   // }
//   // You can add more username criteria here, such as disallowing spaces and special characters.
//   return null; // Return null if the username is valid
// };

//Send value from key
//
//
// TextFormField(
// decoration: InputDecoration(
// labelText: tr('password'),
// ),
// validator: validatorField(fieldTitle: tr('password')),
// )

// static String? Function(String?)? validatorZipCode = (value) {
//   if (value!.isEmpty) {
//     return 'Zip Code is required';
//   }
//   if (value.length < 4) {
//     return 'Zip Code must be at least 4 characters long';
//   }
//   // You can add more username criteria here, such as disallowing spaces and special characters.
//   return null; // Return null if the username is valid
// };

// static String? Function(String?)? validatorDOB = (value) {
//   if (value!.isEmpty) {
//     return 'Date of Birth is required';
//   }
//   final dobRegExp = RegExp(r'^\d{2}/\d{2}/\d{4}$');
//   if (!dobRegExp.hasMatch(value)) {
//     return 'Invalid date format (use MM/DD/YYYY)';
//   }
//   return null;
// };

// static String? Function(String?)? validatorDOB = (value) {
//   if (value!.isEmpty) {
//     return 'Date of Birth is required';
//   }
//   final dobRegExp = RegExp(r'^\d{2}/\d{2}/\d{4}$');
//   if (!dobRegExp.hasMatch(value)) {
//     return 'Invalid date format (use MM/DD/YYYY)';
//   }
//
//   try {
//     final selectedDate = DateFormat('MM/dd/yyyy').parse(value);
//     DateTime today = DateTime.now();
//
//     final age = today.difference(selectedDate).inDays ~/ 365;
//
//     if (age < 16) {
//       return 'You must be at least 16 years old';
//     }
//   } catch (e) {
//     return 'Invalid date';
//   }
//
//   return null;
// };
}
