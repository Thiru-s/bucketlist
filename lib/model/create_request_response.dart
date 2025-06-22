class CreateRequestResponse {
  final int? responseCode;
  final bool? success;
  final String? message;
  final List<Data>? data;

  CreateRequestResponse({
    this.responseCode,
    this.success,
    this.message,
    this.data,
  });

  CreateRequestResponse.fromJson(Map<String, dynamic> json)
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
  final String? requestedDate;
  final String? isStatus;
  final String? purchaseOrder;
  final String? createdAt;
  final String? updatedAt;
  final int? requestIdPre;
  final String? requestId;
  final String? id;

  Data({
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
    this.requestedDate,
    this.isStatus,
    this.purchaseOrder,
    this.createdAt,
    this.updatedAt,
    this.requestIdPre,
    this.requestId,
    this.id,
  });

  Data.fromJson(Map<String, dynamic> json)
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
        requestedDate = json['requested_date'] as String?,
        isStatus = json['isStatus'] as String?,
        purchaseOrder = json['purchase_order'] as String?,
        createdAt = json['createdAt'] as String?,
        updatedAt = json['updatedAt'] as String?,
        requestIdPre = json['request_id_pre'] as int?,
        requestId = json['request_id'] as String?,
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
    'requested_date' : requestedDate,
    'isStatus' : isStatus,
    'purchase_order' : purchaseOrder,
    'createdAt' : createdAt,
    'updatedAt' : updatedAt,
    'request_id_pre' : requestIdPre,
    'request_id' : requestId,
    'id' : id
  };
}