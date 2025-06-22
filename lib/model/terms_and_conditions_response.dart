class TermsAndConditionsResponse {
  final bool? success;
  final String? message;
  final List<Data>? data;

  TermsAndConditionsResponse({
    this.success,
    this.message,
    this.data,
  });

  TermsAndConditionsResponse.fromJson(Map<String, dynamic> json)
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
  final String? type;
  final String? content;
  final String? createdAt;
  final String? updatedAt;

  Data({
    this.id,
    this.type,
    this.content,
    this.createdAt,
    this.updatedAt,
  });

  Data.fromJson(Map<String, dynamic> json)
      : id = json['_id'] as String?,
        type = json['type'] as String?,
        content = json['content'] as String?,
        createdAt = json['createdAt'] as String?,
        updatedAt = json['updatedAt'] as String?;

  Map<String, dynamic> toJson() => {
    '_id' : id,
    'type' : type,
    'content' : content,
    'createdAt' : createdAt,
    'updatedAt' : updatedAt
  };
}