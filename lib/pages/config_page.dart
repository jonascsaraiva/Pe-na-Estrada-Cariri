import 'package:flutter/material.dart';
import 'package:pe_na_estrada_cariri/controllers/darkmode.dart';
import 'package:provider/provider.dart';

class ConfigPage extends StatefulWidget {
  const ConfigPage({super.key});

  @override
  State<ConfigPage> createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  @override
  Widget build(BuildContext context) {
    final themeSettings = Provider.of<ThemeSettings>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Configurações',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        toolbarHeight: 55,
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text(
              'Tema Escuro',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            value: themeSettings.isDark,
            onChanged: (value) async {
              await themeSettings.setDark(value);
            },
          ),
          Divider(height: 0.1),
        ],
      ),
    );
  }
}
