import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:pe_na_estrada_cariri/controllers/geolocalizacao.dart';
import 'package:pe_na_estrada_cariri/pages/config_page.dart';
import 'package:pe_na_estrada_cariri/pages/list_page.dart';

import 'package:pe_na_estrada_cariri/pages/fav_page.dart';
import 'package:pe_na_estrada_cariri/pages/map_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  void mudarAba(int index) {
    setState(() => _selectedIndex = index);
  }

  /// Páginas que vão aparecer no corpo
  final List<Widget> _pages = const [
    Center(child: ListPage()),
    Center(child: MapPage()),
    Center(child: FavPage()),
  ];

  /// Ícones e rótulos para o BottomNavigation
  final List<IconData> _icons = const [
    Icons.add_location_alt,
    Icons.map_outlined,
    Icons.favorite_border_outlined,
  ];

  final List<String> _titles = const ["Lista", "Mapa", "Favoritos"];

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Geolocalizacao>(
      builder: (context, geo, _) {
        // Se houver destino definido no Geolocalizacao, muda para aba do mapa automaticamente.
        if (geo.destino != null && _selectedIndex != 1) {
          _selectedIndex = 1;
          // Chama a função para centralizar no destino
          geo.irParaDestino(geo.destino!);
          geo.destino = null;
        }

        return Scaffold(
          drawer: Drawer(
            child: Column(
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(color: Colors.cyan),
                  child: Center(
                    child: Text(
                      'Menu',
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
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
                      MaterialPageRoute(builder: (context) => ConfigPage()),
                    );
                  },
                ),
              ],
            ),
          ),
          appBar: AppBar(
            toolbarHeight: 60,
            title: Text(
              _titles[_selectedIndex],
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                color: Colors.white,
                fontSize: 33,
              ),
            ),
            centerTitle: true,
            backgroundColor: Colors.cyan,
          ),
          body: IndexedStack(index: _selectedIndex, children: _pages),
          bottomNavigationBar: CurvedNavigationBar(
            height: 60,
            animationDuration: Durations.medium4,
            color: Colors.cyan,
            buttonBackgroundColor: Colors.cyan,
            backgroundColor: Colors.transparent,
            index: _selectedIndex,
            items: _icons
                .map((icon) => Icon(icon, size: 30, color: Colors.white))
                .toList(),
            onTap: _onItemTapped,
          ),
        );
      },
    );
  }
}
