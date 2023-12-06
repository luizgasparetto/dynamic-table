import 'package:multi_table/src/modules/table/domain/enums/sub_column_type.dart';

class SubColumnTypeAdapter {
  static SubColumnType fromString(String? value) {
    return switch (value) {
      'email' => SubColumnType.email,
      'date' => SubColumnType.date,
      'time' => SubColumnType.time,
      _ => SubColumnType.none,
    };
  }

  static String? parseString(SubColumnType type) {
    return switch (type) {
      SubColumnType.email => 'email',
      SubColumnType.date => 'date',
      SubColumnType.time => 'time',
      SubColumnType.none => null,
    };
  }
}
