## 🌍 Pé na Estrada Cariri  

Aplicativo em desenvolvimento com **Flutter** para divulgação e organização de **pontos turísticos da região do Cariri (Juazeiro do Norte, Crato, Barbalha e Missão Velha - CE)**.  
O projeto é parte de uma disciplina de **Extensão em Sistemas de Informação** e tem como foco unir tecnologia e turismo local.  

---

## 📖 Descrição do Projeto  
O app busca facilitar o acesso a informações sobre atrativos turísticos, culturais e religiosos da região, permitindo que usuários:  
- Visualizem pontos turísticos em lista ou mapa.  
- Acessem detalhes como descrições, horários de funcionamento e dicas.  
- Montem roteiros personalizados de visita.  
- Utilizem a interface em **tema claro e escuro**, com alternância global.  

Atualmente, o projeto já conta com:  
- **Estrutura de temas separados** (`tema_claro` e `tema_escuro`) aplicados de forma global.  
- Organização inicial de pastas para expansão futura (UI, dados e lógica de negócio).  
- Base pronta para integração de **mapa interativo** e **dados locais/JSON**.  

---

## ⚡ Funcionalidades Planejadas  
- [x] Tema claro e escuro globais.  
- [x] Lista de pontos turísticos.  
- [x] Página de detalhes de cada ponto.  
- [x] Mapa interativo com rotas.  
- [ ] Roteiros personalizados e exportação.  
- [ ] Favoritar pontos para acesso rápido.  
- [ ] Roteiros sugeridos por tema/duração.  

---

## 🛠️ Tecnologias Utilizadas  
- **Linguagem:** Dart  
- **Framework:** Flutter  
- **Gerenciamento de temas:** MaterialApp com separação de temas (light/dark)  
- **Possível integração futura:** Google Maps API, armazenamento em JSON ou SQLite  

---

 ## 👥 Autoria

- 37021838 - Antônio
- 37021604 - Ítalo
- 37021560 - Janaína
- 37020495 - Jonas
- 37021831 - Karyna
- 37022022 - Ruan

---

## 🚀 Como Executar o Projeto  

Pré-requisitos:  
- [Flutter SDK](https://docs.flutter.dev/get-started/install)  
- Dart (já incluso no Flutter)  
- Emulador Android/iOS ou dispositivo físico conectado  

Passos:  
```bash
# Clonar repositório
git clone https://github.com/jonascsaraiva/P-na-Estrada-Cariri

# Entrar na pasta
cd P-na-Estrada-Cariri

# Instalar dependências
flutter pub get

# Executar em dispositivo/emulador
flutter run
---
'''
---
## 📂 Estrutura de Pastas

lib/
 ├── controllers/               Camada de controle (lógica e estados)
 │    ├── darkmode.dart         Controle do modo escuro/claro
 │    ├── geolocalizacao.dart   Lógica de geolocalização
 │    └── trajetoria.dart       Controle de trajetórias/rotas
 │
 ├── models/                   
 │    └── localizacoes.dart     Modelos de dados de localizações
 │
 ├── pages/                     Telas principais do app
 │    ├── detailpages/          Telas de detalhes
 │    │    ├── detail_list.dart
 │    │    ├── config_page.dart
 │    │    ├── fav_page.dart
 │    │    ├── list_page.dart
 │    │    └── map_page.dart
 │
 ├── repositories/             
 │    └── loc_repository.dart   Repositório de dados das localizações
 │
 ├── theme/                    
 │    ├── dark_theme.dart       Definições de tema escuro
 │    ├── light_theme.dart      Definições de tema claro
 │    └── home_page.dart        Página inicial com suporte a tema
 │
 └── main.dart  
 
 ---