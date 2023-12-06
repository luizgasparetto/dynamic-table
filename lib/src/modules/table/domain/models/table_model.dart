// ignore_for_file: unnecessary_this

import 'submodels/column_model.dart';
import 'submodels/row_model.dart';

class TableModel {
  final String name;
  final List<ColumnModel> columns;
  final List<RowModel> rows;

  const TableModel({
    required this.name,
    required this.columns,
    required this.rows,
  });

  static List<RowModel> copyRows(List<RowModel> rows) {
    return List<RowModel>.from(rows.map((e) => RowModel(cells: e.generate())));
  }

  TableModel substituteRows(List<RowModel> rows) {
    return _copyWith(rows: rows);
  }

  TableModel format() {
    rows.removeWhere((e) => e.isEmpty);
    return this;
  }

  int getRowIndex(RowModel row) => rows.indexOf(row);
  bool isLastRow(int rowIndex) => rowIndex == rows.length - 1;

  TableModel _copyWith({List<RowModel>? rows}) {
    return TableModel(
      name: name,
      columns: columns,
      rows: rows ?? this.rows,
    );
  }
}
