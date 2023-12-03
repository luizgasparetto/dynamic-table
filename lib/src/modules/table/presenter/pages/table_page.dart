// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../core/data/example.dart';
import '../../data/adapters/models/table_adapter.dart';
import '../../domain/usecases/fetch_table_usecase.dart';
import '../../domain/usecases/save_table_usecase.dart';
import '../widgets/dynamic_table_widget.dart';

class TablePage extends StatefulWidget {
  const TablePage({super.key});

  @override
  State<TablePage> createState() => _TablePageState();
}

class _TablePageState extends State<TablePage> {
  final table = TableAdapter.fromJson(jsonExample);

  final fetchUsecase = Modular.get<IFetchTableUsecase>();
  final saveUsecase = Modular.get<ISaveTableUsecase>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: fetchUsecase.fetch(),
          builder: (_, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  const SizedBox(height: 128),
                  TableWidget(
                    table: snapshot.data!,
                    onSave: (newTable) async {
                      await saveUsecase.execute(newTable);
                      print('Salvou no KVS!');
                    },
                  ),
                ],
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
