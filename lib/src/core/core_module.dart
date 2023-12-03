import 'package:flutter_modular/flutter_modular.dart';

import 'services/kvs/shared_preferences_storage_service.dart';

class CoreModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind.lazySingleton(
          (i) => const SharedPreferencesStorageService(),
          export: true,
        )
      ];
}
