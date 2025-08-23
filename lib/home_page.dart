import 'package:flutter/material.dart';
import 'package:pe_na_estrada_cariri/pages/map_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  /// Páginas que vão aparecer no corpo
  final List<Widget> _pages = const [
    Center(child: Text("Lista de lugares culturais com descrição e imagem")),
    Center(child: MapPage()),
    Center(child: Text("Favoritos pagina aqui")),
  ];

  /// Ícones e rótulos para o BottomNavigation
  final List<IconData> _icons = const [
    Icons.account_circle_outlined,
    Icons.map_outlined,
    Icons.favorite,
  ];

  final List<String> _titles = const ["Lista", "Mapa", "Favoritos"];

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _titles[_selectedIndex],
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(0, 188, 212, 1),
      ),

      /// IndexedStack mantém todas as páginas carregadas na memória
      body: IndexedStack(index: _selectedIndex, children: _pages),

      /// Barra inferior fixa
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: const Color.fromARGB(255, 0, 187, 212),
        selectedItemColor: const Color.fromARGB(255, 0, 0, 0),
        unselectedItemColor: const Color.fromARGB(255, 231, 231, 231),
        type: BottomNavigationBarType.fixed,
        items: List.generate(_pages.length, (i) {
          return BottomNavigationBarItem(
            icon: Icon(_icons[i]),
            label: _titles[i],
          );
        }),
      ),
    );
  }
}
