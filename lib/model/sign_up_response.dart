class SignUpResponse {
  final bool? success;
  final String? message;
  final Data? data;

  SignUpResponse({
    this.success,
    this.message,
    this.data,
  });

  SignUpResponse.fromJson(Map<String, dynamic> json)
      : success = json['success'] as bool?,
        message = json['message'] as String?,
        data = (json['data'] as Map<String,dynamic>?) != null ? Data.fromJson(json['data'] as Map<String,dynamic>) : null;

  Map<String, dynamic> toJson() => {
    'success' : success,
    'message' : message,
    'data' : data?.toJson()
  };
}

class Data {
  final String? otp;
  final String? accessToken;

  Data({
    this.otp,
    this.accessToken,
  });

  Data.fromJson(Map<String, dynamic> json)
      : otp = json['otp'] as String?,
        accessToken = json['accessToken'] as String?;

  Map<String, dynamic> toJson() => {
    'otp' : otp,
    'accessToken' : accessToken
  };
}