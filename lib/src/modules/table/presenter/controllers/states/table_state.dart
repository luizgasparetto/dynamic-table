import '../../../domain/models/table_model.dart';

sealed class TableState {
  const TableState();
}

class InitialTableState extends TableState {}

class SuccessTableState extends TableState {
  final TableModel table;

  const SuccessTableState(this.table);
}
