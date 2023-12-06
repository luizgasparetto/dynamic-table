import 'package:flutter/material.dart';

class TableTagTitleWidget extends StatelessWidget {
  final String text;
  final Alignment textAlignment;
  final VoidCallback onPressed;

  const TableTagTitleWidget({
    super.key,
    required this.text,
    required this.onPressed,
    this.textAlignment = Alignment.centerRight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.2),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Align(
        alignment: textAlignment,
        child: InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          onTap: onPressed,
          child: Text(
            text,
            style: const TextStyle(
              color: Color(0xFF0250f7),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
