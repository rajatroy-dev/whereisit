class ListItem {
  ListItem({
    required this.isNew,
    required this.item,
    this.value,
    this.isSelected,
  });

  final bool isNew;
  final String item;
  final String? value;
  final bool? isSelected;
}
