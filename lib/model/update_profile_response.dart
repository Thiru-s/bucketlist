class UpdateProfileResponse {
  final int? responseCode;
  final bool? success;
  final String? message;
  final Data? data;

  UpdateProfileResponse({
    this.responseCode,
    this.success,
    this.message,
    this.data,
  });

  UpdateProfileResponse.fromJson(Map<String, dynamic> json)
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
  final String? id;
  final String? name;
  final String? companyName;
  final String? position;
  final String? email;
  final String? phone;
  final String? image;
  final String? password;
  final String? isStatus;
  final String? role;
  final String? fcmToken;
  final String? createdAt;
  final String? updatedAt;

  Data({
    this.id,
    this.name,
    this.companyName,
    this.position,
    this.email,
    this.phone,
    this.image,
    this.password,
    this.isStatus,
    this.role,
    this.fcmToken,
    this.createdAt,
    this.updatedAt,
  });

  Data.fromJson(Map<String, dynamic> json)
      : id = json['_id'] as String?,
        name = json['name'] as String?,
        companyName = json['company_name'] as String?,
        position = json['position'] as String?,
        email = json['email'] as String?,
        phone = json['phone'] as String?,
        image = json['image'] as String?,
        password = json['password'] as String?,
        isStatus = json['isStatus'] as String?,
        role = json['role'] as String?,
        fcmToken = json['fcmToken'] as String?,
        createdAt = json['createdAt'] as String?,
        updatedAt = json['updatedAt'] as String?;

  Map<String, dynamic> toJson() => {
    '_id' : id,
    'name' : name,
    'company_name' : companyName,
    'position' : position,
    'email' : email,
    'phone' : phone,
    'image' : image,
    'password' : password,
    'isStatus' : isStatus,
    'role' : role,
    'fcmToken' : fcmToken,
    'createdAt' : createdAt,
    'updatedAt' : updatedAt
  };
}