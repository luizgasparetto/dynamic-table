import 'cell_model.dart';

class RowModel {
  final List<CellModel> cells;

  const RowModel({
    required this.cells,
  });

  factory RowModel.generate(int quantity) {
    return RowModel(cells: List.generate(quantity, (_) => CellModel.empty()));
  }

  int getCellIndex(CellModel cell) {
    return cells.indexOf(cell);
  }

  bool isLastCell(int cellIndex) {
    return cellIndex == cells.length - 1;
  }

  List<CellModel> generate() {
    final newCells = cells.map(
      (e) => CellModel(value: e.value, isEditable: e.isEditable),
    );

    return newCells.toList();
  }

  bool get isEmpty {
    return cells.every((e) => e.value == null || e.value.isEmpty);
  }
}
