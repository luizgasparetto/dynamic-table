import '../models/table_model.dart';

abstract interface class ITableRepository {
  Future<void> save(TableModel table);
  Future<TableModel> fetch();
}
