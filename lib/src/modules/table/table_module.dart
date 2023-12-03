import 'package:flutter_modular/flutter_modular.dart';

import 'presenter/pages/table_page.dart';

class TableModule extends Module {
  @override
  List<ModularRoute> get routes => [
        ChildRoute(Modular.initialRoute, child: (_, __) => const TablePage()),
      ];
}
