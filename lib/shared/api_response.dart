import 'dart:convert';

class ApiResponse {
  ApiResponse({
    required this.success,
    required this.error,
    required this.errorCode,
    required this.statusCode,
    required this.result,
  });

  final bool success;
  final String error;
  final int errorCode;
  final int statusCode;
  final dynamic result;

  factory ApiResponse.fromJson(String str) =>
      ApiResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ApiResponse.fromMap(Map<String, dynamic> json) => ApiResponse(
        success: json["success"],
        error: json["error"],
        errorCode: json["errorCode"],
        statusCode: json["statusCode"],
        result: json["result"],
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "error": error,
        "errorCode": errorCode,
        "statusCode": statusCode,
        "result": result,
      };
}
