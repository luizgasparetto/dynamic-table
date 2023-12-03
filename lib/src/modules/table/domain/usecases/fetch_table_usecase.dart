import '../models/table_model.dart';
import '../repositories/i_table_repository.dart';

abstract interface class IFetchTableUsecase {
  Future<TableModel> fetch();
}

class FetchTableUsecase implements IFetchTableUsecase {
  final ITableRepository _repository;

  const FetchTableUsecase(this._repository);

  @override
  Future<TableModel> fetch() async {
    return _repository.fetch();
  }
}
