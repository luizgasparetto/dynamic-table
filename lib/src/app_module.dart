import 'package:flutter_modular/flutter_modular.dart';

import 'modules/table/table_module.dart';

class AppModule extends Module {
  @override
  List<ModularRoute> get routes => [
        ModuleRoute(Modular.initialRoute, module: TableModule()),
      ];
}
