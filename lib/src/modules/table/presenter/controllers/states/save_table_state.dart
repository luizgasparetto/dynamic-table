import 'package:multi_table/src/modules/table/domain/models/table_model.dart';

sealed class SaveTableState {
  const SaveTableState();
}

class InitialSaveTableState extends SaveTableState {}

class SuccessSaveTableState extends SaveTableState {
  final TableModel table;

  const SuccessSaveTableState(this.table);
}
