import 'package:flutter/material.dart';

class AppThemeDark {
  static final ThemeData theme = ThemeData(
    brightness: Brightness.dark,
    fontFamily: 'PlayfairDisplay',
    primaryColor: Colors.grey[850],
    scaffoldBackgroundColor: Colors.grey[900],

    appBarTheme: AppBarTheme(
      backgroundColor: Colors.grey[850],
      centerTitle: true,
      titleTextStyle: const TextStyle(
        fontWeight: FontWeight.w700,
        color: Colors.white,
        fontSize: 33,
      ),
      iconTheme: const IconThemeData(color: Colors.white),
    ),

    drawerTheme: DrawerThemeData(backgroundColor: Colors.grey[900]),

    listTileTheme: const ListTileThemeData(
      iconColor: Colors.white70,
      textColor: Colors.white,
    ),

    dividerTheme: const DividerThemeData(color: Colors.white24, thickness: 1),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.grey[850],
      selectedItemColor: Colors.cyanAccent,
      unselectedItemColor: Colors.white70,
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.cyanAccent,
        foregroundColor: Colors.black,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: Colors.cyanAccent),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.cyanAccent,
        side: const BorderSide(color: Colors.cyanAccent),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
    ),
  );

  // CurvedNavigationBar cores separadas
  static final Color curvedBackground = Colors.transparent; // fundo
  static final Color curvedButton = const Color.fromARGB(
    255,
    48,
    48,
    48,
  ); // botão central
  static final Color curvedIconSelected = Colors.white; // ícone ativo
  static final Color curvedIconUnselected = Colors.white70; // ícone inativo
}
