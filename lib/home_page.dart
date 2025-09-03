import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:pe_na_estrada_cariri/pages/config_page.dart';
import 'package:pe_na_estrada_cariri/pages/historico_page.dart';
import 'package:pe_na_estrada_cariri/pages/list_page.dart';
import 'package:pe_na_estrada_cariri/pages/fav_page.dart';
import 'package:pe_na_estrada_cariri/pages/map_page.dart';
import 'package:pe_na_estrada_cariri/theme/dark_theme.dart';
import 'package:pe_na_estrada_cariri/theme/light_theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [ListPage(), MapPage(), HistoricoPage()];

  final List<IconData> _icons = const [
    Icons.add_location_alt,
    Icons.map,
    Icons.history_toggle_off,
  ];

  final List<String> _titles = const ["Lista", "Mapa", "Histórico"];

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Theme.of(context).primaryColor),
              child: const Center(
                child: Text(
                  'Menu',
                  style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.favorite, size: 24),
              title: const Text(
                'Favoritos',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const FavPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings, size: 24),
              title: const Text(
                'Configurações',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ConfigPage()),
                );
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(title: Text(_titles[_selectedIndex]), toolbarHeight: 55),
      body: IndexedStack(index: _selectedIndex, children: _pages),
      bottomNavigationBar: CurvedNavigationBar(
        height: 55,
        animationDuration: const Duration(milliseconds: 400),
        color: isDark ? AppThemeDark.curvedButton : AppThemeLight.curvedButton,
        buttonBackgroundColor: isDark
            ? AppThemeDark.curvedButton
            : AppThemeLight.curvedButton,
        backgroundColor: isDark
            ? AppThemeDark.curvedBackground
            : AppThemeLight.curvedBackground,
        index: _selectedIndex,
        items: _icons
            .map(
              (icon) => Icon(
                icon,
                size: 30,
                color: _selectedIndex == _icons.indexOf(icon)
                    ? (isDark
                          ? AppThemeDark.curvedIconSelected
                          : AppThemeLight.curvedIconSelected)
                    : (isDark
                          ? AppThemeDark.curvedIconUnselected
                          : AppThemeLight.curvedIconUnselected),
              ),
            )
            .toList(),
        onTap: _onItemTapped,
      ),
    );
  }
}
