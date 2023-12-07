import '../dynamic_validator_specification.dart';

class EmailValidationSpecification extends DynamicSpecification {
  const EmailValidationSpecification(super.dto);

  @override
  bool validate() {
    RegExp emailValidator = RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
    //return emailValidator.hasMatch(value ?? '');
    return false;
  }
}
