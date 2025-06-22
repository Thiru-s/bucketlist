
//part of 'spotsball_cubit.dart';

part of 'bucket_list_cubit.dart';

enum BucketListStatus {
  initial,

  signUpLoading,
  signUpSuccess,
  signUpError,

  registerVerifyOTPLoading,
  registerVerifyOTPSuccess,
  registerVerifyOTPError,

  resendVerifyOTPLoading,
  resendVerifyOTPSuccess,
  resendVerifyOTPError,

  signInLoading,
  signInSuccess,
  signInError,

  forgotPasswordLoading,
  forgotPasswordSuccess,
  forgotPasswordError,

  forgotOtpVerifyLoading,
  forgotOtpVerifySuccess,
  forgotOtpVerifyError,

  resetPasswordLoading,
  resetPasswordSuccess,
  resetPasswordError,

  personListLoading,
  personListSuccess,
  personListError,

  getServiceListLoading,
  getServiceListSuccess,
  getServiceListError,

  becomeAClientLoading,
  becomeAClientSuccess,
  becomeAClientError,

  getAllBucketLoading,
  getAllBucketSuccess,
  getAllBucketError,

  getBucketCategoriesLoading,
  getBucketCategoriesSuccess,
  getBucketCategoriesError,

  particularBucketCatLoading,
  particularBucketCatSuccess,
  particularBucketCatError,

  createRequestLoading,
  createRequestSuccess,
  createRequestError,

  getAllRequestLoading,
  getAllRequestSuccess,
  getAllRequestError,

  getProfileLoading,
  getProfileSuccess,
  getProfileError,

  updateProfileLoading,
  updateProfileSuccess,
  updateProfileError,

  termsAndConditionsLoading,
  termsAndConditionsSuccess,
  termsAndConditionsError,

  getInvoiceListLoading,
  getInvoiceListSuccess,
  getInvoiceListError,

  helpCenterLoading,
  helpCenterSuccess,
  helpCenterError,

  faqLoading,
  faqSuccess,
  faqError,

  notificationListLoading,
  notificationListSuccess,
  notificationListError,

  deleteAllNotificationLoading,
  deleteAllNotificationSuccess,
  deleteAllNotificationError,

  logoutLoading,
  logoutSuccess,
  logoutError,









}


class BucketListState extends Equatable {
  final BucketListStatus status;
  final ResponseData? responseData;
  final ErrorData? errorData;
  final String? error;

  const BucketListState({
    this.status = BucketListStatus.initial,
    this.responseData,
    this.errorData,
    this.error,

  });

  @override
  List<Object?> get props => [
    status,
    responseData,
    errorData,
    error,

  ];

  BucketListState copyWith({
    BucketListStatus? status,
    ResponseData? responseData,
    ErrorData? errorData,
    String? error,
    String? message,
  }) {
    return BucketListState(
      status: status ?? this.status,
      responseData: responseData ?? this.responseData,
      errorData: errorData ?? this.errorData,
      error: error ?? this.error,

    );
  }
}


