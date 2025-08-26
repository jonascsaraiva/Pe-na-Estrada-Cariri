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
      nome: 'Aeroporto - Orlando Bezerra de Menezes',
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
      nome: 'Alameda – Centro de Gastronomia Rita Araújo da Silva',
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
          'https://nocariritem.com.br/wp-content/uploads/2024/03/IMG_9563-scaled.jpeg',
      latitude: -7.178546981885765,
      longitude: -39.33028120099665,
      descricao:
          'É um sistema de teleférico instalado na cidade, ligando as estações Romeiros e Horto.',
    ),
    Localizacoes(
      nome: 'Teleférico do Horto - Estação Monsenhor Murilo de Sá Barreto',
      endereco:
          'Horto Estação Beata (Colina do Horto) e no Salgadinho Estação Monsenhor (Av. do Agricultor), Juazeiro do Norte - CE',
      foto:
          'https://www.miseria.com.br/wp-content/uploads/2024/06/teleferico-do-horto-complexo-ambiental-caminhos-do-horto-jpeg.webp',
      latitude: -7.191483191863262,
      longitude: -39.31715365189599,
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
    Localizacoes(
      nome: 'Igreja do Bom Jesus do Horto',
      endereco: 'Colina do Horto, Horto 63012-010',
      foto:
          'https://s2-g1.glbimg.com/rAkQ-kg1Z9SpW6zfPRqnSnJlc-A=/0x0:2048x1536/984x0/smart/filters:strip_icc()/i.s3.glbimg.com/v1/AUTH_59edd422c0c84a879bd37670ae4f538a/internal_photos/bs/2024/o/h/DtBKhYQMWw9jDN0Hz1Cg/bom-jesus-do-horto.jpeg',
      latitude: -7.176623304379405,
      longitude: -39.333483071164515,
      descricao:
          'Uma belíssima e moderna catedral, em formato espiral muito alta e ventilada, já é mesmo antes de sua conclusão, um ponto importante a ser conhecido na região do Cariri.',
    ),
    Localizacoes(
      nome: 'Igreja Menino Jesus de Praga',
      endereco: 'Av. Pres. Castelo Branco, s/n - Novo Juazeiro, 63030-200',
      foto:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSA7FiGLRQQoM8tc3w8q7yh8LpJUDMrM9ntRg&s',
      latitude: -7.2294291114859375,
      longitude: -39.29387777140714,
      descricao:
          'É muito recomendada para celebrações de casamento. Tem nos seus arredores uma praça agradável com boas opções de lanches.',
    ),
    Localizacoes(
      nome: 'La Plaza Shopping',
      endereco: 'Rua José de Matos França, 690 - Lagoa Seca',
      foto:
          'https://laplazashopping.com.br/wp-content/uploads/2024/01/site-scaled.jpg',
      latitude: -7.244025283245983,
      longitude: -39.32266308814686,
      descricao:
          'Encontre tudo o que você precisa no Shopping La Plaza. Com lojas exclusivas e uma infraestrutura incomparável.',
    ),
    Localizacoes(
      nome: 'Lira Nordestina',
      endereco: 'Rua Interventor Francisco Erivano Cruz - Centro, 63011-085',
      foto:
          'https://artesol.org.br/wp-content/uploads/2024/08/LIRA-NE-KITY-RAMOS050-scaled.jpg',
      latitude: -7.193285238670501,
      longitude: -39.31597917655943,
      descricao:
          'A Lira Nordestina é um equipamento cultural vinculado à Pró-reitoria de Extensão da URCA e é referência em xilogravura.',
    ),
    Localizacoes(
      nome: 'Luzeiro da Fé',
      endereco: 'Rua Padre José Alves - Salesianos, 63050-222',
      foto:
          'https://artederua.com.br/sites/contents/pics/arte_de_rua-luazeiro_da_fe.jpg',
      latitude: -7.190949954695875,
      longitude: -39.3156698648599,
      descricao:
          'Inaugurado em 1º de novembro de 2005, trata-se da maior torre do Nordeste brasileiro. É uma homenagem aos milhares de romeiros que visitam Juazeiro do Norte.',
    ),
    Localizacoes(
      nome: 'Memorial Padre Cícero',
      endereco:
          'Praça do Cinquentenário, s/n - Centro, Juazeiro do Norte - CE, 63010-242',
      foto: 'https://juazeirodonorte.ce.gov.br/fotos/26555/Img0_600x400.jpg',
      latitude: -7.200982231770824,
      longitude: -39.320609476559355,
      descricao:
          'A sede do Memorial Padre Cícero está temporariamente fechada para obras, por este motivo foi transferida para o prédio Palácio José Geraldo da Cruz, antigo prédio da prefeitura.O Museu conserva um acervo variado, composto por mais de 2.000 peças, entre mobílias, indumentárias, louças, fotografias, quadros e outros itens que pertenceram ao Padre Cícero ou que se relacionam com a sua vida. Parte fica em exposição e outra na biblioteca. É uma coleção cujo núcleo inicial partiu de um acervo dos pesquisadores Daniel Walker e Renato Casimiro, mas que, depois, foi expandida com várias doações da sociedade juazeirense, a partir da atuação de uma comissão composta por Abraão Batista, Assunção Gonçalves, Daniel Walker, Nair Silva, Pe. José Alves, Pe. Murilo de Sá Barreto e Renato Casimiro A Biblioteca, por sua diversidade de suportes, pode ser considerada um Centro de Documentação. Possui livros, revistas, jornais, fotografias, documentos impressos e manuscritos, que também tratam da trajetória do Padre Cícero, bem como das personalidades históricas relacionadas à sua vivência, do município de Juazeiro do Norte e da região do Cariri. Tem por objetivo atender prioritariamente a comunidade acadêmica (estudiosos e pesquisadores), bem como os demais interessados nesses temas. Em 2017, foram contabilizados mais de 12 mil itens em seu recinto',
    ),
    Localizacoes(
      nome: 'Museu Casa do Doce Madeilton',
      endereco: 'Rua Santa Luzia, N°545 - Centro',
      foto: 'https://live.staticflickr.com/65535/52969473676_13c9e3cf1c.jpg',
      latitude: -7.204295098962611,
      longitude: -39.31643833622336,
      descricao:
          'Patrimônio Cultural Imaterial da cidade, a Casa do Doce João Martins é considerada o point preferido para quem não abre mão daquele bom doce caseiro.',
    ),
    Localizacoes(
      nome: 'Museu Casa do Mestre Nena',
      endereco:
          'Rua Senhor do Bonfim, 524 - João Cabral, em frente à Praça Adones Callou (conhecida como Praça do CC)',
      foto:
          'https://mapacultural.secult.ce.gov.br/files/agent/31035/museu_casa_do_mestre_nena_em_juazeiro_do_norte_cear%C3%A1.jpg',
      latitude: -7.23160989251771,
      longitude: -39.319484405394604,
      descricao:
          'No dia 07 de agosto de 2019 foi contemplado com o projeto Museu Orgânico Casa do Mestre Nena, proporcionado pelas entidades Casa Grande e SESC-CE.',
    ),
    Localizacoes(
      nome: 'Casarão do Padre Cícero',
      endereco: 'Colina Do Horto S/N, 63012-010',
      foto:
          'https://tvbrasil.ebc.com.br/sites/default/files/atoms/image/fachada_museu_vivo_do_padre_cicero_grande.jpg',
      latitude: -7.1794944302845405,
      longitude: -39.330515674711094,
      descricao:
          'Inaugurado em 1º de novembro de 1999, no velho Casarão do Horto, retrata e preserva, em personagens em tamanho real, a vida e obra religiosa do padre Cícero Romão Batista.',
    ),
    Localizacoes(
      nome: 'Paróquia Nossa Senhora de Lourdes - Igreja de São Miguel',
      endereco:
          'R. São Francisco, 1114 - São Miguel, Juazeiro do Norte - CE, 63010-475',
      foto:
          'https://cdn.diocesedecrato.org/wp-content/uploads/2014/05/10379129_467779489991830_316529081_n.jpg',
      latitude: -7.20474663388835,
      longitude: -39.31000807655927,
      descricao:
          'Foi instituída no dia 1º de Maio de 1958, pelo então bispo diocesano Dom Francisco de Assis Pires. Sendo a primeira paróquia de Juazeiro, depois da de Nossa Senhora das Dores.',
    ),
    Localizacoes(
      nome: 'Parque de Eventos Padre Cícero',
      endereco: 'Rua Vicente Teixeira de Macedo, s/n - Planalto, 63047-245',
      foto:
          'https://www.miseria.com.br/wp-content/uploads/2022/06/parque-padre-cicero-1-1-1.jpg',
      latitude: -7.244051256063577,
      longitude: -39.30054154772331,
      descricao:
          'Centro de exposições da cidade. Local de festividades. Localizado na Rua Vicente Teixeira de Macedo, 05 - Planalto.',
    ),
    Localizacoes(
      nome: 'Parque Natural Municipal das Timbaúbas',
      endereco: 'Avenida Ailton Gomes, nº s/n - Centro, CEP: 63.020-000',
      foto: 'https://www.miseria.com.br/wp-content/uploads/2021/02/013-21.jpg',
      latitude: -7.236702438641257,
      longitude: -39.3125544765589,
      descricao:
          'No interior do parque estão localizadas 11 fontes naturais, que são responsáveis por 70% do abastecimento da cidade com água potável.',
    ),
    Localizacoes(
      nome: 'Pedra do Joelho',
      endereco:
          'R. José Arnaldo Bezerra Filho - Horto, Juazeiro do Norte - CE, 63012-110',
      foto:
          'https://jornaldocariri.com.br/wp-content/uploads/2021/05/1622212620-1.jpeg',
      latitude: -7.184770111838128,
      longitude: -39.33283466306593,
      descricao:
          'A Pedra do Joelho é um bloco de granito com sulcos em sua formação. Na crença popular acredita-se que as marcas na pedra representam impressões de um joelho, dos pés de uma criança e da região lombar de uma coluna, simbolizando respectivamente os joelhos de Nossa Senhora, os pés do menino Jesus e a coluna de São José.',
    ),
    Localizacoes(
      nome: 'Praça Padre Cícero',
      endereco: 'R. São Pedro, s/n - Centro, Juazeiro do Norte - CE, 63010-010',
      foto: 'https://tyba.com.br/fotos/foto/cd221_053.jpg',
      latitude: -7.200915344966156,
      longitude: -39.31767940003532,
      descricao:
          'A Praça Almirante Alexandrino de Alencar foi inaugurada em 1925, pelo Padre Cícero Romão Batista, então prefeito da cidade de Juazeiro do Norte.',
    ),
    Localizacoes(
      nome: 'Centro Cultural Daniel Walker',
      endereco: 'R. São Bernardo, 724 - Franciscanos',
      foto:
          'https://upload.wikimedia.org/wikipedia/commons/2/24/Pra%C3%A7a_Padre_C%C3%ADcero_no_centro_de_Juazeiro_do_Norte.jpg',
      latitude: -7.209428680532103,
      longitude: -39.31359443423024,
      descricao:
          'Conhecida popularmente como R.F.F.S.A (Rede Ferroviária Federal Sociedade Anônima), foi inaugurada em 7 de novembro de 1926.',
    ),
    Localizacoes(
      nome: 'Santuário de São Francisco das Chagas',
      endereco:
          'Praça Mons. Joviniano Barreto, s/n - Franciscanos, Juazeiro do Norte - CE, 63020-020',
      foto:
          'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/14/44/ea/c7/photo0jpg.jpg?w=900&h=500&s=1',
      latitude: -7.211555749805156,
      longitude: -39.31387613423009,
      descricao:
          'Sob os cuidados da Ordem dos Frades Menores Capuchinhos (OFMCap) foi edificado o Santuário dedicado a São Francisco das Chagas, inaugurado em 06 de janeiro de 1950.',
    ),
    Localizacoes(
      nome: 'Santuário do Sagrado Coração de Jesus',
      endereco:
          'R. Padre Cícero, 1387-1589 - Centro, Juazeiro do Norte - CE, 63010-020',
      foto:
          'https://cdn.diocesedecrato.org/wp-content/uploads/2014/05/WhatsApp-Image-2020-11-24-at-11.10.27.jpeg',
      latitude: -7.210422437083145,
      longitude: -39.321864647723736,
      descricao:
          'A Igreja dos Salesianos, como é mais conhecida pelos fiéis, começou a ser construída em 1949 e foi inaugurada em 7 de maio de 1978.',
    ),
    Localizacoes(
      nome: 'Teatro Municipal Marquise Branca',
      endereco:
          'Av. Padre Cícero, S/N - Salesianos, Juazeiro do Norte - CE, 63050-295',
      foto:
          'https://cariridasantigas.com.br/wp-content/uploads/2021/04/dadf1876-f5b9-44a1-afaa-48ef1e1f323d.jpeg',
      latitude: -7.2172858162462035,
      longitude: -39.32501772073638,
      descricao:
          'O Teatro Marquise Branca funciona em um dos prédios mais antigos de Juazeiro do Norte, está fechado temporariamente para obras.',
    ),
  ];

  List<Localizacoes> get localizacoes => _localizacoes;
}
