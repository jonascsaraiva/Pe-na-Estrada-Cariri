import 'package:flutter/widgets.dart';
import '../models/localizacoes.dart';

class LocRepository extends ChangeNotifier {
  final List<Localizacoes> _localizacoes = [
    Localizacoes(
      nome: 'Basílica Menor de Nossa Senhora das Dores',
      endereco:
          'Rua da Matriz, 1567 – Salgadinho, Juazeiro do Norte – CE, 63010-040',
      foto:
          'https://cdn.diocesedecrato.org/wp-content/uploads/2014/05/BASILICA1.jpg',
      latitude: -7.1983,
      longitude: -39.3164,
    ),
    Localizacoes(
      nome: 'Teleférico do Horto',
      endereco:
          'Liga a Praça dos Romeiros à Colina do Horto – Juazeiro do Norte – CE',
      foto:
          'https://www.ceara.gov.br/wp-content/uploads/2022/03/20220328164957__MG_9556_2.jpg',
      latitude: -7.2055,
      longitude: -39.3110,
    ),
    Localizacoes(
      nome: 'Museu Vivo do Padre Cícero',
      endereco: 'Casarão do Horto, Colina do Horto – Juazeiro do Norte – CE',
      foto:
          'https://tvbrasil.ebc.com.br/sites/default/files/atoms/image/fachada_museu_vivo_do_padre_cicero_grande.jpg',
      latitude: -7.2095,
      longitude: -39.3082,
    ),
    Localizacoes(
      nome: 'Trilha do Santo Sepulcro',
      endereco: 'Colina do Horto – Juazeiro do Norte – CE',
      foto:
          'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEicc14k5WOwd8voMobWzzAHhyphenhyphen2kkqLVUg9NoW79tioA5XCZUv20JS6lGgUbss49RxeTsufXM9vBGXWPJa4rAI1fVPlWilL3EJ3N0ucXzN8AMjFSyfXUAiQEnYTcfgWqoyjclgv6xTdBLgk/s1600/Pe.+Ci%25C3%25A7o+santo-sepulcro-Copia.jpg',
      latitude: -7.2132,
      longitude: -39.3048,
    ),
    Localizacoes(
      nome: 'Centro Cultural Banco do Nordeste (Cariri)',
      endereco:
          'Rua São Pedro, 337 – Centro, Juazeiro do Norte – CE, 63010-010',
      foto:
          'https://upload.wikimedia.org/wikipedia/commons/2/2a/Centro_cultural_Banco_do_Nordeste_%28Juazeiro_do_Norte%29.jpg',
      latitude: -7.2136,
      longitude: -39.3154,
    ),
  ];

  List<Localizacoes> get localizacoes => _localizacoes;
}
