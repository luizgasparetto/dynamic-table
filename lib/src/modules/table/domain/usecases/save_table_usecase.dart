import 'package:flutter/foundation.dart';

import '../models/table_model.dart';
import '../repositories/i_table_repository.dart';

abstract interface class ISaveTableUsecase {
  Future<void> execute(
    TableModel oldTable,
    TableModel newTable,
    VoidCallback onSuccess,
  );
}

class SaveTableUsecase implements ISaveTableUsecase {
  final ITableRepository _repository;

  const SaveTableUsecase(this._repository);

  @override
  Future<void> execute(
      TableModel oldTable, TableModel newTable, VoidCallback onSuccess) async {
    final formattedTable = newTable.format();
    final isTableDifferent = hasTableDifferences(oldTable, formattedTable);

    if (isTableDifferent) {
      await _repository.save(formattedTable);
      print('SALVEI MEU PITBULZAAO');
      onSuccess();
    } else {
      print('Não é diferente pai, vou salvar essa bosta não');
    }
  }

  bool hasTableDifferences(TableModel oldTable, TableModel newTable) {
    if (newTable.rows.length != oldTable.rows.length) {
      return true;
    }

    return newTable.rows.asMap().entries.any((newRowEntry) {
      final oldRow = oldTable.rows[newRowEntry.key];
      final newRow = newRowEntry.value;

      return newRow.cells.asMap().entries.any((newCellEntry) {
        final oldCell = oldRow.cells[newCellEntry.key];
        final newCell = newCellEntry.value;

        return oldCell.value != newCell.value;
      });
    });
  }
}
