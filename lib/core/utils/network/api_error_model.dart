class ApiErrorModel {
  String? message;
  int? code;
  Map<String, dynamic>? errors;

  ApiErrorModel({this.message, this.code, this.errors});

  factory ApiErrorModel.fromJson(Map<String, dynamic> json) {
    return ApiErrorModel(
      message: json['message'],
      code: json['code'],
      errors: json['errors'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'message': message, 'code': code, 'errors': errors};
  }

  @override
  String toString() {
    return "ApiErrorModel(message: $message , code: $code , errors: $errors)";
  }
}
