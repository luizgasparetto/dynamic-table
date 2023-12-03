// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:multi_table/src/app_module.dart';
import 'package:multi_table/src/app_widget.dart';

import 'src/core/data/example.dart';

import 'src/modules/table/data/adapters/table_adapter.dart';
import 'src/modules/table/presenter/widgets/dynamic_table_widget.dart';

void main() {
  runApp(ModularApp(module: AppModule(), child: const AppWidget()));
}

// class MainApp extends StatelessWidget {
//   MainApp({super.key});

//   final table = TableAdapter.fromJson(jsonExample);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         body: SingleChildScrollView(
//           child: Column(
//             children: [
//               const SizedBox(height: 128),
//               TableWidget(
//                 table: table,
//                 onSave: () => print('Salvou no KVS'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
