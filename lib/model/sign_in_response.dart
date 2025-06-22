class SignInResponse {
  final int? responseCode;
  final bool? success;
  final String? message;
  final Data? data;

  SignInResponse({
    this.responseCode,
    this.success,
    this.message,
    this.data,
  });

  SignInResponse.fromJson(Map<String, dynamic> json)
      : responseCode = json['responseCode'] as int?,
        success = json['success'] as bool?,
        message = json['message'] as String?,
        data = (json['data'] as Map<String,dynamic>?) != null ? Data.fromJson(json['data'] as Map<String,dynamic>) : null;

  Map<String, dynamic> toJson() => {
    'responseCode' : responseCode,
    'success' : success,
    'message' : message,
    'data' : data?.toJson()
  };
}

class Data {
  final String? otp;
  final String? accessToken;
  final String? isStatus;

  Data({
    this.otp,
    this.accessToken,
    this.isStatus,
  });

  Data.fromJson(Map<String, dynamic> json)
      : otp = json['otp'] as String?,
        accessToken = json['accessToken'] as String?,
        isStatus = json['isStatus'] as String?;

  Map<String, dynamic> toJson() => {
    'otp' : otp,
    'accessToken' : accessToken,
    'isStatus' : isStatus
  };
}