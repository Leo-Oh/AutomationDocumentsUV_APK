import 'package:brain_school/constants.dart';
import 'package:brain_school/screens/datesheet_screen/data/datesheet_data.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'dart:convert';

import 'package:brain_school/constants.dart';
import 'package:brain_school/models/TramitesDisponibles.dart';
import 'package:flutter/material.dart';
import 'package:brain_school/screens/updocument_screen/updocument_screen.dart';
import 'package:sizer/sizer.dart';

import '../../models/Estudiante.dart';
import '../../models/SolicitudTramite.dart';
import '../formalities_screen/data/formalities_data.dart';
import '../formalities_screen/widgets/formalities_widgets.dart';

import 'package:http/http.dart' as http;




class DateSheetScreen extends StatefulWidget {
  DateSheetScreen({Key? key}) : super(key: key);
  static String routeName = 'DateSheetScreen';

  _DateSheetScreenState createState() => _DateSheetScreenState();

  }
  class _DateSheetScreenState extends State<DateSheetScreen> {
  List<SolicitudTramitesList>? solicitudTramitesList;
  List<TramitesDisponibles>? tramitesDisponiblesList;

  @override
  void initState() {
    super.initState();

    getTramitesDisponibles();
        () async {
      await Future.delayed(Duration.zero);
      final EstudianteInfo estudiante = ModalRoute
          .of(context)!
          .settings
          .arguments as EstudianteInfo;
      getHistorial(estudiante.id);
    }();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Historial de Tramites'),
      ),
      body: Container(
        width: 100.w,
        decoration: BoxDecoration(
          color: kOtherColor,
          borderRadius: kTopBorderRadius,
        ),
        child: ListView.builder(
          itemCount: solicitudTramitesList!.length,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.only(
                  left: kDefaultPadding / 2, right: kDefaultPadding / 2),
              padding: EdgeInsets.all(kDefaultPadding / 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 3.h,
                    child: Divider(
                      thickness: 1.0,
                    ),
                  ),
                  
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //1 columna
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${index}.",
                            style:
                                Theme.of(context).textTheme.subtitle2!.copyWith(
                                      color: kTextBlackColor,
                                      fontWeight: FontWeight.w900,
                                    ),
                          ),

                        ],
                      ),

                      //2 columna
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                           //"${tramitesDisponiblesList![int.parse(solicitudTramitesList![index].idTramites.toString())].nombre }",
                            "${getTramitesDisponibleName(solicitudTramitesList![index].idTramites)}",
                            style:
                                Theme.of(context).textTheme.subtitle2!.copyWith(
                                      color: kTextBlackColor,
                                      fontWeight: FontWeight.w900,
                                    ),
                          ),
                          Text("${solicitudTramitesList![index].estado}",
                              style: Theme.of(context).textTheme.caption),
                        ],
                      ),
                      //3 columna
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '🕒  ${ solicitudTramitesList![index].fechaDeSolicitud}',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 3.h,
                    child: Divider(
                      thickness: 1.0,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> getHistorial(id_estudiante) async{
    String url = "http://52.146.91.57:8080/api/solicitud-de-tramite/estudiante/${id_estudiante}";
    var result = await http.get(Uri.parse(url));

    print(jsonDecode(result.body));
    solicitudTramitesList = jsonDecode(result.body)
        .map((item) => SolicitudTramitesList.fromJson(item))
        .toList()
        .cast<SolicitudTramitesList>();

    setState(() {
    });
  }


  Future<void> getTramitesDisponibles() async{
    String url = "http://52.146.91.57:8080/api/tramites";
    var result = await http.get(Uri.parse(url));

    tramitesDisponiblesList = jsonDecode(result.body)
        .map((item) => TramitesDisponibles.fromJson(item))
        .toList()
        .cast<TramitesDisponibles>();

    setState(() {
    });



  }

   getTramitesDisponibleName(id_tramite) {
    for (var i=0; i< tramitesDisponiblesList!.length; i++ ) {
      if(tramitesDisponiblesList![i].id == id_tramite){
       return  tramitesDisponiblesList![i].nombre.toString();
      }
    }
  }

}
