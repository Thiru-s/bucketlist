
import 'dart:io';

import 'package:bucket_list_flutter/repository/bucket_list_respository.dart';
import 'package:bucket_list_flutter/repository/response_status.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


part 'bucket_list_state.dart';





class BucketListCubit extends Cubit<BucketListState> {
  final BucketListRepository repository;

  BucketListCubit(this.repository) : super(const BucketListState());


  Future<void> signUpCall(Map<String,dynamic> signUpDetails) async{
    emit(state.copyWith(status: BucketListStatus.signUpLoading));
    try{
      ResponseData responseData = await repository.signUp(signUpDetails);
      emit(state.copyWith(status: BucketListStatus.signUpSuccess,responseData: responseData));
    }
    on ErrorData catch (errorData){
      emit(state.copyWith(status: BucketListStatus.signUpError,errorData: errorData,error: null));
    }
    catch(e){
      emit(state.copyWith(status: BucketListStatus.signUpError,error: e.toString(),errorData: null));
    }
  }

  Future<void> signInCall(Map<String,dynamic> signUpDetails) async{
    emit(state.copyWith(status: BucketListStatus.signInLoading));
    try{
      ResponseData responseData = await repository.signIn(signUpDetails);
      emit(state.copyWith(status: BucketListStatus.signInSuccess,responseData: responseData));
    }
    on ErrorData catch (errorData){
      emit(state.copyWith(status: BucketListStatus.signInError,errorData: errorData,error: null));
    }
    catch(e){
      emit(state.copyWith(status: BucketListStatus.signInError,error: e.toString(),errorData: null));
    }
  }
  Future<void> registerOTPVerifyCall(String otp,String token) async{
    emit(state.copyWith(status: BucketListStatus.registerVerifyOTPLoading));
    try{
      ResponseData responseData = await repository.registerOTPVerify(otp,token);
      emit(state.copyWith(status: BucketListStatus.registerVerifyOTPSuccess,responseData: responseData));
    }
    on ErrorData catch (errorData){
      emit(state.copyWith(status: BucketListStatus.registerVerifyOTPError,errorData: errorData,error: null));
    }
    catch(e){
      emit(state.copyWith(status: BucketListStatus.registerVerifyOTPError,error: e.toString(),errorData: null));
    }
  }
  Future<void> forgotPasswordCall(String emailOrPhone) async {
    emit(state.copyWith(status: BucketListStatus.forgotPasswordLoading));
    try {
      ResponseData response = await repository.forgotPassword(emailOrPhone);
      emit(state.copyWith(status: BucketListStatus.forgotPasswordSuccess, responseData: response));
    }
    on ErrorData catch (errorData) {
      emit(state.copyWith(status: BucketListStatus.forgotPasswordError, errorData: errorData, error: null));
    }
    catch (e) {
      emit(state.copyWith(status: BucketListStatus.forgotPasswordError, error: e.toString(), errorData: null));
    }
  }

  Future<void> resetPasswordCall(String token,String newPassword) async{
    emit(state.copyWith(status: BucketListStatus.resetPasswordLoading));
    try{
      ResponseData responseData = await repository.resetPassword(token, newPassword);
      emit(state.copyWith(status: BucketListStatus.resetPasswordSuccess,responseData: responseData));
    }
    on ErrorData catch (errorData){
      emit(state.copyWith(status: BucketListStatus.resetPasswordError,errorData: errorData,error: null));
    }
    catch(e){
      emit(state.copyWith(status: BucketListStatus.resetPasswordError,error: e.toString(),errorData: null));
    }
  }

  Future<void> resendVerifyOTPCall(String token) async{
    emit(state.copyWith(status: BucketListStatus.resendVerifyOTPLoading));
    try{
      ResponseData responseData = await repository.resendVerifyOtp(token);
      emit(state.copyWith(status: BucketListStatus.resendVerifyOTPSuccess,responseData: responseData));
    }
    on ErrorData catch (errorData){
      emit(state.copyWith(status: BucketListStatus.resendVerifyOTPError,errorData: errorData,error: null));
    }
    catch(e){
      emit(state.copyWith(status: BucketListStatus.resendVerifyOTPError,error: e.toString(),errorData: null));
    }
  }

  Future<void> personListCall() async{
    emit(state.copyWith(status: BucketListStatus.personListLoading));
    try{
      ResponseData responseData = await repository.personList();
      emit(state.copyWith(status: BucketListStatus.personListSuccess,responseData: responseData));
    }
    on ErrorData catch (errorData){
      emit(state.copyWith(status: BucketListStatus.personListError,errorData: errorData,error: null));
    }
    catch(e){
      emit(state.copyWith(status: BucketListStatus.personListError,error: e.toString(),errorData: null));
    }
  }

  Future<void> getServiceListCall() async{
    emit(state.copyWith(status: BucketListStatus.getServiceListLoading));
    try{
      ResponseData responseData = await repository.getServiceList();
      emit(state.copyWith(status: BucketListStatus.getServiceListSuccess,responseData: responseData));
    }
    on ErrorData catch (errorData){
      emit(state.copyWith(status: BucketListStatus.getServiceListError,errorData: errorData,error: null));
    }
    catch(e){
      emit(state.copyWith(status: BucketListStatus.getServiceListError,error: e.toString(),errorData: null));
    }
  }

  Future<void> becomeAClient(Map<String,dynamic> clientDetails) async{
    emit(state.copyWith(status: BucketListStatus.becomeAClientLoading));
    try{
      ResponseData responseData = await repository.becomeAClient(clientDetails);
      emit(state.copyWith(status: BucketListStatus.becomeAClientSuccess,responseData: responseData));
    }
    on ErrorData catch (errorData){
      emit(state.copyWith(status: BucketListStatus.becomeAClientError,errorData: errorData,error: null));
    }
    catch(e){
      emit(state.copyWith(status: BucketListStatus.becomeAClientError,error: e.toString(),errorData: null));
    }
  }

  Future<void> getAllBucketCall() async{
    emit(state.copyWith(status: BucketListStatus.getAllBucketLoading));
    try{
      ResponseData responseData = await repository.getAllBucket();
      emit(state.copyWith(status: BucketListStatus.getAllBucketSuccess,responseData: responseData));
    }
    on ErrorData catch (errorData){
      emit(state.copyWith(status: BucketListStatus.getAllBucketError,errorData: errorData,error: null));
    }
    catch(e){
      emit(state.copyWith(status: BucketListStatus.getAllBucketError,error: e.toString(),errorData: null));
    }
  }

  Future<void> getBucketCategoriesCall() async{
    emit(state.copyWith(status: BucketListStatus.getBucketCategoriesLoading));
    try{
      ResponseData responseData = await repository.getBucketCategories();
      emit(state.copyWith(status: BucketListStatus.getBucketCategoriesSuccess,responseData: responseData));
    }
    on ErrorData catch (errorData){
      emit(state.copyWith(status: BucketListStatus.getBucketCategoriesError,errorData: errorData,error: null));
    }
    catch(e){
      emit(state.copyWith(status: BucketListStatus.getBucketCategoriesError,error: e.toString(),errorData: null));
    }
  }

  Future<void> particularBucketCatCall(String bucketId) async{
    emit(state.copyWith(status: BucketListStatus.particularBucketCatLoading));
    try{
      ResponseData responseData = await repository.particularBucketCat(bucketId);
      emit(state.copyWith(status: BucketListStatus.particularBucketCatSuccess,responseData: responseData));
    }
    on ErrorData catch (errorData){
      emit(state.copyWith(status: BucketListStatus.particularBucketCatError,errorData: errorData,error: null));
    }
    catch(e){
      emit(state.copyWith(status: BucketListStatus.particularBucketCatError,error: e.toString(),errorData: null));
    }
  }

  Future<void> createRequestCall(Map<String, dynamic> createReqDetails) async {
    emit(state.copyWith(status: BucketListStatus.createRequestLoading));
    try{
      ResponseData responseData = await repository.createRequest(createReqDetails);
      emit(state.copyWith(status: BucketListStatus.createRequestSuccess,responseData: responseData));
    }
    on ErrorData catch (errorData){
      emit(state.copyWith(status: BucketListStatus.createRequestError,errorData: errorData,error: null));
    }
    catch(e){
      emit(state.copyWith(status: BucketListStatus.createRequestError,error: e.toString(),errorData: null));
    }
  }

  Future<void> getAllRequestCall() async {
    emit(state.copyWith(status: BucketListStatus.getAllRequestLoading));
    try{
      ResponseData responseData = await repository.getAllRequest();
      emit(state.copyWith(status: BucketListStatus.getAllRequestSuccess,responseData: responseData));
    }
    on ErrorData catch (errorData){
      emit(state.copyWith(status: BucketListStatus.getAllRequestError,errorData: errorData,error: null));
    }
    catch(e){
      emit(state.copyWith(status: BucketListStatus.getAllRequestError,error: e.toString(),errorData: null));
    }
  }

  Future<void> getProfileCall() async {
    emit(state.copyWith(status: BucketListStatus.getProfileLoading));
    try{
      ResponseData responseData = await repository.getProfile();
      emit(state.copyWith(status: BucketListStatus.getProfileSuccess,responseData: responseData));
    }
    on ErrorData catch (errorData){
      emit(state.copyWith(status: BucketListStatus.getProfileSuccess,errorData: errorData,error: null));
    }
    catch(e){
      emit(state.copyWith(status: BucketListStatus.getProfileError,error: e.toString(),errorData: null));
    }
  }
  Future<void> updateProfileCall(String name,String email, String position,String companyName,String phone, File? image) async {
    emit(state.copyWith(status: BucketListStatus.updateProfileLoading));
    try{
      ResponseData responseData = await repository.updateProfile(name, email, position, companyName, phone, image);
      emit(state.copyWith(status: BucketListStatus.updateProfileSuccess,responseData: responseData));
    }
    on ErrorData catch (errorData){
      emit(state.copyWith(status: BucketListStatus.updateProfileError,errorData: errorData,error: null));
    }
    catch(e){
      emit(state.copyWith(status: BucketListStatus.updateProfileError,error: e.toString(),errorData: null));
    }
  }

  Future<void> termsAndConditionsCall() async {
    emit(state.copyWith(status: BucketListStatus.termsAndConditionsLoading));
    try{
      ResponseData responseData = await repository.termsAndConditions();
      emit(state.copyWith(status: BucketListStatus.termsAndConditionsSuccess,responseData: responseData));
    }
    on ErrorData catch (errorData){
      emit(state.copyWith(status: BucketListStatus.termsAndConditionsError,errorData: errorData,error: null));
    }
    catch(e){
      emit(state.copyWith(status: BucketListStatus.termsAndConditionsError,error: e.toString(),errorData: null));
    }
  }

  Future<void> getInvoiceListCall() async {
    emit(state.copyWith(status: BucketListStatus.getInvoiceListLoading));
    try{
      ResponseData responseData = await repository.getInvoiceList();
      emit(state.copyWith(status: BucketListStatus.getInvoiceListSuccess,responseData: responseData));
    }
    on ErrorData catch (errorData){
      emit(state.copyWith(status: BucketListStatus.getInvoiceListError,errorData: errorData,error: null));
    }
    catch(e){
      emit(state.copyWith(status: BucketListStatus.getInvoiceListError,error: e.toString(),errorData: null));
    }
  }

  Future<void> helpCenterCall(Map<String,dynamic> queryHelpDetails) async{
    emit(state.copyWith(status: BucketListStatus.helpCenterLoading));
    try{
      ResponseData responseData = await repository.helpCenter(queryHelpDetails);
      emit(state.copyWith(status: BucketListStatus.helpCenterSuccess,responseData: responseData));
    }
    on ErrorData catch (errorData){
      emit(state.copyWith(status: BucketListStatus.helpCenterError,errorData: errorData,error: null));
    }
    catch(e){
      emit(state.copyWith(status: BucketListStatus.helpCenterError,error: e.toString(),errorData: null));
    }
  }

  Future<void> faqCall() async{
    emit(state.copyWith(status: BucketListStatus.faqLoading));
    try{
      ResponseData responseData = await repository.faq();
      emit(state.copyWith(status: BucketListStatus.faqSuccess,responseData: responseData));
    }
    on ErrorData catch (errorData){
      emit(state.copyWith(status: BucketListStatus.faqError,errorData: errorData,error: null));
    }
    catch(e){
      emit(state.copyWith(status: BucketListStatus.faqError,error: e.toString(),errorData: null));
    }
  }

  Future<void> notificationListCall() async{
    emit(state.copyWith(status: BucketListStatus.notificationListLoading));
    try{
      ResponseData responseData = await repository.notificationList();
      emit(state.copyWith(status: BucketListStatus.notificationListSuccess,responseData: responseData));
    }
    on ErrorData catch (errorData){
      emit(state.copyWith(status: BucketListStatus.notificationListError,errorData: errorData,error: null));
    }
    catch(e){
      emit(state.copyWith(status: BucketListStatus.notificationListError,error: e.toString(),errorData: null));
    }
  }
  Future<void> deleteAllNotificationCall() async{
    emit(state.copyWith(status: BucketListStatus.deleteAllNotificationLoading));
    try{
      ResponseData responseData = await repository.deleteAllNotification();
      emit(state.copyWith(status: BucketListStatus.deleteAllNotificationSuccess,responseData: responseData));
    }
    on ErrorData catch (errorData){
      emit(state.copyWith(status: BucketListStatus.deleteAllNotificationError,errorData: errorData,error: null));
    }
    catch(e){
      emit(state.copyWith(status: BucketListStatus.deleteAllNotificationError,error: e.toString(),errorData: null));
    }
  }

  Future<void> logoutCall() async{
    emit(state.copyWith(status: BucketListStatus.logoutLoading));
    try{
      ResponseData responseData = await repository.logout();
      emit(state.copyWith(status: BucketListStatus.logoutSuccess,responseData: responseData));
    }
    on ErrorData catch (errorData){
      emit(state.copyWith(status: BucketListStatus.logoutError,errorData: errorData,error: null));
    }
    catch(e){
      emit(state.copyWith(status: BucketListStatus.logoutError,error: e.toString(),errorData: null));
    }
  }




}
