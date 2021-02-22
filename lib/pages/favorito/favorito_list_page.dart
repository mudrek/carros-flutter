import 'package:carros/pages/carro/carro.dart';
import 'package:carros/pages/carro/carro_listview.dart';
import 'package:carros/pages/favorito/favorito_model.dart';
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
    FavoritoModel favoritosBloc =
        Provider.of<FavoritoModel>(context, listen: false);
    favoritosBloc.getCarros();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    FavoritoModel model = Provider.of<FavoritoModel>(context);

    List<Carro> carros = model.carros;

    if (carros.isEmpty) {
      return Center(
        child: Text(
          "Nenhum carro nos favoritos",
          style: TextStyle(fontSize: 25),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: CarroListView(carros),
    );
  }

  Future<void> _onRefresh() {
    return Provider.of<FavoritoModel>(context, listen: false).getCarros();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
