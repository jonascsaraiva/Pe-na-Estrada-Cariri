import 'package:flutter/material.dart';
import 'package:pe_na_estrada_cariri/pages/detailpages/detail_list.dart';
import 'package:pe_na_estrada_cariri/repositories/loc_repository.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

final LocRepository repo = LocRepository();

class _ListPageState extends State<ListPage> {
  String searchQuery = '';
  String sortOrder = 'A–Z';

  @override
  Widget build(BuildContext context) {
    // aplica filtro pelo nome
    List filtered = repo.localizacoes
        .where(
          (loc) => loc.nome.toLowerCase().contains(searchQuery.toLowerCase()),
        )
        .toList();

    // aplica ordenação
    filtered.sort((a, b) {
      int cmp = a.nome.compareTo(b.nome);
      return sortOrder == 'A–Z' ? cmp : -cmp;
    });

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              // Barra de busca aqui
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Pesquisar',
                    prefixIcon: const Icon(Icons.search),

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value;
                    });
                  },
                ),
              ),
              const SizedBox(width: 7),
              // Dropdow de ordenação aqui
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white),
                ),
                child: DropdownButton<String>(
                  value: sortOrder,
                  items: const [
                    DropdownMenuItem(
                      value: 'A–Z',
                      child: Text('Crescente', style: TextStyle(fontSize: 15)),
                    ),
                    DropdownMenuItem(
                      value: 'Z–A',
                      child: Text(
                        'Decrescente',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        sortOrder = value;
                      });
                    }
                  },
                ),
              ),
            ],
          ),
        ),

        // Lista dos blocos
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(6),
            //Aqui estiliza os blocos da lista
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 7,
              mainAxisSpacing: 7,
              childAspectRatio: 1.6,
            ),
            itemCount: filtered.length,
            itemBuilder: (context, index) {
              final loc = filtered[index];
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => DetailList(loc: loc)),
                  );
                },
                child: Card(
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
                        //Efeito aplicado a imagem da lista, deixando ela um pouco mais escura.
                        color: const Color.fromARGB(110, 0, 0, 0),
                        child: Text(
                          loc.nome,
                          style: const TextStyle(
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
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
