import 'package:flutter/material.dart';
import '../../widgets/filter_shell.dart';
import '../../theme/app_theme.dart'; // <- esta es la ruta del theme combinado

class CityFilterScreen extends StatelessWidget {
  const CityFilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cities = [
      'Lima',
      'Chiclayo',
      'Juliaca',
      'Arequipa',
      'Huancayo',
      'Cusco',
      'Huanuco',
      'Piura',
      'Tacna',
      'Trujillo',
      'Pucallpa',
      'Cajamarca',
      'Puno',
    ];

    return FilterShell(
      headerColor: AppTheme.purple,
      titleLink: 'Filtra por ciudad',
      titleIcon: Icons.location_on_outlined,
      child: ListView.separated(
        itemCount: cities.length,
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemBuilder: (context, i) {
          return Container(
            decoration: BoxDecoration(
              color: AppTheme.purple,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: Colors.white70, width: 1),
            ),
            child: ListTile(
              title: Text(
                cities[i],
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
              onTap: () => Navigator.pop(context, cities[i]),
            ),
          );
        },
      ),
    );
  }
}
