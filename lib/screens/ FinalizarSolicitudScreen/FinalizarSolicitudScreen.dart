import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:brain_school/constants.dart';
import 'package:brain_school/models/Secretaria.dart';
import 'package:brain_school/models/TramitesDisponibles.dart';
import 'package:flutter/material.dart';
import 'package:brain_school/screens/updocument_screen/updocument_screen.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:sizer/sizer.dart';

import '../../Services/ServiceAPI.dart';
import '../../models/Estudiante.dart';
import '../formalities_screen/data/formalities_data.dart';
import '../formalities_screen/widgets/formalities_widgets.dart';

import 'package:http/http.dart' as http;

import '../home_screen/home_screen.dart';

class FinalizarSolicitudScreen extends StatefulWidget {
  FinalizarSolicitudScreen({Key? key}) : super(key: key);
  static String routeName = 'FinalizarSolicitudScreen';

  _FinalizarSolicitudScreenState createState() =>
      _FinalizarSolicitudScreenState();
}

class _FinalizarSolicitudScreenState extends State<FinalizarSolicitudScreen> {
  EstudianteInfo? estudiante;
  TramiteDisponibleInfo? tramiteDisponible;
  List<SecretariaInfo>? secretariaList;

  var id_secretaria_to_find;
  var id_estudiante;
  var id_trammite;

  @override
  void initState() {
    super.initState();

    () async {
      await Future.delayed(Duration.zero);
      final List<String?> list_index= ModalRoute.of(context)!.settings.arguments as List<String?>;
      id_estudiante = list_index[0];
      id_trammite = list_index[1];

      getEstudianteInfo(id_estudiante,id_trammite);
      getTramiteDisponibleInfo(id_trammite);
    }();

  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Fianalizar tramite'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: kTopBorderRadius,
                color: kOtherColor,
              ),
              child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.all(kDefaultPadding),
                  itemCount: forma.length,
                  itemBuilder: (context, int index) {
                    return Container(
                      margin: EdgeInsets.only(bottom: kDefaultPadding),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(kDefaultPadding),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(kDefaultPadding),
                              ),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: kTextLightColor,
                                  blurRadius: 2.0,
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                if (tramiteDisponible != null)
                                  getWidgetsTramiteWithData(),
                                if (estudiante != null)
                                  getWidgetsEstudianteWithData(),

                                if (secretariaList != null)
                                getWidgetsSecretariasWithData(),


                                if(id_secretaria_to_find != null )
                                getWidgetsSecretariasWithDataInfo(id_secretaria_to_find),




                              ],
                            ),
                          ),
                          FeeButton(
                              title: forma[index].btnStatus,
                              iconData: forma[index].btnStatus == 'Paid'
                                  ? Icons.download_outlined
                                  : Icons.arrow_forward_outlined,
                              onPress: () {
                                postData_tramite();
                                //Navigator.pushNamed(context, HomeScreen.routeName);


                              })
                        ],
                      ),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }

  Widget getWidgetsTramiteWithData() {
    return FeeDetailRow(
      title: 'Tipo de Tramite',
      statusValue: tramiteDisponible!.nombre.toString(),
    );
  }

  Widget getWidgetsEstudianteWithData() {
    return Column(

      children: [

      SizedBox(
      height: kDefaultPadding,
      child: Divider(
        thickness: 1.0,
      ),
    ),
        sizedBox,
        SizedBox(
          height: kDefaultPadding,
        ),

        Text(
          "Datos del solicitante",
          style: Theme.of(context).textTheme.subtitle2!.copyWith(
            color: kTextBlackColor,
            fontWeight: FontWeight.w900,
          ),
        ),

        sizedBox,
        SizedBox(
          height: kDefaultPadding,
        ),

    SizedBox(
          height: kDefaultPadding,
          child: Divider(
            thickness: 1.0,
          ),
        ),
        FeeDetailRow(
          title: 'Matricula',
          statusValue: estudiante!.matricula.toString(),
        ),
        sizedBox,
        FeeDetailRow(
          title: 'Nombre',
          statusValue: estudiante!.nombre_completo.toString(),
        ),
        sizedBox,
        FeeDetailRow(
          title: 'Semestre',
          statusValue: estudiante!.semestre.toString(),
        ),
        sizedBox,
        FeeDetailRow(
          title: 'Correo',
          statusValue: estudiante!.correo.toString(),
        ),
        sizedBox,
        SizedBox(
          height: kDefaultPadding,
        ),
      ],
    );
  }


  Widget getWidgetsSecretariasWithData() {

    return Column(
      children: [
        SizedBox(
          height: kDefaultPadding,
          child: Divider(
            thickness: 1.0,
          ),
        ),
        sizedBox,
        SizedBox(
          height: kDefaultPadding,
        ),
        Text(
          "Seleccione la secretaria de su turno",
          style: Theme.of(context).textTheme.subtitle2!.copyWith(
            color: kTextBlackColor,
            fontWeight: FontWeight.w900,
          ),
        ),

        sizedBox,
        SizedBox(
          height: kDefaultPadding,
        ),


        DropdownButtonFormField(
            items: secretariaList?.map((data) {
              return DropdownMenuItem(
                  child:   FeeDetailRow(
                    title: "${data.nombre.toString()} ${data.apellidoPaterno.toString()}",
                    statusValue: "(${data.turno.toString()})",
                  ),
                  value: data.id,
              );
            }
            ).toList(),
            onChanged:(value){

              id_secretaria_to_find = value;

              setState((){});
              }
            ),

        sizedBox,
        SizedBox(
          height: kDefaultPadding,
        ),
      ],
    );
  }





  Widget getWidgetsSecretariasWithDataInfo(index) {

    var index_secretaria ;
    for(int i = 0 ; i < secretariaList!.length ; i++) {
      if(secretariaList![i].id == index ){
        index_secretaria = i;
        break;
      }
    }

    return Column(
      children: [

        FeeDetailRow(
          title: 'Nombre',
          statusValue: secretariaList![index_secretaria].nombre.toString(),
        ),
        sizedBox,

        FeeDetailRow(
          title: 'Apelliido Paterno',
          statusValue: secretariaList![index_secretaria].apellidoPaterno.toString(),
        ),
        sizedBox,
        FeeDetailRow(
          title: 'Apellido Materno',
          statusValue: secretariaList![index_secretaria].apellidoMaterno.toString(),
        ),
        sizedBox,
        FeeDetailRow(
          title: 'Turno',
          statusValue: secretariaList![index_secretaria].turno.toString(),
        ),
        sizedBox,
        FeeDetailRow(
          title: 'Correo',
          statusValue:  secretariaList![index_secretaria].correo.toString(),
        ),
        sizedBox,
        SizedBox(
          height: kDefaultPadding,
        ),



        sizedBox,
        SizedBox(
          height: kDefaultPadding,
        ),
      ],
    );
  }


  Future<void> getEstudianteInfo(idEstudiante,idTrammite) async {
    String url = "http://52.146.91.57:8080/api/estudiante/estudiante/${idEstudiante}";

    var result = await http.get(Uri.parse(url));

    final json_response = jsonDecode(result.body);

    estudiante = EstudianteInfo(
        json_response['id'].toString(),
        json_response['id_carreras'].toString(),
        json_response['id_facultades'].toString(),
        json_response['nombre_completo'].toString(),
        json_response['matricula'].toString(),
        json_response['correo'].toString(),
        json_response['contrasena'].toString(),
        json_response['semestre'].toString(),
        json_response['telefono'].toString(),
        json_response['foto_perfil'].toString());

    setState(() {});

    getSecretariaInfo(estudiante?.id_facultades, estudiante?.id_carreras, idTrammite );
  }

  Future<void> getTramiteDisponibleInfo(idTramite) async {

    String url = "http://52.146.91.57:8080/api/tramite/${idTramite}";
    var result = await http.get(Uri.parse(url));

    final json_response = jsonDecode(result.body);

    tramiteDisponible = TramiteDisponibleInfo(
      json_response['id'].toString(),
      json_response['nombre'].toString(),
      json_response['descripcion'].toString(),
    );
    setState(() {});
  }


  Future<void> getSecretariaInfo(id_facultad, id_carrera, id_tramite) async{
    String url = "http://52.146.91.57:8080/api/secretaria/facultad-carrera-tramite/$id_facultad/$id_carrera/$id_tramite";
    //String url = "http://52.146.91.57:8080/api/secretaria/facultad-carrera-tramite/1/1/2";
    var result = await http.get(Uri.parse(url));

    secretariaList = jsonDecode(result.body)
        .map((item) => SecretariaInfo.fromJson(item))
        .toList()
        .cast<SecretariaInfo>();
    setState(() {
    });
  }

  Future<void> postData_tramite() async {

    showDialog(
        context: context,
        builder: (context) {
          return Center(
              child: CircularProgressIndicator());
        });

    DateTime now = DateTime.now();
    final millis = now.millisecondsSinceEpoch;

    //var dt = DateTime.fromMillisecondsSinceEpoch(millis);
   // var d24 = DateFormat('dd/MM/yyyy , HH:mm').format(dt);

    print("id_secretaria_to_find: $id_secretaria_to_find\n"
        "id_trammite: ${id_trammite}\n"
        "estudiante?.id_carreras: ${estudiante?.id_carreras}\n"
        "id_estudiante: ${id_estudiante}\n"
        "TIME: $millis");

    if(id_secretaria_to_find != null ) {

      var request_post = await request_POST("solicitud-de-tramite",
          {
            "id_secretarias": id_secretaria_to_find,
            "id_tramites": id_trammite,
            "id_carreras": estudiante?.id_carreras,
            "id_estudiantes": id_estudiante,
            "datos_adjuntos_estudiante": "pruea desde flutter",
            "estado": "PENDIENTE",
            "fecha_de_solicitud": "$millis"
          }
      );

      if (request_post.statusCode == 201) {
        Navigator.pop(this.context);



        Alert(
          context: context,
          type: AlertType.success,
          title: "¡Tramite realizado correctamente!",
          desc:
          "Por favor sea paciente, las secretarias realizaran su tramite lo antes posible.",
          buttons: [
            DialogButton(
              child: Text(
                "VOLVER AL MENÚ",
                style: TextStyle(
                    color: Colors.white, fontSize: 20),
              ),
              onPressed: () =>

              Navigator.pushNamedAndRemoveUntil(
              context,
              arguments: estudiante,
              HomeScreen.routeName,
                      (route) => false),
              color: Colors.blueAccent,
              width: 200,
            )
          ],
        ).show();

        /* Navigator.pushNamedAndRemoveUntil(
          context,
          HomeScreen.routeName,
              (route) => false);
      */
      } else {
        Navigator.pop(this.context);

        Alert(
          context: context,
          type: AlertType.error,
          title: "¡Ocurrió un error!",
          desc:
          "Ocurrió un error al realizar la solicitud, pruebe nuevamente más tarde.",
          buttons: [
            DialogButton(
              child: Text(
                "VOLVER AL MENÚ",
                style: TextStyle(
                    color: Colors.white, fontSize: 20),
              ),
              onPressed: () =>
                  Navigator.pushNamedAndRemoveUntil(
                      context,
                      HomeScreen.routeName,
                          (route) => false),
              color: Colors.blueAccent,
              width: 200,
            )
          ],
        ).show();
      }
    }else{
      Navigator.pop(this.context);
      Alert(
        context: context,
        type: AlertType.warning,
        title: "¡Alto!",
        desc:
        "Debe seleccionar una secretaria antes de finalizar",
        buttons: [
          DialogButton(
            child: Text(
        "CONFFIRMAR",
              style: TextStyle(
                  color: Colors.white, fontSize: 20),
            ),
            onPressed: () =>
                Navigator.pop(this.context),
            color: Colors.blueAccent,
            width: 160,
          )
        ],
      ).show();

    }

  }


}
