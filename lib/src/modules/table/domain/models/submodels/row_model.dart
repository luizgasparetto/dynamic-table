import 'cell_model.dart';

class RowModel {
  final List<CellModel> cells;

  const RowModel({
    required this.cells,
  });

  factory RowModel.generate(int quantity) {
    return RowModel(cells: List.generate(quantity, (_) => CellModel.empty()));
  }

  bool get isEmpty => cells.every((e) => e.value == null || e.value.isEmpty);

  List<CellModel> generate() {
    final newCells = cells.map(
      (e) => CellModel(value: e.value, isEditable: e.isEditable),
    );

    return newCells.toList();
  }
}
