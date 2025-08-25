import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pe_na_estrada_cariri/controllers/geolocalizacao.dart';
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
                      child: FilledButton.tonalIcon(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Função de trajeto ainda não implementada.',
                              ),
                            ),
                          );
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
