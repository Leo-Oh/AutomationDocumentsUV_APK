class SecretariaInfo {
  int? id;
  int? idFacultades;
  String? nombre;
  String? apellidoPaterno;
  String? apellidoMaterno;
  String? turno;
  String? correo;
  int? idTramites;
  int? idCarreras;

  SecretariaInfo(
      {this.id,
        this.idFacultades,
        this.nombre,
        this.apellidoPaterno,
        this.apellidoMaterno,
        this.turno,
        this.correo,
        this.idTramites,
        this.idCarreras});

  SecretariaInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idFacultades = json['id_facultades'];
    nombre = json['nombre'];
    apellidoPaterno = json['apellido_paterno'];
    apellidoMaterno = json['apellido_materno'];
    turno = json['turno'];
    correo = json['correo'];
    idTramites = json['id_tramites'];
    idCarreras = json['id_carreras'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['id_facultades'] = this.idFacultades;
    data['nombre'] = this.nombre;
    data['apellido_paterno'] = this.apellidoPaterno;
    data['apellido_materno'] = this.apellidoMaterno;
    data['turno'] = this.turno;
    data['correo'] = this.correo;
    data['id_tramites'] = this.idTramites;
    data['id_carreras'] = this.idCarreras;
    return data;
  }
}
