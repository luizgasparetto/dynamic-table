import 'package:flutter/material.dart';

import '../../../../core/helpers/debouncer.dart';
import '../../domain/models/submodels/column_model.dart';
import '../../domain/models/submodels/row_model.dart';
import '../../domain/models/table_model.dart';

class TableWidget extends StatefulWidget {
  final TableModel table;
  final void Function(TableModel) onSave;

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

  final _debouncer = Debouncer.medium();
  late final copyRows = TableModel.copyRows(rows);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DataTable(
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
              cells:
                  List.generate(copyRows[rowIndex].cells.length, (cellIndex) {
                final column = columns[cellIndex];
                final cell = copyRows[rowIndex].cells[cellIndex];

                return DataCell(
                  TextFormField(
                    initialValue: cell.value.toString(),
                    enabled: cell.isEditable,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(16),
                    ),
                    onChanged: (val) {
                      setState(() {
                        final newCell = cell.substitute(val, type: column.type);
                        copyRows[rowIndex].cells[cellIndex] = newCell;
                      });

                      _debouncer.run(
                        () => widget.onSave(
                          widget.table.substituteRows(copyRows),
                        ),
                      );
                    },
                  ),
                );
              }),
            ),
          ),
        ),
        const SizedBox(width: 16),
        FloatingActionButton.small(
          child: const Icon(Icons.add),
          onPressed: () {
            setState(() {
              copyRows.add(RowModel.generate(columns.length));
            });
          },
        ),
      ],
    );
  }
}
