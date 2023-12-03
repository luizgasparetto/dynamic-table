import '../../../domain/models/table_model.dart';

import 'submodels/column_adapter.dart';
import 'submodels/row_adapter.dart';

class TableAdapter {
  static TableModel fromJson(Map<String, dynamic> json) {
    final columns = ColumnAdapter.fromMapJson(json);
    final rows = RowAdapter.fromJson(json, columns);

    return TableModel(name: json['name'], columns: columns, rows: rows);
  }

  static Map<String, dynamic> toJson(TableModel table) {
    return {
      'name': table.name,
      'columns': table.columns.map(ColumnAdapter.toJson).toList(),
      'rows': RowAdapter.toList(table.rows),
    };
  }
}
