import 'package:flutter/foundation.dart';

import '../../domain/usecases/fetch_table_usecase.dart';
import 'states/table_state.dart';

class TableController extends ValueNotifier<TableState> {
  final IFetchTableUsecase _fetchUsecase;

  TableController(this._fetchUsecase) : super(InitialTableState());

  Future<void> fetch() async {
    final response = await _fetchUsecase.fetch();
    value = SuccessTableState(response);
  }
}
