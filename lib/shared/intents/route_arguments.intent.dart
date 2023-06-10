class RouteArguments {
  final bool hasParams;
  Map<String, String>? params;

  RouteArguments({
    required this.hasParams,
    this.params,
  });
}
