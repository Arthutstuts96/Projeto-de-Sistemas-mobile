String? validateName(value) {
  if (value!.length < 3) {
    return "Nome deve ter pelo menos 3 caracteres";
  }
  return null;
}

String? validateCpf(value){
  if (value!.length < 3) {
    return "CPF deve ter pelo menos 3 caracteres";
  }
  return null;
}