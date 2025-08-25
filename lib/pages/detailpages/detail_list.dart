import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pe_na_estrada_cariri/models/localizacoes.dart';
import 'package:pe_na_estrada_cariri/pages/map_page.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailList extends StatelessWidget {
  final Localizacoes loc;
  const DetailList({super.key, required this.loc});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        title: Text('Informações'),
        backgroundColor: Colors.cyan,
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 33),
        iconTheme: IconThemeData(color: Colors.white),
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
                Divider(height: 15),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => MapPage(
                                destino: LatLng(loc.latitude, loc.longitude),
                                destinoNome: loc.nome,
                              ),
                            ),
                          );
                        },
                        icon: const Icon(Icons.map),
                        label: const Text('Ver no mapa'),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () async {
                          final url = Uri.parse(
                            'https://www.google.com/maps/dir/?api=1&destination=${loc.latitude},${loc.longitude}&travelmode=driving',
                          );
                          await launchUrl(
                            url,
                            mode: LaunchMode.externalApplication,
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
