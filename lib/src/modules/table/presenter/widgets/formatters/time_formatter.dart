import 'package:flutter/services.dart';

class TimeInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Se o texto for vazio, retorna o novo valor sem alterações
    if (newValue.text.isEmpty) {
      return newValue;
    }

    // Remove caracteres não numéricos
    String numStr = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    // Limita o comprimento para 4 caracteres (HHmm)
    if (numStr.length > 4) {
      numStr = numStr.substring(0, 4);
    }

    // Formata a string com dois pontos
    String formattedString = _formatTime(numStr);

    return newValue.copyWith(
      text: formattedString,
      // Mantém o cursor no final do texto
      selection: TextSelection.collapsed(offset: formattedString.length),
    );
  }

  String _formatTime(String s) {
    // Insere dois pontos entre horas e minutos
    if (s.length > 2) {
      String hour = s.substring(0, 2);
      String minute = s.substring(2);

      // Validação de hora e minuto
      int hourInt = int.parse(hour);
      int minuteInt = int.parse(minute);

      if (hourInt > 23) hour = '23';
      if (minuteInt > 59) minute = '59';

      s = '$hour:$minute';
    }

    return s;
  }
}
