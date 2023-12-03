import 'package:flutter_modular/flutter_modular.dart';
import 'package:multi_table/src/core/core_module.dart';

import 'modules/table/table_module.dart';

class AppModule extends Module {
  @override
  List<Module> get imports => [CoreModule()];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute(Modular.initialRoute, module: TableModule()),
      ];
}
