import 'package:flutter/material.dart';
import 'package:pe_na_estrada_cariri/models/localizacoes.dart';

class PostosRepository extends ChangeNotifier {
  final List<Localizacoes> _postos = [
    Localizacoes(
      nome: 'Basílica Menor de Nossa Senhora das Dores',
      endereco:
          'Rua da Matriz, 1567 – Salgadinho, Juazeiro do Norte – CE, 63010-040',
      foto:
          'https://upload.wikimedia.org/wikipedia/commons/0/0a/Bas%C3%ADlica_de_Nossa_Senhora_das_Dores_-_Juazeiro_do_Norte.jpg',
      latitude: -7.1983,
      longitude: -39.3164,
    ),
    Localizacoes(
      nome: 'Teleférico do Horto',
      endereco:
          'Liga a Praça dos Romeiros à Colina do Horto – Juazeiro do Norte – CE',
      foto:
          'https://upload.wikimedia.org/wikipedia/commons/6/64/Telef%C3%A9rico_do_Horto_-_Juazeiro_do_Norte.jpg',
      latitude: -7.2055,
      longitude: -39.3110,
    ),
    Localizacoes(
      nome: 'Museu Vivo do Padre Cícero',
      endereco: 'Casarão do Horto, Colina do Horto – Juazeiro do Norte – CE',
      foto:
          'https://upload.wikimedia.org/wikipedia/commons/1/12/Museu_Vivo_Padre_C%C3%ADcero_-_Juazeiro_do_Norte.jpg',
      latitude: -7.2095,
      longitude: -39.3082,
    ),
    Localizacoes(
      nome: 'Trilha do Santo Sepulcro',
      endereco: 'Colina do Horto – Juazeiro do Norte – CE',
      foto:
          'https://upload.wikimedia.org/wikipedia/commons/9/9e/Santo_Sepulcro_Juazeiro_do_Norte.jpg',
      latitude: -7.2132,
      longitude: -39.3048,
    ),
    Localizacoes(
      nome: 'Centro Cultural Banco do Nordeste (Cariri)',
      endereco:
          'Rua São Pedro, 337 – Centro, Juazeiro do Norte – CE, 63010-010',
      foto:
          'https://upload.wikimedia.org/wikipedia/commons/f/fd/Centro_Cultural_Banco_do_Nordeste_-_Juazeiro_do_Norte.jpg',
      latitude: -7.2136,
      longitude: -39.3154,
    ),
  ];

  List<Localizacoes> get postos => _postos;
}
