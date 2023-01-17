import 'dart:async';
import 'dart:io';
import 'package:edge_detection/edge_detection.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:brain_school/constants.dart';
import 'package:sizer/sizer.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'UploadFotoEstudianteScreen.dart';


class UploadCredencialScreen extends StatefulWidget {
  static String routeName = 'UploadCredencialScreen';

  @override
  _UploadCredencialScreenState createState() => _UploadCredencialScreenState();
}

class _UploadCredencialScreenState extends State<UploadCredencialScreen> {
  String? _imagePath;

  @override
  void initState() {
    super.initState();
  }



  void _upload(context) async {
    final String id_estudiante= ModalRoute.of(context)!.settings.arguments as String;

    showDialog(
      context:  context,
      builder: (context) {
        return Center(child: CircularProgressIndicator());
      }
      );

    final String endPoint = 'http://52.146.91.57:8080/api/files/verificacion-tramites/subir/verificar-credencial-uv';

    String? fileName = _imagePath?.split('/').last;


    var data = FormData.fromMap({
      'file_credential': await MultipartFile.fromFile(_imagePath!,filename: fileName)
    });


    Dio dio = new Dio();

    dio.options.headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };

    dio.post(endPoint, data: data).then((response) {
      var jsonResponse = jsonDecode(response.toString());

      print(jsonResponse["message"]);


      if(jsonResponse["message"]){
        Navigator.pop(this.context);

        List<String?> rutas = [id_estudiante,_imagePath];


        Navigator.pushNamedAndRemoveUntil(
          context,
          arguments: rutas,
          UploadFotoEstudianteScreen.routeName,
          (route) => false,
        );

      }else{
        Navigator.pop(this.context);
        Alert(
          context: context,
          type: AlertType.warning,
          title: "Algo anda mal...",
          desc: "Vaya, parece que no es una credencial escolar valida. Porfavor intente de nuevo.",
          buttons: [
            DialogButton(
              child: Text(
                "ACEPTAR",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () => Navigator.pop(this.context),
              color: Colors.blueAccent,
              width: 120,
            )
          ],
        ).show();

      }

    }).catchError((error){
      print(error);
      Navigator.pop(this.context);
      Alert(
        context: context,
        type: AlertType.error,
        title: "Ocurrio un error",
        desc: "Porfavor intente de nuevo o acuda a control escolar.",
        buttons: [
          DialogButton(
            child: Text(
              "ACEPTAR",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(this.context),
            color: Colors.blueAccent,
            width: 120,
          )
        ],
      ).show();
    }
    );


  }


  Future<void> getImage() async {
    bool isCameraGranted = await Permission.camera.request().isGranted;
    if (!isCameraGranted) {
      isCameraGranted = await Permission.camera.request() == PermissionStatus.granted;
    }

    if (!isCameraGranted) {
      // Have not permission to camera
      return;
    }

// Generate filepath for saving
    String imagePath = join((await getApplicationSupportDirectory()).path,
        "Automation_Documents_${(DateTime.now().millisecondsSinceEpoch / 1000).round()}.jpeg");

    try {
      //Make sure to await the call to detectEdge.
      bool success = await EdgeDetection.detectEdge(imagePath,
        canUseGallery: true,
        androidScanTitle: 'Captura de credencial escolar', // use custom localizations for android
        androidCropTitle: 'Recortar',
        androidCropBlackWhiteTitle: 'Blanco y negro',
        androidCropReset: 'Restaurar',
      );
    } catch (e) {
      print(e);
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _imagePath = imagePath;
    });


  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
        children: [
          Container(
            width: 100.w,
            height: 15.h,
            padding: EdgeInsets.all(kDefaultPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Credencial Escolar', style: Theme.of(context).textTheme.subtitle1),
                      ],
                    ),

                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              width: 100.w,
              decoration: BoxDecoration(
                color: kOtherColor,
                borderRadius: kTopBorderRadius,
              ),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Column(
                        children: [
                          ElevatedButton.icon(
                        onPressed: getImage,
                        icon: Icon(Icons.document_scanner),
                        label: Text('Escanear'),
                      ),
                      ],
                      ),
                    ),
                    Visibility(
                      visible:  _imagePath != null,
                      child:
                      ElevatedButton.icon(
                        onPressed: (){
                          _upload(context);

                        },
                        icon: Icon(Icons.near_me_rounded),
                        label: Text('Siguiente'),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text('Previsualización:',
                      style: TextStyle(color: Color(0xff7CD2FF),
                    ),),
                    Padding(
                      padding: const EdgeInsets.only(top: 0, left: 0, right: 0),
                      child: Text(
                        _imagePath.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 14,color: Colors.white12),

                      ),
                    ),
                    Visibility(
                      visible:  _imagePath != null,
                      child:
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.file(
                          File(_imagePath ?? ''),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

}



