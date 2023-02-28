class InputValidator {
  static String? quantity(String? value) {
    if (value == null ||
        value.isEmpty ||
        double.tryParse(value) == null ||
        double.parse(value) <= 0) {
      return 'Invalid quantity';
    }
    return null;
  }

  static String? name(String? value) {
    var regex = RegExp(r'^[A-Za-z ]+$');
    if (value == null || value.isEmpty || !regex.hasMatch(value)) {
      return 'Invalid name';
    }
    return null;
  }

  static String? address(String? value) {
    var regex = RegExp(r'^[A-Za-z0-9 /,-]+$');
    if (value == null || value.isEmpty || !regex.hasMatch(value)) {
      return 'Invalid name';
    }
    return null;
  }
}
