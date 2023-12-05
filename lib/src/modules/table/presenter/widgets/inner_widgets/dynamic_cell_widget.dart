import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../domain/enums/column_type.dart';

class DynamicCellWidget extends StatelessWidget {
  final String initialValue;
  final bool isEditable;
  final void Function(String)? onChanged;
  final ColumnType type;
  final bool useLeftRadius;
  final bool useRightRadius;

  const DynamicCellWidget({
    super.key,
    required this.initialValue,
    required this.isEditable,
    required this.onChanged,
    required this.type,
    this.useLeftRadius = false,
    this.useRightRadius = false,
  });

  List<TextInputFormatter> get formatters {
    return switch (type) {
      ColumnType.number => [FilteringTextInputFormatter.digitsOnly],
      _ => [],
    };
  }

  TextInputType get keyboardType {
    return switch (type) {
      ColumnType.email => TextInputType.emailAddress,
      ColumnType.number => TextInputType.number,
      _ => TextInputType.text,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: !isEditable ? Colors.grey.withOpacity(0.5) : null,
        borderRadius: BorderRadius.only(
          bottomLeft: useLeftRadius ? const Radius.circular(16) : Radius.zero,
          bottomRight: useRightRadius ? const Radius.circular(16) : Radius.zero,
        ),
      ),
      child: TextFormField(
        initialValue: initialValue,
        enabled: isEditable,
        textAlign: TextAlign.center,
        onChanged: onChanged,
        inputFormatters: formatters,
        keyboardType: keyboardType,
        decoration: const InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(16),
        ),
      ),
    );
  }
}
