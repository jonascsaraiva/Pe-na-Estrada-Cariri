import 'package:flutter/material.dart';
import 'package:pe_na_estrada_cariri/controllers/darkmode.dart';
import 'package:pe_na_estrada_cariri/controllers/trajetoria.dart';
import 'package:pe_na_estrada_cariri/home_page.dart';
import 'package:pe_na_estrada_cariri/controllers/geolocalizacao.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
            theme: ThemeData(
              primarySwatch: Colors.cyan,
              fontFamily: 'PlayfairDisplay',
              brightness: Brightness.light,
            ),
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              fontFamily: 'PlayfairDisplay',
            ),
            themeMode: themeSettings.isDark ? ThemeMode.dark : ThemeMode.light,
            home: const HomePage(),
          );
        },
      ),
    );
  }
}
