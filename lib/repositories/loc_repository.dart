import 'package:flutter/widgets.dart';
import '../models/localizacoes.dart';

class LocRepository extends ChangeNotifier {
  final List<Localizacoes> _localizacoes = [
    Localizacoes(
      nome: 'Mosteiro de Nossa Senhora da Vitória',
      endereco:
          'R. do Mosteiro, 100 - Tiradentes, Juazeiro do Norte - CE, 63031-350',
      foto:
          'https://hospedaria-do-mosteiro-nossa-sra-da-vitoria-guest-house.ceara-hotels.com/data/Images/OriginalPhoto/9820/982050/982050871/image-juazeiro-do-norte-hospedaria-do-mosteiro-nossa-sra-da-vitoria-2.JPEG',
      latitude: -7.233113365735548,
      longitude: -39.283650028835645,
      descricao:
          'O Mosteiro de Nossa Senhora da Vitória foi fundado em 21 de novembro de 1982, na cidade histórica de São Cristóvão - SE, pelo Mosteiro de Nossa Senhora de Monte em Olinda.',
    ),
    Localizacoes(
      nome: 'Aeroporto de Juazeiro do Norte - Orlando Bezerra de Menezes',
      endereco:
          'Av. Gov. Virgílio Távora, 4000 - Aeroporto, Juazeiro do Norte - CE, 63020-735',
      foto:
          'https://mais.opovo.com.br/_midias/jpg/2019/09/06/aeroporto_juazeiro-3676777.jpg',
      latitude: -7.214947759016707,
      longitude: -39.2722566056472,
      descricao:
          'O Aeroporto de Juazeiro do Norte - Orlando Bezerra de Menezes se destaca pelo turismo de negócios e também por ser o único localizado no sul do estado do Ceará.',
    ),
    Localizacoes(
      nome: 'Alameda Juazeiro – Centro de Gastronomia Rita Araújo da Silva',
      endereco:
          'Rua São Francisco S/N - Centro, Juazeiro do Norte - CE, 63010-475',
      foto:
          'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEisKrWjS8-ZHI0NNQ7_nyHCROCoomYBLbfDIQPl-l21iaVsv32k6sDXLslW889ln3YwuFyv2IfBfsNnjivBsqoD_zMi_rfQTddZ4wCkDF8j-yNmTnugLSj2vngSdUmAyD0_r6WjDcSoZAY/s1600/DP1.jpg',
      latitude: -7.201374864573752,
      longitude: -39.318850605647384,
      descricao:
          'Um novo espaço de cultura, lazer, turismo e gastronomia em Juazeiro do Norte. O local também recebe shows de bandas regionais em palco montado ocasionalmente.',
    ),
    Localizacoes(
      nome: 'Arena Romeirão',
      endereco:
          'Av. Pres. Castelo Branco, 4464 - Pirajá, Juazeiro do Norte - CE, 63036-230',
      foto:
          'https://str.paineladm.com/arquivos/4248/noticias/not-4248-20230712060400.jpeg',
      latitude: -7.223113818972147,
      longitude: -39.3175275056469,
      descricao:
          'A Arena Romeirão (anteriormente Arena Mauro Sampaio) é um estádio e arena multiuso de futebol, inaugurado em 1º de maio de 1970. É o local onde o Icasa e o Guarani de Juazeiro mandam seus jogos.',
    ),
    Localizacoes(
      nome: 'Artesanato Mãe das Dores',
      endereco:
          'Rua Padre Cícero, 210 - Centro, Juazeiro do Norte - CE, 63010-020 (Próximo à Basílica Nossa Senhora das Dores)',
      foto:
          'https://mapacultural.secult.ce.gov.br/files/agent/27714/20181004_114445[1].jpg',
      latitude: -7.199898131149588,
      longitude: -39.31773941914046,
      descricao:
          'O Artesanato Mãe das Dores tem como objetivo contribuir para o fortalecimento do artesanato, preservando a identidade cultural e regional do Cariri cearense.',
    ),
    Localizacoes(
      nome: 'Basílica Nossa Senhora das Dores',
      endereco:
          'R. Padre Cícero, 147 - Centro, Juazeiro do Norte - CE, 63010-020',
      foto:
          'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/06/9c/58/37/matriz-de-nossa-senhora.jpg?w=900&h=500&s=1',
      latitude: -7.1983,
      longitude: -39.3164,
      descricao:
          'Conhecida popularmente como a Matriz, a Basílica Nossa Senhora das Dores é a igreja que recebe a maior concentração de romeiros da cidade.',
    ),
    Localizacoes(
      nome: 'Biblioteca Pública Municipal',
      endereco:
          'R. Santo Agostinho, 300 - Centro, Juazeiro do Norte - CE, 63010-167',
      foto:
          'https://static.wixstatic.com/media/8d1fd2_7a424904ca7f42119e9a7b5b6980f010~mv2.jpg/v1/fill/w_853,h_568,al_c,q_85/8d1fd2_7a424904ca7f42119e9a7b5b6980f010~mv2.jpg',
      latitude: -7.20760976764244,
      longitude: -39.316012134483,
      descricao:
          'A Biblioteca Pública Municipal conta com espaços amplos de leitura, auditório, sala de jogos, laboratório de informática, ambiente infantil, banheiros, além de sala de braille e rampa de acessibilidade.',
    ),
    Localizacoes(
      nome: 'Capela de Nossa Senhora do Perpétuo Socorro',
      endereco:
          'Praça do Cinquentenário S/N - Socorro, Juazeiro do Norte - CE, 63010-459',
      foto:
          'https://fabiolamusarra.wordpress.com/wp-content/uploads/2016/05/capela-de-nossa-senhora-do-perpc3a9tuo-socorro-juazeiro-do-norte-ce.jpg',
      latitude: -7.202196609157126,
      longitude: -39.321209976811716,
      descricao:
          'Também conhecida como Capela do Socorro, teve sepultados em seu altar-mor os restos mortais do Padre Cícero, no dia 21 de julho de 1934.',
    ),
    Localizacoes(
      nome: 'Cariri Shopping',
      endereco:
          'Av. Padre Cícero, 2555 - Triângulo, Juazeiro do Norte - CE, 63041-145',
      foto:
          'https://emjuazeirodonorte.com.br/wp-content/uploads/2024/03/capa-1.jpeg',
      latitude: -7.223079687892461,
      longitude: -39.32454394797563,
      descricao:
          'O Cariri Shopping oferece conforto, comodidade e segurança, servindo como centro de lazer, compras e entretenimento para toda a população do Cariri.',
    ),
    Localizacoes(
      nome: 'Museu Cívico e Religioso Casa do Pe. Cícero',
      endereco:
          'R. São José, 242 - Salgadinho, Juazeiro do Norte - CE, 63011-038',
      foto:
          'https://scontent.fjdo10-2.fna.fbcdn.net/v/t39.30808-6/481056771_1236707431353053_4986513299547184629_n.jpg?_nc_cat=107&ccb=1-7&_nc_sid=127cfc&_nc_ohc=KfSUmFTVQxUQ7kNvwFwfE39&_nc_oc=AdmRGrZ_OPG0PaHwCCzrStQs7LhB4nLzRitnEWFxww07SFYYY1X19UDZ3ZueSv7aJjA&_nc_zt=23&_nc_ht=scontent.fjdo10-2.fna&_nc_gid=nHU5qAcbO-HpIx-pn3L1tA&oh=00_AfUSCpcqwt3DCmtNLuEQZyTHnMIWOPaUAg-OnGydb-Sq9Q&oe=68B27B83',
      latitude: -7.199783603629208,
      longitude: -39.31855673221595,
      descricao:
          'A casa foi moradia do sacerdote na zona urbana de Juazeiro do Norte durante sua vida. Hoje, o lugar abriga uma variedade de objetos históricos e religiosos relacionados ao Padre Cícero.',
    ),
    Localizacoes(
      nome: 'Centro Cultural Banco do Nordeste - CCBNB Cariri',
      endereco:
          'Rua São Pedro, 337 - Centro, Juazeiro do Norte - CE, 63010-010',
      foto:
          'https://media-cdn.tripadvisor.com/media/photo-p/10/68/b9/c7/fachada-ccbnb-cariri.jpg',
      latitude: -7.202059976546933,
      longitude: -39.31725434982565,
      descricao:
          'Oferecendo a seus visitantes uma variada programação diária e gratuita, o Centro Cultural Cariri tem sua sede dentro do Banco do Nordeste.',
    ),
    Localizacoes(
      nome: 'Centro de Convenções do Cariri',
      endereco: 'Av. Padre Cícero, 4400 - Muriti, Crato - CE',
      foto:
          'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEj_g2X5TX-XmRyOz7N0GdqgjXze5Iz1bjyMbiiMOtQzMojtpewyuDyif-KrQEYWvg4PZz6K4Cbs_tth690WTH6dUA_30LJMUpnOESzFA5OdF1hfrM_m9zqXm_AbKLDwCKx9fC6l-dOohDTEtUVqVwzFP6mosP775iVpxi053Z-Di1UQk2YZSNCrJ3BYwT8/s1200/dp.jpg',
      latitude: -7.229391665463148,
      longitude: -39.37020420564673,
      descricao:
          'O Centro de Convenções do Cariri (CCC) tem capacidade para receber seminários, cursos profissionalizantes, exposições, feiras, teatro, entre outros eventos.',
    ),
    Localizacoes(
      nome: 'Centro Mestre Noza - Associação dos Artesãos de Juazeiro do Norte',
      endereco: 'R. São Luiz, 93 - Centro, Juazeiro do Norte - CE, 63010-125',
      foto:
          'https://homnet.oab.org.br/eventoportal/encontro-advogados-sertao/images/mestre-noza.jpg',
      latitude: -7.207083079255162,
      longitude: -39.31769336331862,
      descricao:
          'Pequenas salas ao redor de um pátio concentram o que há de mais tradicional na cultura artesanal cearense e nordestina. Nomeado em homenagem ao falecido xilogravurista Mestre Noza, o Centro de Cultura Popular tem como objetivo concentrar o artesanato da região para impulsionar sua divulgação e venda. Funcionando desde 1983, o Centro é uma cooperativa com mais de 100 artesãos cadastrados, com trabalhos variados em madeira, barro, ferro, fibras naturais e material reciclado.',
    ),
    Localizacoes(
      nome: 'Teleférico do Horto - Estação Beata Maria de Araújo',
      endereco:
          'Horto Estação Beata (Colina do Horto) e no Salgadinho Estação Monsenhor (Av. do Agricultor), Juazeiro do Norte - CE',
      foto:
          'https://www.miseria.com.br/wp-content/uploads/2024/06/teleferico-do-horto-complexo-ambiental-caminhos-do-horto-jpeg.webp',
      latitude: -7.178546981885765,
      longitude: -39.33028120099665,
      descricao:
          'É um sistema de teleférico instalado na cidade, ligando as estações Romeiros e Horto.',
    ),
    Localizacoes(
      nome: 'Estações da Via Sacra na Rua do Horto',
      endereco: 'Antiga Rua de Pedra do Horto, Juazeiro do Norte - CE',
      foto: 'https://vault.pulsarimagens.com.br/file/preview/04MAS269.jpg',
      latitude: -7.1798,
      longitude: -39.3300,
      descricao:
          'Os devotos cantam benditos, meditam e fazem paradas nas estações da Via Sacra para rezar. São aproximadamente 2,5 km de distância da 1ª estação até a última, subindo a Rua do Horto.',
    ),
    Localizacoes(
      nome: 'Estátua do Padre Cícero na Colina do Horto',
      endereco: 'Colina do Horto S/N, Juazeiro do Norte - CE, 63012-010',
      foto:
          'https://s2-g1.glbimg.com/JsLq8C4FTm0aliODOg8QMKDYSuE=/0x0:1198x898/984x0/smart/filters:strip_icc()/i.s3.glbimg.com/v1/AUTH_59edd422c0c84a879bd37670ae4f538a/internal_photos/bs/2019/n/K/iiEAshQ8aethCsx2Azdw/padre-cicero-gustavo-pellizon-svm.jpeg',
      latitude: -7.179487793228639,
      longitude: -39.330010761053046,
      descricao:
          'A Estátua de Padre Cícero na Colina do Horto é um monumento construído em homenagem ao Padre Cícero e mede 27 metros de altura.',
    ),
  ];

  List<Localizacoes> get localizacoes => _localizacoes;
}
