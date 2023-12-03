import 'package:flutter/material.dart';

import '../../../../core/helpers/debouncer.dart';
import '../../domain/models/cell_model.dart';
import '../../domain/models/column_model.dart';
import '../../domain/models/table_model.dart';

class TableWidget extends StatefulWidget {
  final TableModel table;
  final VoidCallback onSave;

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
  List<List<CellModel>> get rows => widget.table.rows;

  final _debouncer = Debouncer.medium();
  late final copyRows = TableModel.copyRows(rows);

  // List<TextInputFormatter> _getInputFormatters(ColumnType type) {
  //   return switch (type) {
  //     ColumnType.number => [
  //         FilteringTextInputFormatter.digitsOnly,
  //         ThousandsFormatter()
  //       ],
  //     _ => [],
  //   };
  // }

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
              cells: List.generate(copyRows[rowIndex].length, (cellIndex) {
                final column = columns[cellIndex];
                final cell = copyRows[rowIndex][cellIndex];

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
                        copyRows[rowIndex][cellIndex] = cell.substitute(
                          val,
                          type: column.type,
                        );
                      });

                      _debouncer.run(widget.onSave);
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
              copyRows.add(
                List.generate(
                  columns.length,
                  (_) => CellModel.empty(),
                ),
              );
            });
          },
        ),
      ],
    );
  }
}
