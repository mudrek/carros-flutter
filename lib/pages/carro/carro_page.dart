import 'package:carros/widgets/text.dart';
import 'package:flutter/material.dart';

import 'carro.dart';

class CarroPage extends StatelessWidget {
  Carro carro;

  CarroPage(this.carro);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(carro.nome),
        actions: [
          IconButton(
            icon: Icon(Icons.place),
            onPressed: _onClickMapa,
          ),
          IconButton(
            icon: Icon(Icons.videocam),
            onPressed: _onClickMapa,
          ),
          PopupMenuButton(
            onSelected: (String value) => _onClickPopupMenu(value),
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  child: Text("Editar"),
                  value: "Editar",
                ),
                PopupMenuItem(
                  child: Text("Deletar"),
                  value: "Deletar",
                ),
                PopupMenuItem(
                  child: Text("Share"),
                  value: "Share",
                ),
              ];
            },
          )
        ],
      ),
      body: _body(),
    );
  }

  _body() {
    return Container(
      padding: EdgeInsets.all(16),
      child: ListView(
        children: [
          Image.network(carro.urlFoto),
          _bloco1(),
          Divider(
            color: Colors.grey,
          ),
          _bloco2(),
        ],
      ),
    );
  }

  Row _bloco1() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            text(
              carro.nome,
              fontSize: 24,
              bold: true,
            ),
            text(
              carro.tipo,
              fontSize: 16,
            ),
          ],
        ),
        Row(
          children: [
            IconButton(
              iconSize: 36,
              icon: Icon(Icons.favorite),
              onPressed: _onClickFavorito,
            ),
            IconButton(
              iconSize: 36,
              icon: Icon(Icons.share),
              onPressed: _onClickShare,
            ),
          ],
        ),
      ],
    );
  }

  void _onClickMapa() {}

  _onClickPopupMenu(String value) {
    switch (value) {
      case "Editar":
        print("Editar!!!!");
        break;
      case "Deletar":
        print("Deletar!!!!");
        break;
      case "Share":
        print("Share!!!!");
        break;
    }
  }

  void _onClickFavorito() {}

  void _onClickShare() {}

  _bloco2() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 2,
          ),
          text("Descrição", fontSize: 20, bold: true),
          SizedBox(
            height: 12,
          ),
          text(
              "Fogo é a rápida oxidação de um material combustível liberando calor, luz e produtos de reação, tais como o dióxido de carbono e a água.[1] O fogo é uma mistura de gases a altas temperaturas, formada em reação exotérmica de oxidação, que emite radiação eletromagnética nas faixas do infravermelho e visível. Desse modo, o fogo pode ser entendido como uma entidade gasosa emissora de radiação e decorrente da combustão. Se bastante quente, os gases podem se tornar ionizados para produzir plasma.[2] Dependendo das substâncias presentes e de quaisquer impurezas, a cor da chama e a intensidade do fogo podem variar. O fogo em sua forma mais comum pode resultar em incêndio, que tem o potencial de causar dano físico através da queima.",
              fontSize: 16,
              bold: false),
        ],
      ),
    );
  }
}
