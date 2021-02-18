import 'package:carros/utils/sql/entity.dart';

class Carro extends Entity {
  int id;
  String tipo;
  String nome;
  String desc;
  String urlFoto;
  String urlVideo;
  String latitude;
  String longitude;

  Carro(
      {this.id,
        this.tipo,
        this.nome,
        this.desc,
        this.urlFoto,
        this.urlVideo,
        this.latitude,
        this.longitude});

  Carro.fromMap(Map<String, dynamic> json) {
    id = json['id'];
    tipo = json['tipo'];
    nome = json['nome'];
    desc = json['desc'];
    urlFoto = json['urlFoto'];
    urlVideo = json['urlVideo'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tipo'] = this.tipo;
    data['nome'] = this.nome;
    data['desc'] = this.desc;
    data['urlFoto'] = this.urlFoto;
    data['urlVideo'] = this.urlVideo;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}