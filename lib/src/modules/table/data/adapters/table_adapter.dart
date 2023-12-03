import '../../domain/models/cell_model.dart';
import '../../domain/models/column_model.dart';
import '../../domain/models/table_model.dart';

import 'enums/column_type_adapter.dart';

class TableAdapter {
  static TableModel fromJson(Map<String, dynamic> json) {
    final columns = ColumnAdapter.fromMapJson(json);
    final rows = RowAdapter.fromJson(json, columns);

    return TableModel(name: json['name'], columns: columns, rows: rows);
  }
}

class ColumnAdapter {
  static List<ColumnModel> fromMapJson(Map<String, dynamic> json) {
    final result = List<Map<String, dynamic>>.from(json['columns']);

    return result.map(fromJson).toList();
  }

  static ColumnModel fromJson(Map<String, dynamic> json) {
    return ColumnModel(
      name: json['name'],
      type: ColumnTypeAdapter.fromString(json['type']),
      subtype: json['subtype'],
      isEditable: json['is_editable'],
    );
  }
}

class RowAdapter {
  static List<List<CellModel>> fromJson(
    Map<String, dynamic> json,
    List<ColumnModel> columns,
  ) {
    final baseList = List<List<dynamic>>.from(json['rows']);

    return baseList.map((values) => _fromCellList(values, columns)).toList();
  }

  static List<CellModel> _fromCellList(
    List<dynamic> values,
    List<ColumnModel> columns,
  ) {
    return List.generate(
      values.length,
      (i) => CellModel(
        value: values[i],
        isEditable: columns[i].isEditable,
      ),
    );
  }
}
