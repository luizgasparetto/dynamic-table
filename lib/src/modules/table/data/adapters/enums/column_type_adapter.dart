import '../../../domain/enums/column_type.dart';

class ColumnTypeAdapter {
  static ColumnType fromString(String value) {
    return switch (value) {
      'text' => ColumnType.text,
      'numeric' => ColumnType.number,
      _ => ColumnType.text,
    };
  }

  static String getString(ColumnType type) {
    return switch (type) {
      ColumnType.text => 'text',
      ColumnType.number => 'numeric',
    };
  }
}
