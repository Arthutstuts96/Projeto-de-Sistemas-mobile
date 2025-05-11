String? validateName(String? value) {
  if (value == null || value.trim().length < 3) {
    return "Nome deve ter pelo menos 3 caracteres";
  }
  return null;
}

String? validateCpf(String? value) {
  if (!isValidCpf(value!)) {
    return "CPF inválido";
  }
  return null;
}

String? validatePhone(String? value) {
  if (value!.length < 11) {
    return "Telefone inválido";
  }
  return null;
}

String? validateEmail(String? value) {
  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  if (value == null || !emailRegex.hasMatch(value)) {
    return "Email inválido";
  }
  return null;
}

String? validateCep(String? value) {
  final cepRegex = RegExp(r'^\d{5}-?\d{3}$');
  if (value == null || !cepRegex.hasMatch(value)) {
    return "CEP inválido";
  }
  return null;
}

String? validatePassword(String? value) {
  if (value == null || value.length < 6) {
    return "A senha deve ter pelo menos 6 dígitos";
  }
  return null;
}

String? validateConfirmPassword(String? value, String originalPassword) {
  if (value != originalPassword) {
    return "As senhas não coincidem";
  }
  return null;
}

String? validateAccount(String? value) {
  if (value == null || value.trim().length < 3) {
    return "Conta do banco inválida";
  }
  return null;
}

String? validateCarPlate(String? value) {
  final plateRegex = RegExp(r'^[A-Z]{3}-?\d{4}$');
  if (value == null || !plateRegex.hasMatch(value.toUpperCase())) {
    return "Placa do carro inválida";
  }
  return null;
}

String? validateCnh(String? value) {
  if (value == null || value.length != 11) {
    return "CNH deve conter 11 dígitos";
  }
  return null;
}

/*
  Funções auxiliares
*/

bool isValidCpf(String cpf) {
  cpf = cpf.replaceAll(RegExp(r'[^0-9]'), '');

  if (cpf.length != 11 || RegExp(r'^(\d)\1{10}$').hasMatch(cpf)) {
    return false;
  }

  int calcDigit(String str, int multiplierStart) {
    var sum = 0;
    for (int i = 0; i < str.length; i++) {
      sum += int.parse(str[i]) * (multiplierStart - i);
    }
    var mod = sum % 11;
    return mod < 2 ? 0 : 11 - mod;
  }

  final digit1 = calcDigit(cpf.substring(0, 9), 10);
  final digit2 = calcDigit(cpf.substring(0, 9) + digit1.toString(), 11);

  return cpf.endsWith('$digit1$digit2');
}

String formatDate(DateTime date) {
  final day = date.day.toString().padLeft(2, '0');
  final month = date.month.toString().padLeft(2, '0');
  final year = date.year.toString();

  return "$day/$month/$year";
}

