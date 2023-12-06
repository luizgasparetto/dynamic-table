import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../domain/enums/column_type.dart';
import '../formatters/time_formatter.dart';

class DynamicCellWidget extends StatefulWidget {
  final String initialValue;
  final bool isEditable;
  final void Function(String) onChanged;
  final ColumnType type;
  final bool useLeftRadius;
  final bool useRightRadius;
  final double radius;

  const DynamicCellWidget({
    super.key,
    required this.initialValue,
    required this.isEditable,
    required this.onChanged,
    required this.type,
    this.useLeftRadius = false,
    this.useRightRadius = false,
    this.radius = 16,
  });

  @override
  State<DynamicCellWidget> createState() => _DynamicCellWidgetState();
}

class _DynamicCellWidgetState extends State<DynamicCellWidget> {
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
        color: !widget.isEditable ? Colors.grey.withOpacity(0.5) : null,
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
            ),
            onChanged: (value) {
              widget.onChanged.call(value);
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



// TimeInputFormatter();