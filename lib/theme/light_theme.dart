import 'package:flutter/material.dart';

class AppThemeLight {
  static final ThemeData theme = ThemeData(
    brightness: Brightness.light,
    fontFamily: 'PlayfairDisplay',
    primaryColor: Colors.cyan,
    scaffoldBackgroundColor: Colors.white, // fundo da tela

    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.cyan,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.w700,
        color: Colors.white,
        fontSize: 33,
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.cyan,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      elevation: 4,
    ),

    // Textos do body
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: Colors.white), // ListPage
      bodyLarge: TextStyle(color: Color.fromARGB(179, 0, 0, 0)), // Detail page
    ),

    // Drawer separado
    drawerTheme: const DrawerThemeData(backgroundColor: Colors.white),
    listTileTheme: const ListTileThemeData(
      iconColor: Colors.black87,
      textColor: Colors.black87,
    ),

    // Ícones fora do AppBar/Drawer
    iconTheme: const IconThemeData(color: Colors.black87),

    // Barra de pesquisa, TextField, Dropdown
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      hintStyle: TextStyle(color: Colors.grey[600]),
      labelStyle: const TextStyle(color: Colors.black87),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    ),

    // Divider
    dividerTheme: const DividerThemeData(
      color: Colors.grey, // define a cor
      thickness: 1.2,
    ),

    // Navigation Bar
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.transparent,
      selectedItemColor: Colors.cyan,
      unselectedItemColor: Colors.black87,
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.cyan,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: Colors.cyan),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.cyan,
        side: const BorderSide(color: Colors.cyan),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
    ),
  );

  static final Color curvedBackground = Colors.transparent; // fundo
  static final Color curvedButton = Colors.cyan; // botão central
  static final Color curvedIconSelected = Colors.white; // ícone ativo
  static final Color curvedIconUnselected = Colors.white; // ícone inativo
}
