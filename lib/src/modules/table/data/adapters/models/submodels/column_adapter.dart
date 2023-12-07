import 'package:multi_table/src/modules/table/data/adapters/enums/sub_column_type_adapter.dart';

import '../../../../domain/models/submodels/column_model.dart';
import '../../enums/column_type_adapter.dart';

class ColumnAdapter {
  static List<ColumnModel> fromMapJson(Map<String, dynamic> json) {
    final result = List<Map<String, dynamic>>.from(json['columns']);

    return result.map(fromJson).toList();
  }

  static ColumnModel fromJson(Map<String, dynamic> json) {
    return ColumnModel(
      name: json['name'],
      type: ColumnTypeAdapter.fromString(json['type']),
      subtype: SubColumnTypeAdapter.fromString(json['subtype']),
      isEditable: json['is_editable'],
    );
  }

  static Map<String, dynamic> toJson(ColumnModel column) {
    return {
      'name': column.name,
      'is_editable': column.isEditable,
      'type': ColumnTypeAdapter.parseString(column.type),
    };
  }
}
