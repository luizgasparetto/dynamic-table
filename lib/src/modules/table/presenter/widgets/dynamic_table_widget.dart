import 'package:flutter/material.dart';

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
  final GlobalKey _tableKey = GlobalKey();
  double _tableWidth = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _updateTableWidth());
  }

  void _updateTableWidth() {
    final renderBoxTable = _tableKey.currentContext?.findRenderObject();

    if (renderBoxTable != null) {
      final box = renderBoxTable as RenderBox;

      setState(() {
        _tableWidth = box.size.width;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Visibility(
          visible: _tableWidth != 0,
          child: Container(
            width: _tableWidth,
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: InkWell(
              onTap: () => print('Adicionei'),
              child: const Text(
                'Adicionar',
                textAlign: TextAlign.end,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            key: _tableKey,
            border: TableBorder.all(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
            ),
            columns: List.generate(columns.length + 1, (index) {
              if (index == columns.length) {
                return DataColumn(label: Container());
              }

              return DataColumn(
                label: Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      columns[index].name,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              );
            }),
            rows: List.generate(copyRows.length, (rowIndex) {
              final length = copyRows[rowIndex].cells.length + 1;

              return DataRow(
                cells: List.generate(length, (cellIndex) {
                  if (cellIndex == copyRows[rowIndex].cells.length) {
                    return DataCell(
                      InkWell(
                        onTap: () => print('tapiei'),
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        child: const Icon(Icons.more_vert),
                      ),
                    );
                  }

                  final column = columns[cellIndex];
                  final cell = copyRows[rowIndex].cells[cellIndex];

                  return DataCell(
                    DynamicCellWidget(
                      initialValue: cell.value.toString(),
                      isEditable: cell.isEditable,
                      type: column.type,
                      onChanged: (val) {
                        setState(() {
                          final newCell =
                              cell.substitute(val, type: column.type);
                          copyRows[rowIndex].cells[cellIndex] = newCell;
                        });

                        _updateTableWidth();

                        widget.onSave(widget.table.substituteRows(copyRows));
                      },
                    ),
                  );
                }),
              );
            }),
          ),
        ),
      ],
    );
  }
}
