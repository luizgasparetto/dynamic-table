import '../models/table_model.dart';
import '../repositories/i_table_repository.dart';

abstract interface class ISaveTableUsecase {
  Future<void> execute(TableModel table);
}

class SaveTableUsecase implements ISaveTableUsecase {
  final ITableRepository _repository;

  const SaveTableUsecase(this._repository);

  @override
  Future<void> execute(TableModel table) async {
    await _repository.save(table.format());
    print('Salvei');
  }
}
