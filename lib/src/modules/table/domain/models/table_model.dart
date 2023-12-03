// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'cell_model.dart';
import 'column_model.dart';
import 'row_model.dart';

class TableModel {
  final String name;
  final List<ColumnModel> columns;
  final List<RowModel> rows;

  const TableModel({
    required this.name,
    required this.columns,
    required this.rows,
  });

  static List<List<CellModel>> copyRows(List<List<CellModel>> rows) {
    return List<List<CellModel>>.from(rows.map((e) => List<CellModel>.from(e)));
  }
}
