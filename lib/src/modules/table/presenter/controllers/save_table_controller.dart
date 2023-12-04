import 'package:flutter/foundation.dart';
import 'package:multi_table/src/modules/table/domain/models/table_model.dart';
import 'package:multi_table/src/modules/table/domain/usecases/save_table_usecase.dart';

import 'states/save_table_state.dart';

class SaveTableController extends ValueNotifier<SaveTableState> {
  final ISaveTableUsecase _saveTableUsecase;

  SaveTableController(this._saveTableUsecase) : super(InitialSaveTableState());

  Future<void> save(TableModel table) async {
    await _saveTableUsecase.execute(table);
    value = SuccessSaveTableState(table);
  }
}
