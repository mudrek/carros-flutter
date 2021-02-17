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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    carro.nome,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    carro.tipo,
                    style: TextStyle(
                      fontSize: 16,
                    ),
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
          ),

        ],
      ),
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

  void _onClickFavorito() {
  }

  void _onClickShare() {
  }
}
