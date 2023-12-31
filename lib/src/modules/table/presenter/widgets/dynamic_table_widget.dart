import 'dart:async';

import 'package:flutter/material.dart';
import 'package:multi_table/src/core/helpers/debouncer.dart';

import '../../domain/models/submodels/column_model.dart';
import '../../domain/models/submodels/row_model.dart';
import '../../domain/models/table_model.dart';
import 'inner_widgets/dynamic_cell_widget.dart';
import 'inner_widgets/table_tag_title_widget.dart';

class DynamicTableWidget extends StatefulWidget {
  final TableModel table;
  final void Function(TableModel newTable) onChanged;

  const DynamicTableWidget({
    super.key,
    required this.table,
    required this.onChanged,
  });

  @override
  State<DynamicTableWidget> createState() => _DynamicTableWidgetState();
}

class _DynamicTableWidgetState extends State<DynamicTableWidget> {
  TableModel get table => widget.table;
  List<ColumnModel> get columns => table.columns;
  List<RowModel> get rows => table.rows;

  late final copyRows = TableModel.copyRows(rows);

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TableTagTitleWidget(
            text: 'Adicionar linha',
            onPressed: () {
              setState(() {
                copyRows.add(RowModel.generate(columns.length));
              });
            },
          ),
          Table(
            defaultColumnWidth: const IntrinsicColumnWidth(),
            border: TableBorder.all(
              color: Colors.grey.withOpacity(0.5),
              width: 2,
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(16),
                bottomLeft: Radius.circular(16),
              ),
            ),
            children: [
              TableRow(
                children: columns
                    .map((e) => Padding(
                          padding: const EdgeInsets.all(16),
                          child: Text(e.name),
                        ))
                    .toList(),
              ),
              ...List.generate(
                copyRows.length,
                (rowIndex) {
                  final row = copyRows[rowIndex];
                  final isLastRow = rowIndex == copyRows.length - 1;

                  return TableRow(
                    children: List.generate(
                      row.cells.length,
                      (cellIndex) {
                        final cell = row.cells[cellIndex];
                        final column = columns[cellIndex];

                        final isFirstCell = cellIndex == 0;
                        final isLastCell = row.isLastCell(cellIndex);

                        return DynamicCellWidget(
                          initialValue: cell.value.toString(),
                          isEditable: cell.isEditable,
                          type: column.type,
                          useLeftRadius: isLastRow && isFirstCell,
                          useRightRadius: isLastRow && isLastCell,
                          onChanged: (val) {
                            final sub = cell.substitute(val, type: column.type);
                            copyRows[rowIndex].cells[cellIndex] = sub;

                            final newTable = table.substituteRows(copyRows);

                            widget.onChanged(newTable);
                          },
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
