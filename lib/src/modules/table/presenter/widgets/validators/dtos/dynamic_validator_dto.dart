import '../../../../domain/enums/column_type.dart';
import '../../../../domain/enums/sub_column_type.dart';
import '../../../../domain/models/submodels/cell_model.dart';

class DynamicValidatorDTO {
  final String value;
  final ColumnType type;
  final SubColumnType subtype;
  final bool isUnique;
  final List<CellModel> previousCells;

  const DynamicValidatorDTO({
    required this.value,
    required this.type,
    required this.subtype,
    required this.isUnique,
    required this.previousCells,
  });
}
