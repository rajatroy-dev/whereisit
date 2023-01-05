class MultiSelectDropdownData {
  MultiSelectDropdownData(
    this.id,
    this.isSelected,
    this.value,
  );

  final String id;
  bool isSelected;
  final String value;

  static MultiSelectDropdownData copyWith(
    String id,
    bool isSelected,
    String value,
  ) =>
      MultiSelectDropdownData(
        id,
        isSelected,
        value,
      );
}
