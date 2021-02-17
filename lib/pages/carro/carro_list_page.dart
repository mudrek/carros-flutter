import 'package:carros/pages/carro/carro.dart';
import 'package:carros/pages/carro/carro_bloc.dart';
import 'package:carros/pages/carro/carro_listview.dart';
import 'package:carros/pages/carro/carro_page.dart';
import 'package:carros/utils/nav.dart';
import 'package:carros/widgets/text_error.dart';
import 'package:flutter/material.dart';

class CarroListPage extends StatefulWidget {
  String tipoCarro;

  CarroListPage(this.tipoCarro);

  @override
  _CarroListPageState createState() => _CarroListPageState();
}

class _CarroListPageState extends State<CarroListPage>
    with AutomaticKeepAliveClientMixin<CarroListPage> {
  @override
  bool get wantKeepAlive => true;

  final _bloc = CarroBloc();

  @override
  void initState() {
    super.initState();
    _bloc.fetch(widget.tipoCarro);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return StreamBuilder(
      stream: _bloc.stream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print("Erro ao buscar carros, >> ${snapshot.error}");
          return TextError("Não foi possível buscar os carros.");
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
    return _bloc.fetch(widget.tipoCarro);
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }
}
