class GetServiceListResponse {
  final bool? success;
  final String? message;
  final List<Data>? data;

  GetServiceListResponse({
    this.success,
    this.message,
    this.data,
  });

  GetServiceListResponse.fromJson(Map<String, dynamic> json)
      : success = json['success'] as bool?,
        message = json['message'] as String?,
        data = (json['data'] as List?)?.map((dynamic e) => Data.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'success' : success,
    'message' : message,
    'data' : data?.map((e) => e.toJson()).toList()
  };
}

class Data {
  final String? id;
  final String? name;
  final String? color;
  final List<String>? subcategories;
  final String? status;
  final String? createdAt;
  final String? updatedAt;

  Data({
    this.id,
    this.name,
    this.color,
    this.subcategories,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  Data.fromJson(Map<String, dynamic> json)
      : id = json['_id'] as String?,
        name = json['name'] as String?,
        color = json['color'] as String?,
        subcategories = (json['subcategories'] as List?)?.map((dynamic e) => e as String).toList(),
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