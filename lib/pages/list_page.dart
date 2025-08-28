import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pe_na_estrada_cariri/pages/detailpages/detail_list.dart';
import 'package:pe_na_estrada_cariri/repositories/loc_repository.dart';
import 'package:pe_na_estrada_cariri/theme/shimmerplaceholder.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

final LocRepository repo = LocRepository();

class _ListPageState extends State<ListPage> {
  String searchQuery = '';
  String sortOrder = 'A–Z';

  // Controle de paginação interna
  final int chunkSize = 20; // quantos itens carregar por vez
  int currentMax = 20;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        // Chegou no fim da lista, carrega mais itens
        setState(() {
          currentMax = (currentMax + chunkSize).clamp(0, filtered.length);
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  late List filtered;

  @override
  Widget build(BuildContext context) {
    // aplica filtro pelo nome
    filtered = repo.localizacoes
        .where(
          (loc) => loc.nome.toLowerCase().contains(searchQuery.toLowerCase()),
        )
        .toList();

    // aplica ordenação
    filtered.sort((a, b) {
      int cmp = a.nome.compareTo(b.nome);
      return sortOrder == 'A–Z' ? cmp : -cmp;
    });

    // Limita a quantidade de itens mostrados
    final itemsToShow = filtered.take(currentMax).toList();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
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
                      currentMax = chunkSize; // resetar chunks ao filtrar
                    });
                  },
                ),
              ),
              const SizedBox(width: 7),
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
                        currentMax = chunkSize; // resetar chunks
                      });
                    }
                  },
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: GridView.builder(
            controller: _scrollController,
            padding: const EdgeInsets.all(6),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 7,
              mainAxisSpacing: 7,
              childAspectRatio: 1.6,
            ),
            cacheExtent: 1111, // mais itens pré-carregados
            itemCount: itemsToShow.length,
            itemBuilder: (context, index) {
              final loc = itemsToShow[index];
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
                      CachedNetworkImage(
                        imageUrl: loc.foto,
                        placeholder: (context, url) => shimmerPlaceholder(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                        fit: BoxFit.fill,
                      ),
                      Container(
                        alignment: Alignment.bottomCenter,
                        padding: const EdgeInsets.all(6),
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
