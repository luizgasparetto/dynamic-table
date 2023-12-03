// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';

import '../widgets/dynamic_table_widget.dart';

class TablePage extends StatefulWidget {
  const TablePage({super.key});

  @override
  State<TablePage> createState() => _TablePageState();
}

class _TablePageState extends State<TablePage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 128),
          TableWidget(
            table: table,
            onSave: () => print('Salvou no KVS'),
          ),
        ],
      ),
    );
  }
}
