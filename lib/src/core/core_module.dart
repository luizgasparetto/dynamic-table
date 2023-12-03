import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'services/kvs/shared_preferences_storage_service.dart';

class CoreModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        AsyncBind((i) => SharedPreferences.getInstance()),
        Bind.lazySingleton((i) => SharedPreferencesStorageService(i()))
      ];
}
