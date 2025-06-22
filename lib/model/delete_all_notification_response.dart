class DeleteAllNotificationResponse {
  final int? responseCode;
  final bool? success;
  final String? message;
  final Data? data;

  DeleteAllNotificationResponse({
    this.responseCode,
    this.success,
    this.message,
    this.data,
  });

  DeleteAllNotificationResponse.fromJson(Map<String, dynamic> json)
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
  final bool? acknowledged;
  final int? deletedCount;

  Data({
    this.acknowledged,
    this.deletedCount,
  });

  Data.fromJson(Map<String, dynamic> json)
      : acknowledged = json['acknowledged'] as bool?,
        deletedCount = json['deletedCount'] as int?;

  Map<String, dynamic> toJson() => {
    'acknowledged' : acknowledged,
    'deletedCount' : deletedCount
  };
}