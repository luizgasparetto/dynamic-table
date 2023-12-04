// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:multi_table/src/modules/table/domain/models/table_model.dart';

import '../../../../core/helpers/debouncer.dart';
import '../../domain/usecases/fetch_table_usecase.dart';
import '../../domain/usecases/save_table_usecase.dart';
import '../widgets/dynamic_table_widget.dart';

class TablePage extends StatefulWidget {
  const TablePage({super.key});

  @override
  State<TablePage> createState() => _TablePageState();
}

class _TablePageState extends State<TablePage> {
  late TableModel _table;

  final fetchUsecase = Modular.get<IFetchTableUsecase>();
  final saveUsecase = Modular.get<ISaveTableUsecase>();

  void _setTable(TableModel table) => _table = table;

  @override
  Widget build(BuildContext context) {
    final debouncer = Debouncer.medium();

    return Scaffold(
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: fetchUsecase.fetch(),
          builder: (_, snapshot) {
            if (snapshot.hasData) {
              _setTable(snapshot.data!);

              return Column(
                children: [
                  const SizedBox(height: 128),
                  Center(
                    child: TableWidget(
                      table: snapshot.data!,
                      onSave: (newTable) {
                        debouncer.run(() async {
                          await saveUsecase.execute(
                            _table,
                            newTable,
                            () => _setTable(newTable),
                          );
                        });
                      },
                    ),
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
