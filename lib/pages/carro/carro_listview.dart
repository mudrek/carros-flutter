import 'package:cached_network_image/cached_network_image.dart';
import 'package:carros/pages/carro/carro.dart';
import 'package:carros/pages/carro/carro_page.dart';
import 'package:carros/utils/nav.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

class CarroListView extends StatelessWidget {
  List<Carro> carros;

  CarroListView(this.carros);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: ListView.builder(
        itemCount: carros != null ? carros.length : 0,
        itemBuilder: (context, index) {
          Carro c = carros[index];

          return InkWell(
            onTap: () {
              _onClickDetalhes(c, context);
            },
            onLongPress: () {
              _onLongClick(c, context);
            },
            child: Card(
              child: Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: CachedNetworkImage(
                        imageUrl: c.urlFoto ??
                            "https://cdn.iconscout.com/icon/premium/png-512-thumb/missing-file-1178170.png",
                        width: 250,
                      ),
                    ),
                    Text(
                      c.nome ?? "??????????",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 22),
                    ),
                    Text(
                      "Descrição",
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 16),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        TextButton(
                          child: const Text('DETALHES'),
                          onPressed: () => _onClickDetalhes(c, context),
                        ),
                        const SizedBox(width: 8),
                        TextButton(
                          child: const Text('SHARE'),
                          onPressed: () => _onClickShare(c, context),
                        ),
                        const SizedBox(width: 8),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  _onClickDetalhes(Carro c, context) {
    push(context, CarroPage(c));
  }

  _onLongClick(Carro c, context) {
    showBottomSheet(
        context: context,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Text(
                    c.nome,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                ListTile(
                  title: Text("Detalhes"),
                  leading: Icon(Icons.details),
                  onTap: () {
                    pop(context);
                    _onClickDetalhes(c, context);
                  },
                ),
                ListTile(
                  title: Text("Share"),
                  leading: Icon(Icons.share),
                  onTap: () {
                    pop(context);
                    _onClickShare(c, context);
                  },
                ),
              ],
            ),
          );
        });
  }

  _onClickShare(Carro c, BuildContext context) {
    Share.share(c.urlFoto);
  }
}
