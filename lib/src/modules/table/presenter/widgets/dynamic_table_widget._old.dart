import 'package:flutter/material.dart';
import 'package:multi_table/src/modules/table/domain/enums/column_type.dart';

import '../../domain/models/submodels/column_model.dart';
import '../../domain/models/submodels/row_model.dart';
import '../../domain/models/table_model.dart';
import 'inner_widgets/dynamic_cell_widget.dart'; // Importe seus modelos e widgets personalizados

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
    final List<Map<String, dynamic>> data = [
      {"id": "1", "name": "Aliceeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee"},
      {"id": "2", "name": "Bob"},
      // Adicione mais dados conforme necessário
    ];

    return IntrinsicWidth(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 35,
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.2),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: () {
                  setState(() {
                    copyRows.add(RowModel.generate(columns.length));
                  });
                },
                child: const Text(
                  'Adicionar grupo',
                  style: TextStyle(
                    color: Color(0xFF0250f7),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Table(
            defaultColumnWidth: const IntrinsicColumnWidth(),
            border: TableBorder.all(
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                ),
                color: Colors.grey.withOpacity(0.5),
                width: 2),
            children: [
              TableRow(
                children: [
                  Container(
                      padding: const EdgeInsets.all(8),
                      child: const Text('ID')),
                  Container(
                      padding: const EdgeInsets.all(8),
                      child: const Text('Name')),
                ],
              ),
              ...data.map((row) {
                return TableRow(
                  children: [
                    TableCell(
                      child: IntrinsicHeight(
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                // decoration: BoxDecoration(
                                //   color: Colors.pink,
                                //   borderRadius: BorderRadius.circular(16),
                                // ),
                                child: DynamicCellWidget(
                                  initialValue: row['name'],
                                  isEditable: true,
                                  type: ColumnType.email,
                                  onChanged: (val) {
                                    // setState(() {
                                    //   final newCell =
                                    //       cell.substitute(val, type: column.type);
                                    //   copyRows[rowIndex].cells[cellIndex] = newCell;
                                    // });

                                    widget.onSave(
                                      widget.table.substituteRows(copyRows),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    TableCell(
                      child: IntrinsicHeight(
                        child: Row(
                          children: [
                            Expanded(
                              child: DynamicCellWidget(
                                initialValue: row['name'],
                                isEditable: true,
                                type: ColumnType.email,
                                onChanged: (val) {
                                  // setState(() {
                                  //   final newCell =
                                  //       cell.substitute(val, type: column.type);
                                  //   copyRows[rowIndex].cells[cellIndex] = newCell;
                                  // });

                                  widget.onSave(
                                    widget.table.substituteRows(copyRows),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ],
          ),
        ],
      ),
    );
  }
}
