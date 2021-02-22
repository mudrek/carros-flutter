import 'package:carros/pages/carro/carro.dart';
import 'package:carros/pages/carro/carro_listview.dart';
import 'package:carros/pages/favorito/favorito_bloc.dart';
import 'package:carros/widgets/text_error.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritoListPage extends StatefulWidget {
  @override
  _FavoritoListPageState createState() => _FavoritoListPageState();
}

class _FavoritoListPageState extends State<FavoritoListPage>
    with AutomaticKeepAliveClientMixin<FavoritoListPage> {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    FavoritoBloc favoritosBloc = Provider.of<FavoritoBloc>(context, listen: false);
    favoritosBloc.fetch();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return StreamBuilder(
      stream: Provider.of<FavoritoBloc>(context).stream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print("Erro ao buscar carros, >> ${snapshot.error}");
          return RefreshIndicator(
              onRefresh: _onRefresh,
              child: TextError("Não foi possível buscar os carros."));
        }

        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        List<Carro> carros = snapshot.data;

        return RefreshIndicator(
          onRefresh: _onRefresh,
          child: CarroListView(carros),
        );
      },
    );
  }

  Future<void> _onRefresh() {
    return Provider.of<FavoritoBloc>(context).fetch();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
