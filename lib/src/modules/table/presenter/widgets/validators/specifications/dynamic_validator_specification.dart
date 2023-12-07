import '../dtos/dynamic_validator_dto.dart';

abstract class DynamicSpecification {
  final DynamicValidatorDTO dto;

  const DynamicSpecification(this.dto);

  bool validate();
}
