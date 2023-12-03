// ignore_for_file: public_member_api_docs, sort_constructors_first
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
    return List<RowModel>.from(rows.map((e) => RowModel(cells: e.cells)));
  }

  void format() {
    rows.removeWhere((e) => e.cells.every((e) => e.isEmpty));
  }

  TableModel copyWith({List<RowModel>? rows}) {
    return TableModel(
      name: name,
      columns: columns,
      rows: rows ?? this.rows,
    );
  }
}
