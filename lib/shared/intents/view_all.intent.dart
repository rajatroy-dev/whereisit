import 'package:whereisit/shared/enums/traits.enum.dart';

class ViewAllIntent {
  bool? isSuccess;
  final Traits traits;

  ViewAllIntent({
    this.isSuccess,
    required this.traits,
  });
}
