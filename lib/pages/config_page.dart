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
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color.fromARGB(255, 0, 187, 212),
        toolbarHeight: 60,
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('Tema Escuro'),
            value: themeSettings.isDark,
            onChanged: (value) async {
              await themeSettings.setDark(value); // Atualiza instantaneamente
            },
          ),
        ],
      ),
    );
  }
}
