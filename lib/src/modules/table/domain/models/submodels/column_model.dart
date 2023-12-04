import 'dart:core';

import '../../enums/column_type.dart';

class ColumnModel {
  final String name;
  final ColumnType type;
  final String? subtype;
  final bool isEditable;

  const ColumnModel({
    required this.name,
    required this.type,
    this.subtype,
    this.isEditable = false,
  });
}
