import 'package:whereisit/shared/enums/traits.enum.dart';

class ViewAllIntent {
  bool? isSuccess;
  final Traits traits;
  final dynamic value;

  ViewAllIntent({
    this.isSuccess,
    required this.traits,
    required this.value,
  });
}
