enum Status { loading, completed, error }

class DatabaseResponse<T> {
  Status status;
  T? data;
  String? message;

  DatabaseResponse.loading(this.message) : status = Status.loading;
  DatabaseResponse.completed(this.data) : status = Status.completed;
  DatabaseResponse.error(this.message) : status = Status.error;

  @override
  String toString() {
    return '''
        Status: $status,
        Message: ${message ?? ""},
        Data: ${data ?? ""}
    ''';
  }
}
