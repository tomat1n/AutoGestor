import 'package:flutter/services.dart';

/// Formatter para CPF (000.000.000-00)
class CpfInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text.replaceAll(RegExp(r'\D'), '');
    
    if (text.length > 11) {
      return oldValue;
    }
    
    String formatted = '';
    for (int i = 0; i < text.length; i++) {
      if (i == 3 || i == 6) {
        formatted += '.';
      } else if (i == 9) {
        formatted += '-';
      }
      formatted += text[i];
    }
    
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

/// Formatter para CNPJ (00.000.000/0000-00)
class CnpjInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text.replaceAll(RegExp(r'\D'), '');
    
    if (text.length > 14) {
      return oldValue;
    }
    
    String formatted = '';
    for (int i = 0; i < text.length; i++) {
      if (i == 2 || i == 5) {
        formatted += '.';
      } else if (i == 8) {
        formatted += '/';
      } else if (i == 12) {
        formatted += '-';
      }
      formatted += text[i];
    }
    
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

/// Formatter para CEP (00000-000)
class CepInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text.replaceAll(RegExp(r'\D'), '');
    
    if (text.length > 8) {
      return oldValue;
    }
    
    String formatted = '';
    for (int i = 0; i < text.length; i++) {
      if (i == 5) {
        formatted += '-';
      }
      formatted += text[i];
    }
    
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

/// Formatter para telefone (00) 0000-0000 ou (00) 00000-0000
class TelefoneInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text.replaceAll(RegExp(r'\D'), '');
    
    if (text.length > 11) {
      return oldValue;
    }
    
    String formatted = '';
    for (int i = 0; i < text.length; i++) {
      if (i == 0) {
        formatted += '(';
      } else if (i == 2) {
        formatted += ') ';
      } else if ((text.length == 10 && i == 6) || (text.length == 11 && i == 7)) {
        formatted += '-';
      }
      formatted += text[i];
    }
    
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

/// Formatter para moeda (R$ 0,00)
class CurrencyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text.replaceAll(RegExp(r'[^\d]'), '');
    
    if (text.isEmpty) {
      return const TextEditingValue(
        text: 'R\$ 0,00',
        selection: TextSelection.collapsed(offset: 7),
      );
    }
    
    final value = int.parse(text);
    final formatted = 'R\$ ${(value / 100).toStringAsFixed(2).replaceAll('.', ',')}';
    
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

/// Utilitários para formatação
class FormatUtils {
  /// Formata CPF
  static String formatCpf(String cpf) {
    final digits = cpf.replaceAll(RegExp(r'\D'), '');
    if (digits.length != 11) return cpf;
    
    return '${digits.substring(0, 3)}.${digits.substring(3, 6)}.${digits.substring(6, 9)}-${digits.substring(9)}';
  }
  
  /// Formata CNPJ
  static String formatCnpj(String cnpj) {
    final digits = cnpj.replaceAll(RegExp(r'\D'), '');
    if (digits.length != 14) return cnpj;
    
    return '${digits.substring(0, 2)}.${digits.substring(2, 5)}.${digits.substring(5, 8)}/${digits.substring(8, 12)}-${digits.substring(12)}';
  }
  
  /// Formata CEP
  static String formatCep(String cep) {
    final digits = cep.replaceAll(RegExp(r'\D'), '');
    if (digits.length != 8) return cep;
    
    return '${digits.substring(0, 5)}-${digits.substring(5)}';
  }
  
  /// Formata telefone
  static String formatTelefone(String telefone) {
    final digits = telefone.replaceAll(RegExp(r'\D'), '');
    
    if (digits.length == 10) {
      return '(${digits.substring(0, 2)}) ${digits.substring(2, 6)}-${digits.substring(6)}';
    } else if (digits.length == 11) {
      return '(${digits.substring(0, 2)}) ${digits.substring(2, 7)}-${digits.substring(7)}';
    }
    
    return telefone;
  }
  
  /// Remove formatação de documento
  static String removeFormatting(String text) {
    return text.replaceAll(RegExp(r'\D'), '');
  }
  
  /// Valida CPF
  static bool isValidCpf(String cpf) {
    final digits = cpf.replaceAll(RegExp(r'\D'), '');
    
    if (digits.length != 11) return false;
    if (RegExp(r'^(\d)\1*\$').hasMatch(digits)) return false;
    
    // Validação do primeiro dígito
    int sum = 0;
    for (int i = 0; i < 9; i++) {
      sum += int.parse(digits[i]) * (10 - i);
    }
    int firstDigit = 11 - (sum % 11);
    if (firstDigit >= 10) firstDigit = 0;
    
    if (int.parse(digits[9]) != firstDigit) return false;
    
    // Validação do segundo dígito
    sum = 0;
    for (int i = 0; i < 10; i++) {
      sum += int.parse(digits[i]) * (11 - i);
    }
    int secondDigit = 11 - (sum % 11);
    if (secondDigit >= 10) secondDigit = 0;
    
    return int.parse(digits[10]) == secondDigit;
  }
  
  /// Valida CNPJ
  static bool isValidCnpj(String cnpj) {
    final digits = cnpj.replaceAll(RegExp(r'\D'), '');
    
    if (digits.length != 14) return false;
    if (RegExp(r'^(\d)\1*\$').hasMatch(digits)) return false;
    
    // Validação do primeiro dígito
    const weights1 = [5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2];
    int sum = 0;
    for (int i = 0; i < 12; i++) {
      sum += int.parse(digits[i]) * weights1[i];
    }
    int firstDigit = sum % 11;
    firstDigit = firstDigit < 2 ? 0 : 11 - firstDigit;
    
    if (int.parse(digits[12]) != firstDigit) return false;
    
    // Validação do segundo dígito
    const weights2 = [6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2];
    sum = 0;
    for (int i = 0; i < 13; i++) {
      sum += int.parse(digits[i]) * weights2[i];
    }
    int secondDigit = sum % 11;
    secondDigit = secondDigit < 2 ? 0 : 11 - secondDigit;
    
    return int.parse(digits[13]) == secondDigit;
  }
}