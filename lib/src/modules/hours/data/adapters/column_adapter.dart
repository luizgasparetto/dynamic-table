import '../../../table/domain/models/submodels/column_model.dart';
import 'enums/column_type_adapter.dart';

class ColumnAdapter {
  static List<ColumnModel> fromMapJson(Map<String, dynamic> json) {
    final result = List<Map<String, dynamic>>.from(json['columns']);

    return result.map(fromJson).toList();
  }

  static ColumnModel fromJson(Map<String, dynamic> json) {
    return ColumnModel(
      name: json['name'],
      type: ColumnTypeAdapter.fromString(json['type']),
      subtype: json['subtype'],
      isEditable: json['is_editable'],
    );
  }
}
