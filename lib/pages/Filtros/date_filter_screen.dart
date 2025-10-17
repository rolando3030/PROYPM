import 'package:flutter/material.dart';
import '../../widgets/filter_shell.dart';
import '../../theme/app_theme.dart'; // <- esta es la ruta del theme combinado

class DateFilterScreen extends StatelessWidget {
  const DateFilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dates = [
      'Mañana',
      'Sábado 11 Octubre',
      'Domingo 12 Octubre',
      'Lunes 13 Octubre',
      'Martes 14 Octubre',
      'Miércoles 15 Octubre',
      'Jueves 16 Octubre',
      'Viernes 17 Octubre',
      'Sábado 18 Octubre',
      'Domingo 19 Octubre',
      'Lunes 20 Octubre',
      'Martes 21 Octubre',
    ];

    return FilterShell(
      headerColor: AppTheme.red,
      titleLink: 'Filtra por fecha',
      titleIcon: Icons.calendar_month_outlined,
      child: ListView.separated(
        itemCount: dates.length,
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemBuilder: (context, i) {
          return Container(
            decoration: BoxDecoration(
              color: AppTheme.red,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: Colors.white70, width: 1),
            ),
            child: ListTile(
              title: Text(
                dates[i],
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
              onTap: () => Navigator.pop(context, dates[i]),
            ),
          );
        },
      ),
    );
  }
}
