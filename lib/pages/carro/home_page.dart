import 'package:carros/drawer_list.dart';
import 'package:carros/pages/carro/carro_api.dart';
import 'package:carros/pages/carro/carro_form_page.dart';
import 'package:carros/pages/carro/carro_list_page.dart';
import 'package:carros/pages/favorito/favorito_list_page.dart';
import 'package:carros/utils/nav.dart';
import 'package:carros/utils/prefs.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin<HomePage> {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _initTabs();
  }

  _initTabs() async {
    int tabIdx = await Prefs.getInt("tabIdx");

    _tabController = TabController(length: 4, vsync: this);

    setState(() {
      _tabController.index = tabIdx;
    });

    _tabController.addListener(() {
      Prefs.setInt("tabIdx", _tabController.index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Carros"),
        bottom: _tabController == null
            ? null
            : TabBar(
                controller: _tabController,
                tabs: [
                  Tab(
                    text: "Clássicos",
                    icon: Icon(Icons.directions_car_outlined),
                  ),
                  Tab(
                    text: "Esportivos",
                    icon: Icon(Icons.directions_car_outlined),
                  ),
                  Tab(
                    text: "Luxo",
                    icon: Icon(Icons.directions_car_outlined),
                  ),
                  Tab(
                    text: "Favoritos",
                    icon: Icon(Icons.favorite),
                  ),
                ],
              ),
      ),
      drawer: DrawerList(),
      body: _tabController == null
          ? null
          : TabBarView(
              controller: _tabController,
              children: [
                CarroListPage(TipoCarro.classicos),
                CarroListPage(TipoCarro.esportivos),
                CarroListPage(TipoCarro.luxo),
                FavoritoListPage(),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onClickAdicionarCarro,
        child: Icon(Icons.add),
      ),
    );
  }

  void _onClickAdicionarCarro() {
    push(context, CarroFormPage());
    //alert(context, "Adicionando carro");
  }
}
