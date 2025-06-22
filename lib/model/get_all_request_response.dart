class GetAllRequestResponse {
  final int? responseCode;
  final bool? success;
  final String? message;
  final List<Data>? data;

  GetAllRequestResponse({
    this.responseCode,
    this.success,
    this.message,
    this.data,
  });

  GetAllRequestResponse.fromJson(Map<String, dynamic> json)
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
  final String? companyName;
  final String? companyEmployee;
  final String? jobTitle;
  final String? email;
  final String? phone;
  final String? workScope;
  final String? costCode;
  final BucketInfo? bucketInfo;
  final String? userInfo;
  final Client? client;
  final String? requestId;
  final String? requestedDate;
  final String? isStatus;
  final String? purchaseOrder;
  final String? createdAt;
  final String? updatedAt;
  final int? requestIdPre;
  final List<Invoices>? invoices;

  Data({
    this.id,
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
    this.invoices,
  });

  Data.fromJson(Map<String, dynamic> json)
    : id = json['_id'] as String?,
      companyName = json['company_name'] as String?,
      companyEmployee = json['company_employee'] as String?,
      jobTitle = json['job_title'] as String?,
      email = json['email'] as String?,
      phone = json['phone'] as String?,
      workScope = json['work_scope'] as String?,
      costCode = json['cost_code'] as String?,
      bucketInfo = (json['bucketInfo'] as Map<String,dynamic>?) != null ? BucketInfo.fromJson(json['bucketInfo'] as Map<String,dynamic>) : null,
      userInfo = json['userInfo'] as String?,
      client = (json['client'] as Map<String,dynamic>?) != null ? Client.fromJson(json['client'] as Map<String,dynamic>) : null,
      requestId = json['request_id'] as String?,
      requestedDate = json['requested_date'] as String?,
      isStatus = json['isStatus'] as String?,
      purchaseOrder = json['purchase_order'] as String?,
      createdAt = json['createdAt'] as String?,
      updatedAt = json['updatedAt'] as String?,
      requestIdPre = json['request_id_pre'] as int?,
      invoices = (json['invoices'] as List?)?.map((dynamic e) => Invoices.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    '_id' : id,
    'company_name' : companyName,
    'company_employee' : companyEmployee,
    'job_title' : jobTitle,
    'email' : email,
    'phone' : phone,
    'work_scope' : workScope,
    'cost_code' : costCode,
    'bucketInfo' : bucketInfo?.toJson(),
    'userInfo' : userInfo,
    'client' : client?.toJson(),
    'request_id' : requestId,
    'requested_date' : requestedDate,
    'isStatus' : isStatus,
    'purchase_order' : purchaseOrder,
    'createdAt' : createdAt,
    'updatedAt' : updatedAt,
    'request_id_pre' : requestIdPre,
    'invoices' : invoices?.map((e) => e.toJson()).toList()
  };
}

class BucketInfo {
  final String? id;
  final String? name;
  final Category? category;
  final String? description;
  final String? price;
  final String? client;
  final String? color;
  final List<dynamic>? subcategories;
  final String? catStatus;
  final String? createdAt;
  final String? updatedAt;

  BucketInfo({
    this.id,
    this.name,
    this.category,
    this.description,
    this.price,
    this.client,
    this.color,
    this.subcategories,
    this.catStatus,
    this.createdAt,
    this.updatedAt,
  });

  BucketInfo.fromJson(Map<String, dynamic> json)
    : id = json['_id'] as String?,
      name = json['name'] as String?,
      category = (json['category'] as Map<String,dynamic>?) != null ? Category.fromJson(json['category'] as Map<String,dynamic>) : null,
      description = json['description'] as String?,
      price = json['price'] as String?,
      client = json['client'] as String?,
      color = json['color'] as String?,
      subcategories = json['subcategories'] as List?,
      catStatus = json['catStatus'] as String?,
      createdAt = json['createdAt'] as String?,
      updatedAt = json['updatedAt'] as String?;

  Map<String, dynamic> toJson() => {
    '_id' : id,
    'name' : name,
    'category' : category?.toJson(),
    'description' : description,
    'price' : price,
    'client' : client,
    'color' : color,
    'subcategories' : subcategories,
    'catStatus' : catStatus,
    'createdAt' : createdAt,
    'updatedAt' : updatedAt
  };
}

class Category {
  final String? id;
  final String? name;
  final String? color;
  final List<dynamic>? subcategories;
  final String? status;
  final String? createdAt;
  final String? updatedAt;

  Category({
    this.id,
    this.name,
    this.color,
    this.subcategories,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  Category.fromJson(Map<String, dynamic> json)
    : id = json['_id'] as String?,
      name = json['name'] as String?,
      color = json['color'] as String?,
      subcategories = json['subcategories'] as List?,
      status = json['status'] as String?,
      createdAt = json['createdAt'] as String?,
      updatedAt = json['updatedAt'] as String?;

  Map<String, dynamic> toJson() => {
    '_id' : id,
    'name' : name,
    'color' : color,
    'subcategories' : subcategories,
    'status' : status,
    'createdAt' : createdAt,
    'updatedAt' : updatedAt
  };
}

class Client {
  final String? id;
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
  final String? createdAt;
  final String? updatedAt;

  Client({
    this.id,
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
    this.createdAt,
    this.updatedAt,
  });

  Client.fromJson(Map<String, dynamic> json)
    : id = json['_id'] as String?,
      name = json['name'] as String?,
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
      createdAt = json['createdAt'] as String?,
      updatedAt = json['updatedAt'] as String?;

  Map<String, dynamic> toJson() => {
    '_id' : id,
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
    'createdAt' : createdAt,
    'updatedAt' : updatedAt
  };
}

class Invoices {
  final String? id;
  final String? invoice;
  final String? userInfo;
  final String? requestInfo;
  final String? createdAt;
  final String? updatedAt;

  Invoices({
    this.id,
    this.invoice,
    this.userInfo,
    this.requestInfo,
    this.createdAt,
    this.updatedAt,
  });

  Invoices.fromJson(Map<String, dynamic> json)
    : id = json['_id'] as String?,
      invoice = json['invoice'] as String?,
      userInfo = json['userInfo'] as String?,
      requestInfo = json['requestInfo'] as String?,
      createdAt = json['createdAt'] as String?,
      updatedAt = json['updatedAt'] as String?;

  Map<String, dynamic> toJson() => {
    '_id' : id,
    'invoice' : invoice,
    'userInfo' : userInfo,
    'requestInfo' : requestInfo,
    'createdAt' : createdAt,
    'updatedAt' : updatedAt
  };
}