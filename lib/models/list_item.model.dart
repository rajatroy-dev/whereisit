class ListItem {
  ListItem({
    required this.isAddable,
    required this.item,
    this.value,
  });

  final bool isAddable;
  final String item;
  final String? value;
}
