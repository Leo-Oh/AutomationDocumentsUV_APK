class Facultad {
  String id;
  String id_regiones;
  String nombre;
  String direccion;
  String telefono;

  Facultad({
    required this.id,
    required this.id_regiones,
    required this.nombre,
    required this.direccion,
    required this.telefono
  });

  factory Facultad.fromJson(Map json){
    return Facultad(
        id: json["id"],
        id_regiones: json["id_regiones"],
        nombre: json["nombre"],
        direccion: json["direccion"],
        telefono: json["telefono"]
    );
  }

}