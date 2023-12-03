import 'cell_model.dart';

class RowModel {
  final List<CellModel> cells;

  const RowModel({
    required this.cells,
  });

  factory RowModel.generate(int quantity) {
    return RowModel(cells: List.generate(quantity, (_) => CellModel.empty()));
  }
}
