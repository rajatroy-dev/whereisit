import 'package:whereisit/shared/enums/items_type.enum.dart';

class HomeCubitResponse {
  final Map<ItemsType, bool> success;
  final Map<ItemsType, String> error;
  final Map<ItemsType, String> errorCode;
  final Map<ItemsType, int> statusCode;
  final Map<ItemsType, dynamic> result;

  HomeCubitResponse(
    this.error,
    this.result,
    this.success,
    this.errorCode,
    this.statusCode,
  );
}
