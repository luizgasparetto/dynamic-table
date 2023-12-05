import '../../../../domain/models/submodels/cell_model.dart';
import '../../../../domain/models/submodels/column_model.dart';
import '../../../../domain/models/submodels/row_model.dart';

class RowAdapter {
  static List<RowModel> fromJson(
    Map<String, dynamic> json,
    List<ColumnModel> columns,
  ) {
    final baseList = List<List<dynamic>>.from(json['rows']);
    final cellList = baseList.map((list) => _parseRowWithCells(list, columns));

    return cellList.toList();
  }

  static List<List<dynamic>> toList(List<RowModel> rows) {
    return rows.map((e) => e.cells.map((e) => e.value).toList()).toList();
  }

  static RowModel _parseRowWithCells(
    List<dynamic> values,
    List<ColumnModel> columns,
  ) {
    final cells = <CellModel>[];

    for (int i = 0; i < values.length; i++) {
      cells.add(
        CellModel(
          value: values[i],
          isEditable: columns[i].isEditable,
        ),
      );
    }

    return RowModel(cells: cells.toList());
  }
}
