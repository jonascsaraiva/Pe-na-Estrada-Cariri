import 'package:flutter/material.dart';
import 'package:pe_na_estrada_cariri/repositories/loc_repository.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

final LocRepository repo = LocRepository();

class _ListPageState extends State<ListPage> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        //Quantidade de Cards por linhas
        crossAxisCount: 2,
        //Espaçamento Horizontal ente os Cards
        crossAxisSpacing: 6,
        //Vertical
        mainAxisSpacing: 6,
        // Mantém o formato quadrado no 1
        childAspectRatio: 0.9,
      ),

      // Aqui pega a localização por cada index no repositorio e cria um card para cada item da lista.
      itemCount: repo.localizacoes.length,
      itemBuilder: (context, index) {
        final loc = repo.localizacoes[index];
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          clipBehavior: Clip.hardEdge,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.network(loc.foto, fit: BoxFit.fill),
              Container(
                alignment: Alignment.bottomCenter,
                padding: const EdgeInsets.all(6),
                color: Colors.black54,
                child: Text(
                  loc.nome,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
