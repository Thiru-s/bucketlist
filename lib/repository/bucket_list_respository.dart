

import 'dart:io';

import 'package:bucket_list_flutter/model/become_a_client_response.dart';
import 'package:bucket_list_flutter/model/create_request_response.dart';
import 'package:bucket_list_flutter/model/delete_all_notification_response.dart';
import 'package:bucket_list_flutter/model/faq_response.dart';
import 'package:bucket_list_flutter/model/forgot_password_response.dart';
import 'package:bucket_list_flutter/model/get_all_bucket_response.dart';
import 'package:bucket_list_flutter/model/get_all_request_response.dart';
import 'package:bucket_list_flutter/model/get_bucket_category_response.dart';
import 'package:bucket_list_flutter/model/get_invoice_list_response.dart';
import 'package:bucket_list_flutter/model/get_notification_response.dart';
import 'package:bucket_list_flutter/model/get_profile_response.dart';
import 'package:bucket_list_flutter/model/get_service_list_response.dart';
import 'package:bucket_list_flutter/model/persons_list_response.dart';
import 'package:bucket_list_flutter/model/resend_verify_otp_response.dart';
import 'package:bucket_list_flutter/model/sign_in_response.dart';
import 'package:bucket_list_flutter/model/sign_up_response.dart';
import 'package:bucket_list_flutter/model/terms_and_conditions_response.dart';
import 'package:bucket_list_flutter/model/update_profile_response.dart';
import 'package:bucket_list_flutter/model/verify_otp_response.dart';
import 'package:bucket_list_flutter/repository/api_service.dart';
import 'package:bucket_list_flutter/repository/response_status.dart';
import 'package:bucket_list_flutter/utils/constants.dart';
import 'package:bucket_list_flutter/utils/shared_preference.dart';
import 'package:dio/dio.dart';

class BucketListRepository {
  String? token;

  BucketListRepository() {
    token = PreferenceManager.getStringValue(key: TOKEN);
  }

  String getToken() {
    //  print('token321:$token');
    return token = PreferenceManager.getStringValue(key: TOKEN) ?? '';
  }

  Future<ResponseData> signUp(Map<String, dynamic> signUpDetails) async {
    try {
      final response = await ApiService().sendRequest.post(
        "/user/register",
        data: signUpDetails,
      );
      return ResponseData(
        statusCode: response.statusCode,
        response: SignUpResponse.fromJson(response.data),
      );
    } on DioException catch (e) {
      throw ErrorData(
        //  message: e.response!.data['message'], code: e.response!.statusCode);
          message: e.response!.data['message'], code: e.response!.statusCode);
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<ResponseData> signIn(Map<String, dynamic> signInDetails) async {
    try {
      final response = await ApiService().sendRequest.post(
        "/user/login",
        data: signInDetails,
      );
      return ResponseData(
        statusCode: response.statusCode,
        response: SignInResponse.fromJson(response.data),
      );
    } on DioException catch (e) {
      throw ErrorData(
        //  message: e.response!.data['message'], code: e.response!.statusCode);
          message: e.response!.data['message'], code: e.response!.statusCode);
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<ResponseData> registerOTPVerify(String otp, String token) async {
    print('otp:$otp');
    print('token:$token');
    try {
      final response = await ApiService(token: token).sendRequest.post(
        "/user/verify-otp",
        data: {"otp": otp},
      );
      return ResponseData(
        statusCode: response.statusCode,
        response: VerifyOtpResponse.fromJson(response.data),
      );
    } on DioException catch (e) {
      throw ErrorData(
          message: e.response!.data['message'], code: e.response!.statusCode);
    } on Exception catch (_) {
      rethrow;
    }
  }
  Future<ResponseData> forgotPassword(String emailOrPhone) async {
    try {
      final response = await ApiService().sendRequest.post(
        "/user/forget-password",
        data: {"email": emailOrPhone},
      );
      return ResponseData(
        statusCode: response.statusCode,
        response: ForgotPasswordResponse.fromJson(response.data),
      );
    } on DioException catch (e) {
      throw ErrorData(
          message: e.response!.data['message'], code: e.response!.statusCode);
    } on Exception catch (_) {
      rethrow;
    }
  }
  Future<ResponseData> resetPassword(
      String tmpToken, String newPassword) async {
    print('token:resetPassword:$token');
    try {
      final response = await ApiService(token: tmpToken).sendRequest.post(
        "/user/reset-password",
        data: {
          "password": newPassword,
        },
      );
      return ResponseData(
        statusCode: response.statusCode,
        response: response.data["message"],
      );
    } on DioException catch (e) {
      throw ErrorData(
          message: e.response!.data['message'], code: e.response!.statusCode);
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<ResponseData> resendVerifyOtp(String token) async {
    try {
      final response = await ApiService(token: token).sendRequest.post("/user/resend-otp");
      return ResponseData(
          statusCode: response.statusCode,
          response: ResendVerifyOtpResponse.fromJson(response.data));
    } on DioException catch (e) {
      throw ErrorData(
          message: e.response!.data['message'], code: e.response!.statusCode);
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<ResponseData> personList() async {
    print('getToken():${getToken()}');
    try {
      final response = await ApiService().sendRequest.get("/user/get-person");
      return ResponseData(
          statusCode: response.statusCode,
          response: PersonsListResponse.fromJson(response.data));
    } on DioException catch (e) {
      throw ErrorData(
          message: e.response!.data['message'], code: e.response!.statusCode);
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<ResponseData> getServiceList() async {
    print('getToken():${getToken()}');
    try {
      final response = await ApiService().sendRequest.get("/user/get-service-cat");
      return ResponseData(
          statusCode: response.statusCode,
          response: GetServiceListResponse.fromJson(response.data));
    } on DioException catch (e) {
      throw ErrorData(
          message: e.response!.data['message'], code: e.response!.statusCode);
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<ResponseData> becomeAClient(Map<String, dynamic> clientDetails) async {
    try {
      final response = await ApiService().sendRequest.post(
        "/user/create-client",
        data: clientDetails,
      );
      return ResponseData(
        statusCode: response.statusCode,
        response: BecomeAClientResponse.fromJson(response.data),
      );
    } on DioException catch (e) {
      throw ErrorData(
        //  message: e.response!.data['message'], code: e.response!.statusCode);
          message: e.response!.data['message'], code: e.response!.statusCode);
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<ResponseData> getAllBucket() async {
    print('getToken():${getToken()}');
    try {
      final response = await ApiService(token: getToken()).sendRequest.get("/user/get-all-bucket");
      return ResponseData(
          statusCode: response.statusCode,
          response: GetAllBucketResponse.fromJson(response.data));
    } on DioException catch (e) {
      throw ErrorData(
          message: e.response!.data['message'], code: e.response!.statusCode);
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<ResponseData> getBucketCategories() async {
    try {
      final response = await ApiService(token: getToken()).sendRequest.get("/user/get-bucket-cat");
      return ResponseData(
          statusCode: response.statusCode,
          response: GetBucketCategoryResponse.fromJson(response.data));
    } on DioException catch (e) {
      throw ErrorData(
          message: e.response!.data['message'], code: e.response!.statusCode);
    } on Exception catch (_) {
      rethrow;
    }
  }
  Future<ResponseData> particularBucketCat(String bucketId) async {
    try {
      final response = await ApiService(token: getToken()).sendRequest.get("/user/get-bucket?id=$bucketId&search=");
      return ResponseData(
          statusCode: response.statusCode,
          response: GetAllBucketResponse.fromJson(response.data));
    } on DioException catch (e) {
      throw ErrorData(
          message: e.response!.data['message'], code: e.response!.statusCode);
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<ResponseData> createRequest(Map<String, dynamic> createReqDetails) async {
    try {
      final response = await ApiService(token: getToken()).sendRequest.post(
        "/user/create-request",
        data: createReqDetails,
      );
      return ResponseData(
        statusCode: response.statusCode,
        response: CreateRequestResponse.fromJson(response.data),
      );
    } on DioException catch (e) {
      throw ErrorData(
          message: e.response!.data['message'], code: e.response!.statusCode);
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<ResponseData> getAllRequest() async {
    try {
      final response = await ApiService(token: getToken()).sendRequest.get("/user/get-request");
      return ResponseData(
          statusCode: response.statusCode,
          response: GetAllRequestResponse.fromJson(response.data));
    } on DioException catch (e) {
      throw ErrorData(
          message: e.response!.data['message'], code: e.response!.statusCode);
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<ResponseData> getProfile() async {
    try {
      final response = await ApiService(token: getToken()).sendRequest.get("/user/get-profile");
      return ResponseData(
          statusCode: response.statusCode,
          response: GetProfileResponse.fromJson(response.data));
    } on DioException catch (e) {
      throw ErrorData(
          message: e.response!.data['message'], code: e.response!.statusCode);
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<ResponseData> updateProfile(String name,String email, String position,String companyName,String phone, File? image) async {
    print('imageAPI:$image');
    print('image.path:${image?.path}');
    final fileName = image?.path.split('/').last;
    final formData = FormData.fromMap({
      "name": name,
      "email": email,
      "position": position,
      "company_name": companyName,
      "phone": phone,
      if (image != null)
      "image": await MultipartFile.fromFile(image.path, filename: fileName),
    });
    try {
      final response = await ApiService(token: getToken()).sendRequest.post(
        "/user/update-profile",
        data: formData,
      );
      return ResponseData(
          statusCode: response.statusCode,
          response: UpdateProfileResponse.fromJson(response.data));
    } on DioException catch (e) {
      throw ErrorData(
          message: e.response!.data['message'], code: e.response!.statusCode);
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<ResponseData> termsAndConditions() async {
    try {
      final response = await ApiService(token: getToken()).sendRequest.get("/user/cms");
      return ResponseData(
          statusCode: response.statusCode,
          response: TermsAndConditionsResponse.fromJson(response.data));
    } on DioException catch (e) {
      throw ErrorData(
          message: e.response!.data['message'], code: e.response!.statusCode);
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<ResponseData> getInvoiceList() async {
    try {
      final response = await ApiService(token: getToken()).sendRequest.get("/user/get-invoice");
      return ResponseData(
          statusCode: response.statusCode,
          response: GetInvoiceListResponse.fromJson(response.data));
    } on DioException catch (e) {
      throw ErrorData(
          message: e.response!.data['message'], code: e.response!.statusCode);
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<ResponseData> helpCenter(Map<String, dynamic> helpCenterDeatils) async {
    try {
      final response = await ApiService(token: getToken()).sendRequest.post(
        "/user/help-center",
        data: helpCenterDeatils,
      );
      return ResponseData(
        statusCode: response.statusCode,
        response: response.data["message"],
      //  response: SignUpResponse.fromJson(response.data),
      );
    } on DioException catch (e) {
      throw ErrorData(
        //  message: e.response!.data['message'], code: e.response!.statusCode);
          message: e.response!.data['message'], code: e.response!.statusCode);
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<ResponseData> faq() async {
    try {
      final response = await ApiService(token: getToken()).sendRequest.get("/user/get-faq");
      return ResponseData(
          statusCode: response.statusCode,
          response: FaqResponse.fromJson(response.data));
    } on DioException catch (e) {
      throw ErrorData(
          message: e.response!.data['message'], code: e.response!.statusCode);
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<ResponseData> notificationList() async {
    try {
      final response = await ApiService(token: getToken()).sendRequest.get("/user/get-notification");
      return ResponseData(
          statusCode: response.statusCode,
          response: GetNotificationResponse.fromJson(response.data));
    } on DioException catch (e) {
      throw ErrorData(
          message: e.response!.data['message'], code: e.response!.statusCode);
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<ResponseData> deleteAllNotification() async {
    try {
      final response = await ApiService(token: getToken()).sendRequest.get("/user/clear-notification");
      return ResponseData(
          statusCode: response.statusCode,
          response: response.data["message"]);
       //   response: DeleteAllNotificationResponse.fromJson(response.data));
    } on DioException catch (e) {
      throw ErrorData(
          message: e.response!.data['message'], code: e.response!.statusCode);
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<ResponseData> logout() async {
    try {
      final response = await ApiService(token: getToken()).sendRequest.get("/user/logout");
      return ResponseData(
          statusCode: response.statusCode,
          response: response.data["message"]);
      //   response: DeleteAllNotificationResponse.fromJson(response.data));
    } on DioException catch (e) {
      throw ErrorData(
          message: e.response!.data['message'], code: e.response!.statusCode);
    } on Exception catch (_) {
      rethrow;
    }
  }


/*// Sign up


  Future<ResponseData> signIn(Map<String, dynamic> signInDetails) async {
    try {
      final response = await ApiService().sendRequest.post(
        "/user/login",
        data: signInDetails,
      );
      return ResponseData(
        statusCode: response.statusCode,
        response: SignInResponse.fromJson(response.data),
      );
    } on DioException catch (e) {
      throw ErrorData(
          message: e.response!.data['msg'], code: e.response!.statusCode);
    } on Exception catch (_) {
      rethrow;
    }
  }





  Future<ResponseData> userInterest(Map<String,dynamic> interestList, String tmpToken) async {
    try {
      final response = await ApiService(token:tmpToken).sendRequest.post(
        "/user/user-interest",
        data: interestList, // Sending list as JSON
      );
      return ResponseData(
        statusCode: response.statusCode,
        response: response.data["msg"],
      );
    } on DioException catch (e) {
      throw ErrorData(
          message: e.response!.data['msg'], code: e.response!.statusCode);
    } on Exception catch (_) {
      rethrow;
    }
  }


  Future<ResponseData> getProfile() async {
    print('getToken():${getToken()}');
    try {
      final response = await ApiService(token: getToken()).sendRequest.get("/user/get-profile");
      return ResponseData(
          statusCode: response.statusCode,
          response: GetProfileResponse.fromJson(response.data));
    } on DioException catch (e) {
      throw ErrorData(
          message: e.response!.data['msg'], code: e.response!.statusCode);
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<ResponseData> updateProfile(File? image, String name,String bio, String username ) async {
    print('imageAPI:$image');
    print('image.path:${image?.path}');
    String fileName = "";
    if (image != null) {
      fileName = image.path.split('/').last;
    } else {
      fileName = "";
    }
    FormData formData;
    if (image != null) {
      print('inside');
      formData = FormData.fromMap({
        "image": await MultipartFile.fromFile(image.path, filename: fileName),
        "name": name,
        "bio": bio,
        "username": username,

      });
    } else {
      print('outside');
      formData = FormData.fromMap({
        "name": name,
        "username": username,
        "bio": bio,
      });

    }
    print('formData:$formData');
    try {
      final response = await ApiService(token: getToken()).sendRequest.post(
        "/user/update-profile",
        data: formData,
      );
      return ResponseData(
        statusCode: response.statusCode,
      //  response: response.data["msg"],
          response: UpdateProfileResponse.fromJson(response.data));
    } on DioException catch (e) {
      throw ErrorData(
          message: e.response!.data['msg'], code: e.response!.statusCode);
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<ResponseData> suggestedAccount(String searchKey,String page, String limit) async {
    try {
      // Check if searchKey is empty and construct the full URL accordingly

      String suggestedURL = searchKey.isNotEmpty
          ? "/user/search-suggested?search=$searchKey&page=$page&limit=$limit"
          : "/user/search-suggested?&page=$page&limit=$limit";

      final response = await ApiService(token: getToken()).sendRequest.get(suggestedURL);
      return ResponseData(
          statusCode: response.statusCode,
          response: SuggestedAccountResponse.fromJson(response.data));
    } on DioException catch (e) {
      throw ErrorData(
          message: e.response!.data['msg'], code: e.response!.statusCode);
    } on Exception catch (_) {
      rethrow;
    }
  }*/




}
