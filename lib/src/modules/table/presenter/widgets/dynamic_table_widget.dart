import 'package:flutter/material.dart';

import '../../domain/models/submodels/column_model.dart';
import '../../domain/models/submodels/row_model.dart';
import '../../domain/models/table_model.dart';
import 'inner_widgets/dynamic_cell_widget.dart';

class TableWidget extends StatefulWidget {
  final TableModel table;
  final void Function(TableModel newTable) onSave;

  const TableWidget({
    super.key,
    required this.table,
    required this.onSave,
  });

  @override
  TableWidgetState createState() => TableWidgetState();
}

class TableWidgetState extends State<TableWidget> {
  List<ColumnModel> get columns => widget.table.columns;
  List<RowModel> get rows => widget.table.rows;

  late final copyRows = TableModel.copyRows(rows);

  @override
  Widget build(BuildContext context) {
    return DataTable(
      border: TableBorder.all(borderRadius: BorderRadius.circular(8)),
      columns: List.generate(
        columns.length,
        (i) => DataColumn(
          label: Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Text(
                columns[i].name,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
      rows: List.generate(
        copyRows.length,
        (rowIndex) => DataRow(
          cells: List.generate(copyRows[rowIndex].cells.length, (cellIndex) {
            final column = columns[cellIndex];
            final cell = copyRows[rowIndex].cells[cellIndex];

            return DataCell(
              DynamicCellWidget(
                initialValue: cell.value.toString(),
                isEditable: cell.isEditable,
                type: column.type,
                onChanged: (val) {
                  setState(() {
                    final newCell = cell.substitute(val, type: column.type);
                    copyRows[rowIndex].cells[cellIndex] = newCell;
                  });

                  widget.onSave(widget.table.substituteRows(copyRows));
                },
              ),
            );
          }),
        ),
      ),
    );
  }
}
