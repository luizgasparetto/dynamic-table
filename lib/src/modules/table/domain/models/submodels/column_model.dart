import 'dart:core';

import '../../enums/column_type.dart';
import '../../enums/sub_column_type.dart';

class ColumnModel {
  final String name;
  final ColumnType type;
  final SubColumnType subtype;
  final bool isEditable;

  const ColumnModel({
    required this.name,
    required this.type,
    required this.subtype,
    this.isEditable = false,
  });
}
