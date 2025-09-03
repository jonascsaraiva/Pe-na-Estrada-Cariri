import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pe_na_estrada_cariri/models/visitados.dart';
import '../controllers/historico_controller.dart';

class HistoricoPage extends StatefulWidget {
  const HistoricoPage({super.key});

  @override
  State<HistoricoPage> createState() => _HistoricoPageState();
}

class _HistoricoPageState extends State<HistoricoPage> {
  final HistoricoController _controller = HistoricoController();
  List<Visitado> _historico = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadHistorico();
  }

  Future<void> _loadHistorico() async {
    setState(() => _loading = true);
    final data = await _controller.getHistorico();
    setState(() {
      _historico = data.reversed.toList();
      _loading = false;
    });
  }

  Future<void> limparHistorico() async {
    setState(() => _loading = true);
    await _controller.limparHistorico();
    await _loadHistorico();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: limparHistorico,
        label: const Text("Limpar"),
        icon: const Icon(Icons.delete),
      ),
      body: Builder(
        builder: (_) {
          if (_loading) return const Center(child: CircularProgressIndicator());

          if (_historico.isEmpty) {
            return RefreshIndicator(
              onRefresh: _loadHistorico,
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: const [
                  SizedBox(height: 200),
                  Center(child: Text("Nenhum lugar visitado ainda.")),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: _loadHistorico,
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: _historico.length,
              itemBuilder: (context, index) {
                final visita = _historico[index];
                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    leading: Image.network(
                      visita.destino.foto,
                      width: 60,
                      fit: BoxFit.contain,
                    ),
                    title: Text(
                      "Visitou: ${visita.destino.nome}",
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    subtitle: Text(
                      "De: ${visita.partida}\n"
                      "Para: ${visita.destino.nome}\n"
                      "Data: ${DateFormat('dd/MM/yyyy – HH:mm').format(visita.dataHora)}",
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
