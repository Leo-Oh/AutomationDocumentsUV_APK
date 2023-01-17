class TramitesDisponibles {
  int? id;
  String? nombre;
  String? descripcion;

  TramitesDisponibles({this.id, this.nombre, this.descripcion});

  TramitesDisponibles.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nombre = json['nombre'];
    descripcion = json['descripcion'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nombre'] = this.nombre;
    data['descripcion'] = this.descripcion;
    return data;
  }
}



class TramiteDisponibleInfo{
  final String id;
  final String nombre;
  final String descripcion;


  TramiteDisponibleInfo(
      this.id,
      this.nombre,
      this.descripcion,
      );
}
