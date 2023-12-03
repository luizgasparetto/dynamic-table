enum ColumnType {
  text,
  email,
  number;

  bool get isNumeric => this == ColumnType.number;
}
