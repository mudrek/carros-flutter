import 'package:carros/pages/carro/carro.dart';
import 'package:carros/pages/carro/carro_bloc.dart';
import 'package:carros/pages/carro/carro_listview.dart';
import 'package:carros/pages/carro/carro_page.dart';
import 'package:carros/pages/favorito/favorito_bloc.dart';
import 'package:carros/utils/nav.dart';
import 'package:carros/widgets/text_error.dart';
import 'package:flutter/material.dart';

class FavoritoListPage extends StatefulWidget {
  @override
  _FavoritoListPageState createState() => _FavoritoListPageState();
}

class _FavoritoListPageState extends State<FavoritoListPage>
    with AutomaticKeepAliveClientMixin<FavoritoListPage> {
  @override
  bool get wantKeepAlive => true;

  final _bloc = FavoritoBloc();

  @override
  void initState() {
    super.initState();
    _bloc.fetch();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return StreamBuilder(
      stream: _bloc.stream,
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
    return _bloc.fetch();
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }
}
