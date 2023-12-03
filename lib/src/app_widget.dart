import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  //final table = TableAdapter.fromJson(jsonExample);

  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //   home: Scaffold(
    //     body: SingleChildScrollView(
    //       child: Column(
    //         children: [
    //           const SizedBox(height: 128),
    //           TableWidget(
    //             table: table,
    //             onSave: () => print('Salvou no KVS'),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
    return MaterialApp.router(
      title: 'Dynamic Table',
      theme: ThemeData.dark(),
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
    );
  }
}
