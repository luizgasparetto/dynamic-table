import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multi_table/src/modules/table/presenter/widgets/validators/dtos/dynamic_validator_dto.dart';

import '../../../domain/enums/column_type.dart';
import '../../../domain/enums/sub_column_type.dart';
import '../validators/dynamic_validator_root.dart';

class DynamicCellWidget extends StatefulWidget {
  final String initialValue;
  final ColumnType type;
  final SubColumnType subtype;
  final bool isUnique;
  final bool isEditable;
  final void Function(String value) onChanged;
  final bool useLeftRadius;
  final bool useRightRadius;
  final double radius;

  const DynamicCellWidget({
    super.key,
    required this.initialValue,
    required this.isEditable,
    required this.onChanged,
    required this.type,
    required this.subtype,
    this.isUnique = false,
    this.useLeftRadius = false,
    this.useRightRadius = false,
    this.radius = 16,
  });

  @override
  State<DynamicCellWidget> createState() => _DynamicCellWidgetState();
}

class _DynamicCellWidgetState extends State<DynamicCellWidget> {
  ColumnType get type => widget.type;
  SubColumnType get subtype => widget.subtype;

  final isValidState = ValueNotifier<bool>(true);

  @override
  void dispose() {
    isValidState.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: !widget.isEditable ? const Color(0xFFEFEFEF) : null,
        borderRadius: BorderRadius.only(
          bottomLeft: getRadius(widget.useLeftRadius),
          bottomRight: getRadius(widget.useRightRadius),
        ),
      ),
      child: ValueListenableBuilder<bool>(
        valueListenable: isValidState,
        builder: (_, isValid, __) {
          return TextFormField(
            initialValue: widget.initialValue,
            enabled: widget.isEditable,
            textAlign: TextAlign.center,
            inputFormatters: formatters,
            keyboardType: keyboardType,
            cursorColor: cursorColor,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(16),
              filled: true,
              fillColor: fillColor,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.only(
                  bottomLeft: getRadius(widget.useLeftRadius),
                  bottomRight: getRadius(widget.useRightRadius),
                ),
              ),
              errorStyle: const TextStyle(height: 0),
            ),
            onChanged: (value) {
              //final response = validate(value);
              //isValidState.value = response;

              widget.onChanged.call(value);
            },
            validator: (value) {
              final isValid = value == 'luiz';

              //Future.microtask(() => isValidState.value = isValid);

              // Future.delayed(
              //   const Duration(milliseconds: 300),
              //   () => isValidState.value = isValid,
              // );

              // return isValid ? null : '';
            },
          );
        },
      ),
    );
  }

  Color get fillColor {
    return isValidState.value ? Colors.transparent : const Color(0xFFea7e80);
  }

  Color get cursorColor {
    return isValidState.value ? Colors.blue : const Color(0xFFbf1111);
  }

  Radius getRadius(bool useRadius) {
    return useRadius ? Radius.circular(widget.radius) : Radius.zero;
  }

  TextInputType get keyboardType {
    return switch (widget.type) {
      ColumnType.text => TextInputType.text,
      ColumnType.number => TextInputType.number,
    };
  }

  List<TextInputFormatter> get formatters {
    return switch (widget.type) {
      ColumnType.number => [FilteringTextInputFormatter.digitsOnly],
      _ => [],
    };
  }
}
