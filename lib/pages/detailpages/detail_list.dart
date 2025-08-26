import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pe_na_estrada_cariri/controllers/geolocalizacao.dart';
import 'package:pe_na_estrada_cariri/controllers/trajetoria.dart';
import 'package:pe_na_estrada_cariri/models/localizacoes.dart';
import 'package:provider/provider.dart';

class DetailList extends StatelessWidget {
  final Localizacoes loc;
  const DetailList({super.key, required this.loc});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        title: const Text('Informações'),
        backgroundColor: Colors.cyan,
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 33),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView(
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Image.network(loc.foto, fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  loc.nome,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  loc.endereco,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 15),
                if (loc.descricao != null)
                  Text(loc.descricao!, style: const TextStyle(fontSize: 20)),
                const SizedBox(height: 15),
                const Divider(height: 15),
                Row(
                  children: [
                    Expanded(
                      child: FilledButton.tonalIcon(
                        onPressed: () {
                          // Apenas move o mapa para o destino
                          context.read<Geolocalizacao>().irParaDestino(
                            LatLng(loc.latitude, loc.longitude),
                          );
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.map),
                        label: const Text('Ver no mapa'),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () async {
                          debugPrint("Iniciando geração de rota...");
                          final geo = context.read<Geolocalizacao>();
                          final trajetoria = context.read<Trajetoria>();
                          final navigator = Navigator.of(context);
                          final messenger = ScaffoldMessenger.of(context);

                          try {
                            debugPrint("Obtendo posição atual...");
                            final origem = await geo.getPosicao();

                            debugPrint("Posição atual: $origem");

                            final destino = LatLng(loc.latitude, loc.longitude);
                            debugPrint("Destino: $destino");

                            debugPrint("Criando rota no mapa...");
                            await trajetoria.criarRota(origem, destino);
                            debugPrint("Rota criada com sucesso!");

                            debugPrint("Adicionando marcador de destino...");
                            geo.addDestino(destino, loc.nome);
                            debugPrint("Marcador adicionado!");

                            debugPrint("Voltando para a aba do mapa...");
                            navigator.popUntil((route) => route.isFirst);
                            debugPrint("Navegação concluída!");
                          } catch (e, stack) {
                            debugPrint("Falha ao gerar rota: $e");
                            debugPrint("Stacktrace: $stack");

                            messenger.showSnackBar(
                              SnackBar(content: Text('Erro ao gerar rota: $e')),
                            );
                          }
                        },
                        icon: const Icon(Icons.directions),
                        label: const Text('Como chegar'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
