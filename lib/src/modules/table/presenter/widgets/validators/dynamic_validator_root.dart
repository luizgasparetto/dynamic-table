import '../../../domain/enums/column_type.dart';
import '../../../domain/enums/sub_column_type.dart';
import 'dtos/dynamic_validator_dto.dart';
import 'specifications/dynamic_validator_specification.dart';
import 'specifications/implementations/email_validator_specification.dart';

class DynamicValidatorRoot {
  static bool validate(DynamicValidatorDTO dto) {
    final specification = _getSpecification(dto);
    return specification.validate();
  }

  static DynamicSpecification _getSpecification(DynamicValidatorDTO dto) {
    return switch (dto.type) {
      ColumnType.text => _getTextSpecification(dto),
      ColumnType.number => _getTextSpecification(dto),
    };
  }

  static DynamicSpecification _getTextSpecification(DynamicValidatorDTO dto) {
    return switch (dto.subtype) {
      SubColumnType.email => EmailValidationSpecification(dto),
      _ => EmailValidationSpecification(dto),
    };
  }
}
