import 'dart:convert';

import 'package:brain_school/constants.dart';
import 'package:brain_school/models/TramitesDisponibles.dart';
import 'package:flutter/material.dart';
import 'package:brain_school/screens/updocument_screen/updocument_screen.dart';
import 'package:sizer/sizer.dart';

import '../formalities_screen/data/formalities_data.dart';
import '../formalities_screen/widgets/formalities_widgets.dart';

import 'package:http/http.dart' as http;



  class TramitesDisponiblesScreen extends StatefulWidget {
    TramitesDisponiblesScreen({Key? key}) : super(key: key);
    static String routeName = 'TramitesDisponiblesScreen';

    _TramitesDisponiblesScreenState createState() => _TramitesDisponiblesScreenState();

  }
  class _TramitesDisponiblesScreenState extends State<TramitesDisponiblesScreen> {
    List<TramitesDisponibles>? tramitesDisponiblesList;

    @override
      void initState() {
      super.initState();
      getApiData();
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tramites Disponibles'),
      ),
      body: Column(
        children: [
          if(tramitesDisponiblesList !=null)
            getList(),

        ],
      ),
    );
  }


  Widget getList(){
    return  Expanded(
        child: ListView.builder(
        itemCount: tramitesDisponiblesList!.length,
        itemBuilder: (BuildContext context, int index){
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [


              Card(
                elevation: 5,
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.fromLTRB(5, 10, 0, 10),
                  child:
                  Column(
                    children: [
                      FeeDetailRow(
                        title: '${tramitesDisponiblesList![index].nombre}',
                        statusValue: "",
                      ),
                      SizedBox(
                        height: kDefaultPadding,
                        child: Divider(
                          thickness: 1.0,
                        ),
                      ),

                      Text(
                          '${tramitesDisponiblesList![index].descripcion}',
                          overflow: TextOverflow.fade,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black26,

                          )
                      ),
                      sizedBox,

                    ],
                  ),

                ),
              ),



            ],
          );
        }
      )
    );
  }


  Future<void> getApiData() async{
    String url = "http://52.146.91.57:8080/api/tramites";
    var result = await http.get(Uri.parse(url));

    tramitesDisponiblesList = jsonDecode(result.body)
        .map((item) => TramitesDisponibles.fromJson(item))
        .toList()
        .cast<TramitesDisponibles>();

    setState(() {
    });
  }

}
