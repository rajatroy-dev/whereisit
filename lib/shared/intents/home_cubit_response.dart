import 'package:whereisit/shared/enums/items_type.enum.dart';

class HomeBlocResponse {
  final Map<ItemsType, bool> success;
  final Map<ItemsType, String> error;
  final Map<ItemsType, String> errorCode;
  final Map<ItemsType, int> statusCode;
  final Map<ItemsType, dynamic> result;

  HomeBlocResponse(
    this.error,
    this.result,
    this.success,
    this.errorCode,
    this.statusCode,
  );
}
