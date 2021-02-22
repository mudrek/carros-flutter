import 'package:cached_network_image/cached_network_image.dart';
import 'package:carros/pages/carro/carro_api.dart';
import 'package:carros/pages/carro/carro_form_page.dart';
import 'package:carros/pages/carro/loripsum_bloc.dart';
import 'package:carros/pages/favorito/favorito.dart';
import 'package:carros/pages/favorito/favorito_bloc.dart';
import 'package:carros/pages/favorito/favorito_service.dart';
import 'package:carros/utils/alert.dart';
import 'package:carros/utils/nav.dart';
import 'package:carros/widgets/text.dart';
import 'package:flutter/material.dart';

import '../api_response.dart';
import 'carro.dart';

class CarroPage extends StatefulWidget {
  Carro carro;

  CarroPage(this.carro);

  @override
  _CarroPageState createState() => _CarroPageState();
}

class _CarroPageState extends State<CarroPage> {
  final _bloc = LoripsumBloc();

  Color color = Colors.black;

  @override
  void initState() {
    super.initState();

    FavoritoService.isFavorito(widget.carro).then((favoritado) {
      setState(() {
        color = favoritado ? Colors.red : Colors.black;
      });
    });

    _bloc.fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.carro.nome),
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
          CachedNetworkImage(
            imageUrl: widget.carro.urlFoto ?? "https://cdn.iconscout.com/icon/premium/png-512-thumb/missing-file-1178170.png",
          ),
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
            Container(
              width: 200,
              child: text(
                widget.carro.nome,
                fontSize: 24,
                bold: true,
              ),
            ),
            text(
              widget.carro.tipo,
              fontSize: 16,
            ),
          ],
        ),
        Row(
          children: [
            IconButton(
              iconSize: 36,
              icon: Icon(Icons.favorite),
              color: color,
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
        push(
            context,
            CarroFormPage(
              carro: widget.carro,
            ));
        break;
      case "Deletar":
        _onClickDeletar();
        break;
      case "Share":
        print("Share!!!!");
        break;
    }
  }

  void _onClickFavorito() async {
    bool favoritado = await FavoritoService.favoritar(context, widget.carro);
    setState(() {
      color = favoritado ? Colors.red : Colors.black;
    });
  }

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
          StreamBuilder<String>(
              stream: _bloc.stream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return text(
                    "Não foi possível buscar o texto.",
                    fontSize: 16,
                  );
                }
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                return text(snapshot.data, fontSize: 16, bold: false);
              }),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }

  void _onClickDeletar() async {

    print("Deletar o carro ${widget.carro}");

    ApiResponse<bool> response = await CarroApi.delete(widget.carro);

    if (response.ok) {
      alert(context, "Carro deletado com sucesso!", callback: _onClickOkAlert);
    } else {
      alert(context, response.msg, callback: _onClickOkAlert);
    }
    // await Future.delayed(Duration(seconds: 3));
  }

  _onClickOkAlert() {
    pop(context);
  }
}
