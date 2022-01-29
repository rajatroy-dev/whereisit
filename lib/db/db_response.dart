enum Status { loading, completed, error }

class DBResponse<T> {
  Status status;
  T? data;
  String? message;

  DBResponse.loading(this.message) : status = Status.loading;
  DBResponse.completed(this.data) : status = Status.completed;
  DBResponse.error(this.message) : status = Status.error;

  @override
  String toString() {
    return 'Status: $status \n'
        'Message: ${message ?? ''} \n'
        'Data: ${data ?? ''}';
  }
}
