class VerifyOtpResponse {
  final int? responseCode;
  final bool? success;
  final String? message;
  final Data? data;

  VerifyOtpResponse({
    this.responseCode,
    this.success,
    this.message,
    this.data,
  });

  VerifyOtpResponse.fromJson(Map<String, dynamic> json)
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
  final String? accessToken;

  Data({
    this.accessToken,
  });

  Data.fromJson(Map<String, dynamic> json)
      : accessToken = json['accessToken'] as String?;

  Map<String, dynamic> toJson() => {
    'accessToken' : accessToken
  };
}