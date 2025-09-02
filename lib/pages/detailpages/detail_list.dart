import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pe_na_estrada_cariri/controllers/geolocalizacao.dart';
import 'package:pe_na_estrada_cariri/controllers/trajetoria.dart';
import 'package:pe_na_estrada_cariri/models/localizacoes.dart';
import 'package:pe_na_estrada_cariri/pages/map_page.dart';
import 'package:pe_na_estrada_cariri/theme/shimmerplaceholder.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class DetailList extends StatelessWidget {
  final Localizacoes loc;
  const DetailList({super.key, required this.loc});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(toolbarHeight: 55, title: const Text('Informações')),
      body: ListView(
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: CachedNetworkImage(
              imageUrl: loc.foto,
              placeholder: (context, url) => shimmerPlaceholder(
                height: double.infinity,
                width: double.infinity,
              ),
              errorWidget: (context, url, error) => shimmerPlaceholder(
                height: double.infinity,
                width: double.infinity,
              ),
              fit: BoxFit.cover,
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  loc.nome,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  loc.endereco,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  loc.descricao,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 15),
                const Divider(height: 15),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () async {
                          final geo = context.read<Geolocalizacao>();
                          final traj = context.read<Trajetoria>();
                          final messenger = ScaffoldMessenger.of(context);

                          try {
                            final origem = await geo.getPosicao();
                            final destino = LatLng(loc.latitude, loc.longitude);

                            await traj.criarRota(origem, destino);
                            traj.iniciarNavegacao();

                            geo.addDestino(destino, loc.nome);
                            geo.destino = destino;
                            geo.irParaDestino(destino);

                            geo.iniciarStreamPosicao();

                            if (!context.mounted) return;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => MapPage(
                                  destino: destino,
                                  destinoNome: loc.nome,
                                  modoComoChegar: true,
                                ),
                              ),
                            );
                          } catch (e) {
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
