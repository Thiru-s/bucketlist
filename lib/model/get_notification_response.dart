class GetNotificationResponse {
  final int? responseCode;
  final bool? success;
  final String? message;
  List<Data>? data;

  GetNotificationResponse({
    this.responseCode,
    this.success,
    this.message,
    this.data,
  });

  GetNotificationResponse.fromJson(Map<String, dynamic> json)
      : responseCode = json['responseCode'] as int?,
        success = json['success'] as bool?,
        message = json['message'] as String?,
        data = (json['data'] as List?)?.map((dynamic e) => Data.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'responseCode' : responseCode,
    'success' : success,
    'message' : message,
    'data' : data?.map((e) => e.toJson()).toList()
  };
}

class Data {
  final String? id;
  final String? userid;
  final String? description;
  final int? unreadFlag;
  final String? createdAt;
  final String? updatedAt;
  final int? v;
  final String? title;

  Data({
    this.id,
    this.userid,
    this.description,
    this.unreadFlag,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.title,
  });

  Data.fromJson(Map<String, dynamic> json)
      : id = json['_id'] as String?,
        userid = json['userid'] as String?,
        description = json['description'] as String?,
        unreadFlag = json['unread_flag'] as int?,
        createdAt = json['createdAt'] as String?,
        updatedAt = json['updatedAt'] as String?,
        v = json['__v'] as int?,
        title = json['title'] as String?;

  Map<String, dynamic> toJson() => {
    '_id' : id,
    'userid' : userid,
    'description' : description,
    'unread_flag' : unreadFlag,
    'createdAt' : createdAt,
    'updatedAt' : updatedAt,
    '__v' : v,
    'title' : title
  };
}