import 'dart:convert';

import '../../../../core/data/example.dart';
import '../../../../core/services/kvs/i_storage_service.dart';

import '../../domain/models/table_model.dart';
import '../../domain/repositories/i_table_repository.dart';
import '../adapters/models/table_adapter.dart';

class TableRepository implements ITableRepository {
  final IStorageService _storage;

  const TableRepository(this._storage);

  @override
  Future<TableModel> fetch() async {
    final response = await _storage.getString('table');
    final decoded = response.isNotEmpty ? json.decode(response) : jsonExample;

    return TableAdapter.fromJson(decoded);
  }

  @override
  Future<void> save(TableModel table) async {
    final result = json.encode(TableAdapter.toJson(table));

    return _storage.setString(value: result, key: 'table');
  }
}
