import 'package:flutter/material.dart';
import '../../widgets/filter_shell.dart';
import '../../theme/app_theme.dart'; // <- esta es la ruta del theme combinado

class MoreFilterScreen extends StatefulWidget {
  const MoreFilterScreen({super.key});
  @override
  State<MoreFilterScreen> createState() => _MoreFilterScreenState();
}

class _MoreFilterScreenState extends State<MoreFilterScreen> {
  final Map<String, bool> genres = {
    'Acción': true,
    'Animación': false,
    'Anime': false,
    'Biografía': false,
    'Comedia': false,
    'Concierto': false,
    'Drama': false,
    'Familiar': false,
    'Romance': false,
  };
  final Map<String, bool> languages = {
    'Español': true,
    'Inglés': false,
    'Subtitulado': false,
  };
  final Map<String, bool> formats = {
    '2D': true,
    '3D': false,
    'ScreenX': false,
    'Xtreme': false,
    'VIP': false,
  };
  final Map<String, bool> ratings = {'APT': true, '+14': false, '+18': false};

  Widget _section(String title, Map<String, bool> map) {
    return ExpansionTile(
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
      ),
      collapsedBackgroundColor: AppTheme.blue,
      backgroundColor: AppTheme.blue,
      collapsedIconColor: Colors.white,
      iconColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      children: map.keys.map((k) {
        return CheckboxListTile(
          value: map[k],
          onChanged: (v) => setState(() => map[k] = v ?? false),
          title: Text(k, style: const TextStyle(color: Colors.white)),
          checkColor: Colors.white,
          activeColor: Colors.white24,
          side: const BorderSide(color: Colors.white70),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FilterShell(
      headerColor: AppTheme.blue,
      titleLink: 'Borrar filtro',
      titleIcon: Icons.filter_alt_outlined,
      bottomBar: SizedBox(
        height: 64,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.red,
            foregroundColor: Colors.white,
            shape: const RoundedRectangleBorder(),
          ),
          onPressed: () => Navigator.pop(context, {
            'genres': genres,
            'languages': languages,
            'formats': formats,
            'ratings': ratings,
          }),
          child: const Text(
            'Filtrar',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
        ),
      ),
      child: ListView(
        children: [
          _section('Género', genres),
          const SizedBox(height: 8),
          _section('Idioma', languages),
          const SizedBox(height: 8),
          _section('Formato', formats),
          const SizedBox(height: 8),
          _section('Censura', ratings),
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}
