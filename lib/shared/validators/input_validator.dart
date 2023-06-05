class InputValidator {
  final addressRegex = RegExp(r'^[A-Za-z0-9 /,-]*$');

  String? quantity(String? value) {
    if (value == null ||
        value.isEmpty ||
        double.tryParse(value) == null ||
        double.parse(value) <= 0) {
      return 'Invalid quantity';
    }
    return null;
  }

  String? name(String? value) {
    var regex = RegExp(r'^[A-Za-z ]+$');
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }
    if (!regex.hasMatch(value)) {
      return 'Invalid name';
    }

    return null;
  }

  String? address(String? value) {
    var regex = addressRegex;
    if (value != null && !regex.hasMatch(value)) {
      return 'Invalid address';
    }
    return null;
  }

  String? property(String? value) {
    var regex = addressRegex;
    if (value != null && !regex.hasMatch(value)) {
      return 'Invalid property';
    }
    return null;
  }

  String? room(String? value) {
    var regex = addressRegex;
    if (value != null && !regex.hasMatch(value)) {
      return 'Invalid room';
    }
    return null;
  }
}
