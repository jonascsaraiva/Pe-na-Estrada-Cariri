import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:pe_na_estrada_cariri/controllers/darkmode.dart';
import 'package:pe_na_estrada_cariri/controllers/trajetoria.dart';
import 'package:pe_na_estrada_cariri/home_page.dart';
import 'package:pe_na_estrada_cariri/controllers/geolocalizacao.dart';
import 'package:pe_na_estrada_cariri/models/localizacoes.dart';
import 'package:pe_na_estrada_cariri/models/visitados.dart';
import 'package:pe_na_estrada_cariri/theme/dark_theme.dart';
import 'package:pe_na_estrada_cariri/theme/light_theme.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(LocalizacoesAdapter());
  Hive.registerAdapter(VisitadoAdapter());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Geolocalizacao()),
        ChangeNotifierProvider(create: (_) => Trajetoria()),
        ChangeNotifierProvider(create: (_) => ThemeSettings()),
      ],
      child: Consumer<ThemeSettings>(
        builder: (context, themeSettings, _) {
          return MaterialApp(
            title: 'Pé na estrada Cariri',
            debugShowCheckedModeBanner: false,
            // Tema claro externo
            theme: AppThemeLight.theme,
            //  Tema escuro externo
            darkTheme: AppThemeDark.theme,
            themeMode: themeSettings.isDark ? ThemeMode.dark : ThemeMode.light,
            home: const HomePage(),
          );
        },
      ),
    );
  }
}
