
class Ingresar {
  String matricula;
  String contrasena;

  Ingresar(
      {
        required this.matricula, required this.contrasena,
      });

  factory  Ingresar.fromJson(Map json) {
    return  Ingresar(
        matricula: json["matricula"],
        contrasena: json["contrasena"]
    );
  }
}


class Estudiante{
  final String token;
  final String id;
  final String id_carreras;
  final String id_facultades;
  final String nombre_completo;
  final String matricula;
  final String correo;
  final String contrasena;
  final String semestre;
  final String telefono;
  final String foto_perfil;


  Estudiante(
      this.token,
      this.id,
      this.id_carreras,
      this.id_facultades,
      this.nombre_completo,
      this.matricula,
      this.correo,
      this.contrasena,
      this.semestre,
      this.telefono,
      this.foto_perfil
      );
}


class EstudianteInfo{
  final String id;
  final String id_carreras;
  final String id_facultades;
  final String nombre_completo;
  final String matricula;
  final String correo;
  final String contrasena;
  final String semestre;
  final String telefono;
  final String foto_perfil;


  EstudianteInfo(
      this.id,
      this.id_carreras,
      this.id_facultades,
      this.nombre_completo,
      this.matricula,
      this.correo,
      this.contrasena,
      this.semestre,
      this.telefono,
      this.foto_perfil
      );
}
