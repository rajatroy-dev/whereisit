class HomeCubitResponse {
  final Map<String, bool> success;
  final Map<String, String> error;
  final Map<String, String> errorCode;
  final Map<String, int> statusCode;
  final Map<String, dynamic> result;

  HomeCubitResponse(
    this.error,
    this.result,
    this.success,
    this.errorCode,
    this.statusCode,
  );
}
