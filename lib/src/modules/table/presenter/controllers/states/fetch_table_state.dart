import '../../../domain/models/table_model.dart';

sealed class FetchTableState {
  const FetchTableState();
}

class InitialFetchTableState extends FetchTableState {}

class SuccessFetchTableState extends FetchTableState {
  final TableModel table;

  const SuccessFetchTableState(this.table);
}
