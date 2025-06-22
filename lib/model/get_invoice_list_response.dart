class GetInvoiceListResponse {
  final String? message;
  final List<Data>? data;

  GetInvoiceListResponse({
    this.message,
    this.data,
  });

  GetInvoiceListResponse.fromJson(Map<String, dynamic> json)
      : message = json['message'] as String?,
        data = (json['data'] as List?)?.map((dynamic e) => Data.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'message' : message,
    'data' : data?.map((e) => e.toJson()).toList()
  };
}

class Data {
  final String? id;
  final String? invoice;
  final UserInfo? userInfo;
  final RequestInfo? requestInfo;
  final String? createdAt;
  final String? updatedAt;

  Data({
    this.id,
    this.invoice,
    this.userInfo,
    this.requestInfo,
    this.createdAt,
    this.updatedAt,
  });

  Data.fromJson(Map<String, dynamic> json)
      : id = json['_id'] as String?,
        invoice = json['invoice'] as String?,
        userInfo = (json['userInfo'] as Map<String,dynamic>?) != null ? UserInfo.fromJson(json['userInfo'] as Map<String,dynamic>) : null,
        requestInfo = (json['requestInfo'] as Map<String,dynamic>?) != null ? RequestInfo.fromJson(json['requestInfo'] as Map<String,dynamic>) : null,
        createdAt = json['createdAt'] as String?,
        updatedAt = json['updatedAt'] as String?;

  Map<String, dynamic> toJson() => {
    '_id' : id,
    'invoice' : invoice,
    'userInfo' : userInfo?.toJson(),
    'requestInfo' : requestInfo?.toJson(),
    'createdAt' : createdAt,
    'updatedAt' : updatedAt
  };
}

class UserInfo {
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

  UserInfo({
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

  UserInfo.fromJson(Map<String, dynamic> json)
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

class RequestInfo {
  final String? companyName;
  final String? companyEmployee;
  final String? jobTitle;
  final String? email;
  final String? phone;
  final String? workScope;
  final String? costCode;
  final String? bucketInfo;
  final String? userInfo;
  final String? client;
  final String? requestId;
  final String? requestedDate;
  final String? isStatus;
  final String? purchaseOrder;
  final String? createdAt;
  final String? updatedAt;
  final int? requestIdPre;
  final String? id;

  RequestInfo({
    this.companyName,
    this.companyEmployee,
    this.jobTitle,
    this.email,
    this.phone,
    this.workScope,
    this.costCode,
    this.bucketInfo,
    this.userInfo,
    this.client,
    this.requestId,
    this.requestedDate,
    this.isStatus,
    this.purchaseOrder,
    this.createdAt,
    this.updatedAt,
    this.requestIdPre,
    this.id,
  });

  RequestInfo.fromJson(Map<String, dynamic> json)
      : companyName = json['company_name'] as String?,
        companyEmployee = json['company_employee'] as String?,
        jobTitle = json['job_title'] as String?,
        email = json['email'] as String?,
        phone = json['phone'] as String?,
        workScope = json['work_scope'] as String?,
        costCode = json['cost_code'] as String?,
        bucketInfo = json['bucketInfo'] as String?,
        userInfo = json['userInfo'] as String?,
        client = json['client'] as String?,
        requestId = json['request_id'] as String?,
        requestedDate = json['requested_date'] as String?,
        isStatus = json['isStatus'] as String?,
        purchaseOrder = json['purchase_order'] as String?,
        createdAt = json['createdAt'] as String?,
        updatedAt = json['updatedAt'] as String?,
        requestIdPre = json['request_id_pre'] as int?,
        id = json['id'] as String?;

  Map<String, dynamic> toJson() => {
    'company_name' : companyName,
    'company_employee' : companyEmployee,
    'job_title' : jobTitle,
    'email' : email,
    'phone' : phone,
    'work_scope' : workScope,
    'cost_code' : costCode,
    'bucketInfo' : bucketInfo,
    'userInfo' : userInfo,
    'client' : client,
    'request_id' : requestId,
    'requested_date' : requestedDate,
    'isStatus' : isStatus,
    'purchase_order' : purchaseOrder,
    'createdAt' : createdAt,
    'updatedAt' : updatedAt,
    'request_id_pre' : requestIdPre,
    'id' : id
  };
}