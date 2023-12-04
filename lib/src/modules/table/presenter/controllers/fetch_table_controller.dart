import 'package:flutter/foundation.dart';

import '../../domain/usecases/fetch_table_usecase.dart';
import 'states/fetch_table_state.dart';

class FetchTableController extends ValueNotifier<FetchTableState> {
  final IFetchTableUsecase _fetchUsecase;

  FetchTableController(this._fetchUsecase) : super(InitialFetchTableState());

  Future<void> fetch() async {
    final response = await _fetchUsecase.fetch();
    value = SuccessFetchTableState(response);
  }
}
