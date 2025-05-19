import 'package:flutter/material.dart';

Future<void> selectTime(BuildContext context, int initialTime, int finalTime) async {
  final TimeOfDay? horarioSelecionado = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
    builder: (context, child) {
      return MediaQuery(
        data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
        child: child!,
      );
    },
  );

  if (horarioSelecionado != null) {
    final int minutos = horarioSelecionado.hour * 60 + horarioSelecionado.minute;
    int inicioPermitido = initialTime * 60;   
    int fimPermitido = finalTime * 60;     

    if (minutos < inicioPermitido || minutos > fimPermitido) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Horário inválido'),
          content: Text('Escolha um horário entre 08:00 e 21:00.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Ok'),
            ),
          ],
        ),
      );
      return;
    }
    print('Horário escolhido: ${horarioSelecionado.format(context)}');
  }
}
