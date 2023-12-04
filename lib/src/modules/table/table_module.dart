import 'package:flutter_modular/flutter_modular.dart';
import 'package:multi_table/src/modules/table/presenter/controllers/save_table_controller.dart';

import 'data/repositories/table_repository.dart';
import 'domain/usecases/fetch_table_usecase.dart';
import 'domain/usecases/save_table_usecase.dart';
import 'presenter/controllers/fetch_table_controller.dart';
import 'presenter/pages/table_page.dart';

class TableModule extends Module {
  @override
  List<ModularRoute> get routes => [
        ChildRoute(Modular.initialRoute, child: (_, __) => const TablePage()),
      ];

  @override
  List<Bind<Object>> get binds => [
        Bind.factory((i) => TableRepository(i())),
        Bind.factory((i) => SaveTableUsecase(i())),
        Bind.factory((i) => FetchTableUsecase(i())),
        Bind.singleton((i) => FetchTableController(i())),
        Bind.singleton((i) => SaveTableController(i())),
      ];
}
