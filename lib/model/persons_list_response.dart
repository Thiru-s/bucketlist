class PersonsListResponse {
  final int? responseCode;
  final bool? success;
  final String? message;
  final List<Data>? data;

  PersonsListResponse({
    this.responseCode,
    this.success,
    this.message,
    this.data,
  });

  PersonsListResponse.fromJson(Map<String, dynamic> json)
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
  final String? firstname;
  final String? lastname;
  final String? email;
  final String? password;
  final String? phone;
  final String? profilePic;
  final String? isStatus;
  final String? createdAt;
  final String? updatedAt;
  final int? employeeIdPre;
  final String? employeeId;

  Data({
    this.id,
    this.firstname,
    this.lastname,
    this.email,
    this.password,
    this.phone,
    this.profilePic,
    this.isStatus,
    this.createdAt,
    this.updatedAt,
    this.employeeIdPre,
    this.employeeId,
  });

  Data.fromJson(Map<String, dynamic> json)
      : id = json['_id'] as String?,
        firstname = json['firstname'] as String?,
        lastname = json['lastname'] as String?,
        email = json['email'] as String?,
        password = json['password'] as String?,
        phone = json['phone'] as String?,
        profilePic = json['profile_pic'] as String?,
        isStatus = json['isStatus'] as String?,
        createdAt = json['createdAt'] as String?,
        updatedAt = json['updatedAt'] as String?,
        employeeIdPre = json['employee_id_pre'] as int?,
        employeeId = json['employee_id'] as String?;

  Map<String, dynamic> toJson() => {
    '_id' : id,
    'firstname' : firstname,
    'lastname' : lastname,
    'email' : email,
    'password' : password,
    'phone' : phone,
    'profile_pic' : profilePic,
    'isStatus' : isStatus,
    'createdAt' : createdAt,
    'updatedAt' : updatedAt,
    'employee_id_pre' : employeeIdPre,
    'employee_id' : employeeId,
  };
}