class SolicitudTramite {
  int? id;
  int? idSecretarias;
  int? idTramites;
  int? idCarreras;
  int? idEstudiantes;
  String? datosAdjuntosSecretaria;
  String? estado;
  String? fechaDeSolicitud;
  String? fechaDeAprobacion;

  SolicitudTramite(
      {this.id,
        this.idSecretarias,
        this.idTramites,
        this.idCarreras,
        this.idEstudiantes,
        this.datosAdjuntosSecretaria,
        this.estado,
        this.fechaDeSolicitud,
        this.fechaDeAprobacion});

  SolicitudTramite.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idSecretarias = json['id_secretarias'];
    idTramites = json['id_tramites'];
    idCarreras = json['id_carreras'];
    idEstudiantes = json['id_estudiantes'];
    datosAdjuntosSecretaria = json['datos_adjuntos_secretaria'];
    estado = json['estado'];
    fechaDeSolicitud = json['fecha_de_solicitud'];
    fechaDeAprobacion = json['fecha_de_aprobacion'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['id_secretarias'] = this.idSecretarias;
    data['id_tramites'] = this.idTramites;
    data['id_carreras'] = this.idCarreras;
    data['id_estudiantes'] = this.idEstudiantes;
    data['datos_adjuntos_secretaria'] = this.datosAdjuntosSecretaria;
    data['estado'] = this.estado;
    data['fecha_de_solicitud'] = this.fechaDeSolicitud;
    data['fecha_de_aprobacion'] = this.fechaDeAprobacion;
    return data;
  }
}


class SolicitudTramitesList {
  int? id;
  int? idSecretarias;
  int? idTramites;
  int? idCarreras;
  int? idEstudiantes;
  String? datosAdjuntosEstudiante;
  String? datosAdjuntosSecretaria;
  String? mensajeSecretaria;
  String? fechaDeSolicitud;
  String? estado;
  String? fechaDeAprobacion;

  SolicitudTramitesList(
      {this.id,
        this.idSecretarias,
        this.idTramites,
        this.idCarreras,
        this.idEstudiantes,
        this.datosAdjuntosEstudiante,
        this.datosAdjuntosSecretaria,
        this.mensajeSecretaria,
        this.fechaDeSolicitud,
        this.estado,
        this.fechaDeAprobacion});

  SolicitudTramitesList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idSecretarias = json['id_secretarias'];
    idTramites = json['id_tramites'];
    idCarreras = json['id_carreras'];
    idEstudiantes = json['id_estudiantes'];
    datosAdjuntosEstudiante = json['datos_adjuntos_estudiante'];
    datosAdjuntosSecretaria = json['datos_adjuntos_secretaria'];
    mensajeSecretaria = json['mensaje_secretaria'];
    fechaDeSolicitud = json['fecha_de_solicitud'];
    estado = json['estado'];
    fechaDeAprobacion = json['fecha_de_aprobacion'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['id_secretarias'] = this.idSecretarias;
    data['id_tramites'] = this.idTramites;
    data['id_carreras'] = this.idCarreras;
    data['id_estudiantes'] = this.idEstudiantes;
    data['datos_adjuntos_estudiante'] = this.datosAdjuntosEstudiante;
    data['datos_adjuntos_secretaria'] = this.datosAdjuntosSecretaria;
    data['mensaje_secretaria'] = this.mensajeSecretaria;
    data['fecha_de_solicitud'] = this.fechaDeSolicitud;
    data['estado'] = this.estado;
    data['fecha_de_aprobacion'] = this.fechaDeAprobacion;
    return data;
  }
}
