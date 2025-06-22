class FaqResponse {
  final int? responseCode;
  final bool? success;
  final String? message;
  final List<Data>? data;

  FaqResponse({
    this.responseCode,
    this.success,
    this.message,
    this.data,
  });

  FaqResponse.fromJson(Map<String, dynamic> json)
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
  final String? question;
  final String? answer;
  final String? priority;
  final String? createdAt;
  final String? updatedAt;

  Data({
    this.id,
    this.question,
    this.answer,
    this.priority,
    this.createdAt,
    this.updatedAt,
  });

  Data.fromJson(Map<String, dynamic> json)
      : id = json['_id'] as String?,
        question = json['question'] as String?,
        answer = json['answer'] as String?,
        priority = json['priority'] as String?,
        createdAt = json['createdAt'] as String?,
        updatedAt = json['updatedAt'] as String?;

  Map<String, dynamic> toJson() => {
    '_id' : id,
    'question' : question,
    'answer' : answer,
    'priority' : priority,
    'createdAt' : createdAt,
    'updatedAt' : updatedAt
  };
}