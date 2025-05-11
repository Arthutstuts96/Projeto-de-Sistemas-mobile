// Validações específicas para login
String? validateLoginEmail(String? value) {
  if (value == null || value.isEmpty) {
    return "Por favor, insira seu e-mail";
  }

  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  if (!emailRegex.hasMatch(value)) {
    return "E-mail inválido";
  }

  return null;
}

String? validateLoginPassword(String? value) {
  if (value == null || value.isEmpty) {
    return "Por favor, insira sua senha";
  }

  if (value.length < 6) {
    return "Senha deve ter pelo menos 6 caracteres";
  }

  return null;
}
