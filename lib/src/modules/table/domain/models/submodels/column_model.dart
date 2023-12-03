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

  @override
  bool operator ==(covariant ColumnModel other) {
    if (identical(this, other)) return true;

    return other.name == name && other.type == type;
  }

  @override
  int get hashCode => name.hashCode ^ type.hashCode;
}
