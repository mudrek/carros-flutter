import 'package:carros/pages/carro/carro.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapaPage extends StatelessWidget {
  final Carro carro;

  MapaPage(this.carro);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          carro.nome,
        ),
      ),
      body: _body(),
    );
  }

  _body() {
    return Container(
      child: GoogleMap(
        zoomGesturesEnabled: true,
        markers: Set.of(_getMarkers()),
        initialCameraPosition: CameraPosition(
          target: _latLng(),
          zoom: 17,
        ),
      ),
    );
  }

  _latLng() {
    return carro.latLng();
  }

  Iterable<Marker> _getMarkers() {
    return [
      Marker(
          markerId: MarkerId("1"),
          position: carro.latLng(),
          infoWindow: InfoWindow(
              onTap: () {
                print("Clicou na janela");
              },
              title: carro.nome,
              snippet: "Fábrica da(o) ${carro.nome}"),
          onTap: () {
            print("Clicou no marcador");
          }),
    ];
  }
}
