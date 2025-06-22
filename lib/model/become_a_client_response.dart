class BecomeAClientResponse {
  final int? responseCode;
  final bool? success;
  final String? message;
  final Data? data;

  BecomeAClientResponse({
    this.responseCode,
    this.success,
    this.message,
    this.data,
  });

  BecomeAClientResponse.fromJson(Map<String, dynamic> json)
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
  final String? name;
  final String? companyName;
  final String? email;
  final String? phone;
  final String? website;
  final String? category;
  final String? jobTitle;
  final String? password;
  final String? cityZip;
  final String? companyInformation;
  final String? isApproved;
  final String? salesPerson;
  final String? address;
  final String? isStatus;
  final String? profilePic;
  final String? id;
  final String? createdAt;
  final String? updatedAt;

  Data({
    this.name,
    this.companyName,
    this.email,
    this.phone,
    this.website,
    this.category,
    this.jobTitle,
    this.password,
    this.cityZip,
    this.companyInformation,
    this.isApproved,
    this.salesPerson,
    this.address,
    this.isStatus,
    this.profilePic,
    this.id,
    this.createdAt,
    this.updatedAt,
  });

  Data.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String?,
        companyName = json['company_name'] as String?,
        email = json['email'] as String?,
        phone = json['phone'] as String?,
        website = json['website'] as String?,
        category = json['category'] as String?,
        jobTitle = json['job_title'] as String?,
        password = json['password'] as String?,
        cityZip = json['city_zip'] as String?,
        companyInformation = json['company_information'] as String?,
        isApproved = json['isApproved'] as String?,
        salesPerson = json['sales_person'] as String?,
        address = json['address'] as String?,
        isStatus = json['isStatus'] as String?,
        profilePic = json['profile_pic'] as String?,
        id = json['_id'] as String?,
        createdAt = json['createdAt'] as String?,
        updatedAt = json['updatedAt'] as String?;

  Map<String, dynamic> toJson() => {
    'name' : name,
    'company_name' : companyName,
    'email' : email,
    'phone' : phone,
    'website' : website,
    'category' : category,
    'job_title' : jobTitle,
    'password' : password,
    'city_zip' : cityZip,
    'company_information' : companyInformation,
    'isApproved' : isApproved,
    'sales_person' : salesPerson,
    'address' : address,
    'isStatus' : isStatus,
    'profile_pic' : profilePic,
    '_id' : id,
    'createdAt' : createdAt,
    'updatedAt' : updatedAt
  };
}