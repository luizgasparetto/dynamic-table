// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:multi_table/src/modules/table/presenter/controllers/save_table_controller.dart';
import 'package:multi_table/src/modules/table/presenter/controllers/states/fetch_table_state.dart';
import 'package:multi_table/src/modules/table/presenter/controllers/fetch_table_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/helpers/debouncer.dart';
import '../widgets/dynamic_table_widget.dart';

class TablePage extends StatefulWidget {
  const TablePage({super.key});

  @override
  State<TablePage> createState() => _TablePageState();
}

class _TablePageState extends State<TablePage> {
  final fetchController = Modular.get<FetchTableController>();
  final saveController = Modular.get<SaveTableController>();

  @override
  void initState() {
    super.initState();
    fetchController.fetch();

    //SharedPreferences.getInstance().then((value) => value.clear());
  }

  @override
  Widget build(BuildContext context) {
    final debouncer = Debouncer.medium();

    return Scaffold(
      body: SingleChildScrollView(
        child: ValueListenableBuilder<FetchTableState>(
          valueListenable: fetchController,
          builder: (_, state, __) {
            if (state is SuccessFetchTableState) {
              return Column(
                children: [
                  const SizedBox(height: 128),
                  Center(
                    child: DynamicTableWidget(
                      table: state.table,
                      onChanged: (newTable) {
                        debouncer.run(() async {
                          await saveController.save(newTable);
                        });
                      },
                    ),
                  )
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
