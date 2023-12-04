import '../../enums/column_type.dart';

class CellModel {
  final dynamic value;
  final bool isEditable;

  const CellModel({
    required this.value,
    required this.isEditable,
  });

  factory CellModel.empty() {
    return const CellModel(value: '', isEditable: true);
  }

  CellModel substitute(String value, {required ColumnType type}) {
    final parsedValue = switch (type) {
      ColumnType.number => value.isNotEmpty ? _parseNumber(value) : null,
      _ => value,
    };

    return _copyWith(value: parsedValue);
  }

  int _parseNumber(String value) => int.parse(value.replaceAll('.', ''));

  CellModel _copyWith({dynamic value}) {
    return CellModel(
      value: value ?? this.value,
      isEditable: isEditable,
    );
  }
}
