import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  //final table = TableAdapter.fromJson(jsonExample);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Dynamic Table',
      //theme: ThemeData.light(),
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
    );
  }
}
