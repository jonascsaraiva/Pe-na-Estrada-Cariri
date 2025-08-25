import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:pe_na_estrada_cariri/pages/list_page.dart';
import 'package:pe_na_estrada_cariri/pages/map_page.dart';
import 'package:pe_na_estrada_cariri/pages/fav_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

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
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        title: Text(
          _titles[_selectedIndex],
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Colors.white,
            fontSize: 33,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(0, 188, 212, 1),
      ),

      /// IndexedStack mantém todas as páginas carregadas na memória,melhorando eficiencia entre troca de paginas
      body: IndexedStack(index: _selectedIndex, children: _pages),

      /// Barra inferior fixa
      bottomNavigationBar: CurvedNavigationBar(
        height: 60,
        animationDuration: Durations.medium2,
        color: Colors.cyan,
        buttonBackgroundColor: Colors.cyan,
        backgroundColor: Colors.transparent,

        index: _selectedIndex,
        items: _icons
            .map((icon) => Icon(icon, size: 30, color: Colors.white))
            .toList(),
        onTap: _onItemTapped,

        //currentIndex: _selectedIndex,
        //_pages.length, (i)
        //icon: Icon(_icons[i])
        //label: _titles[i]
        //onTap: _onItemTapped,
      ),
    );
  }
}
