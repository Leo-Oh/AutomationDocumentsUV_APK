import 'dart:async';
import 'dart:io';

import 'package:brain_school/screens/tramites_disponibles_screen/SeleccionarTramiteDisponibleScreen.dart';
import 'package:edge_detection/edge_detection.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:brain_school/constants.dart';
import 'package:sizer/sizer.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';

import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:flutter/services.dart' show rootBundle;


import 'package:flutter/cupertino.dart';
import 'package:video_player/video_player.dart';

import '../formalities_screen/formalities_screen.dart';


class UploadVideoEstudianteScreen extends StatefulWidget {
  static String routeName = 'UploadVideoEstudianteScreen';


  @override
  _UploadVideoEstudianteScreenState createState() => _UploadVideoEstudianteScreenState();
}

class _UploadVideoEstudianteScreenState extends State<UploadVideoEstudianteScreen> {


  @override
  void initState() {
    super.initState();
  }

  String? _videoPath;


  Future<void> _nextScreen(context) async {
    //Navigator.pushNamed(context, FormalScreen.routeName);
    showDialog(
        context:  context,
        builder: (context) {
          return Center(child: CircularProgressIndicator());
        }
    );

    final List<String?> rutas= ModalRoute.of(context)!.settings.arguments as List<String?>;

    print("========== RUTAS $rutas ===============");

    try {
      String filename_credecial = rutas[1]!.split('/').last;
      String filename_foto = rutas[2]!.split('/').last;
      String filename_video = _videoPath!.split('/').last;

      var data = FormData.fromMap({
        'file_photo': await MultipartFile.fromFile(rutas[1]!,filename: filename_foto),
        'file_credential': await MultipartFile.fromFile(rutas[2]!,filename: filename_credecial),
        'file_video': await MultipartFile.fromFile(_videoPath!,filename: filename_video)
      });

      FormData formData = new FormData.fromMap({
        'file_photo': await MultipartFile.fromFile(rutas[1]!),
        'file_credential': await MultipartFile.fromFile(rutas[2]!),
        'file_video': await MultipartFile.fromFile(_videoPath!)
      });

      final String endPoint = 'http://52.146.91.57:8080/api/files/verificacion-tramites/subir';

      Dio dio = new Dio();
      dio.options.headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      };

      await dio.post(endPoint,
          data: formData
      ).then((value) {
        var jsonResponse = jsonDecode(value.toString());
        print("***** RESULTADO DE LOS 3 ARCHIVOS ******* $jsonResponse");

        if(jsonResponse["detection"] == "Promedio de deteccion: 1.0"){
          Navigator.pop(this.context);

          List<String?> list_index = [rutas[0]];


          Navigator.pushNamedAndRemoveUntil(
            context,
            arguments: list_index,
            SeleccionarTramiteDisponibleScreen.routeName,
                (route) => false,
          );
        }else{
          Navigator.pop(this.context);
          Alert(
            context: context,
            type: AlertType.warning,
            title: "Algo anda mal...",
            desc: "No fue posible realizar la autenficiación, si el problema persiste acuda a control escolar.",
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



        }
      );
    } catch (e) {
      Navigator.pop(this.context);
      print(e.toString());
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
  }

  final ImagePicker _picker = ImagePicker();
  VideoPlayerController? _controller;
  bool isCaptured=false;

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
                        Text('Video de su rostro', style: Theme.of(context).textTheme.subtitle1),
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


                    IconButton(
                      onPressed: () async{
                        final XFile? file = await _picker.pickVideo(
                            source: ImageSource.camera,
                            maxDuration: const Duration(seconds: 10));
                        setState(() {
                          isCaptured=true;
                        });
                        _playVideo(file);
                        _videoPath = file!.path;

                        //print("Video Path ${file!.path}");
                      },
                      icon: Icon(Icons.video_call_rounded,color: Colors.blue,size:50),
                    ),
                    Text("Capturar Video",style: TextStyle(color: Colors.black),),


                    (isCaptured)? ElevatedButton.icon(
                      onPressed: (){
                        _nextScreen(context);
                        //Navigator.pop(context);
                      },
                      icon: Icon(Icons.send_rounded),
                      label: Text('Siguiente'),
                    ):SizedBox.shrink(),


                    Visibility(
                      visible:  _videoPath == null,
                      child:
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:
                          Image.asset("assets/images/preview_video.gif"),
                        ),
                      ),


                    Visibility(
                      visible:  _videoPath != null,
                      child:
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:
                        Container(
                            height: 500,
                            child: _previewVideo()
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

  Widget _previewVideo() {

    if (_controller == null) {
      return const
      Text('Previsualización:', textAlign: TextAlign.center,
        style: TextStyle(color: Color(0xff7CD2FF),
        ),);
    }
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: AspectRatioVideo(_controller),
    );
  }


  Future<void> _playVideo(XFile? file) async {
    if (file != null && mounted) {
      print("Loading Video");
      await _disposeVideoController();
      late VideoPlayerController controller;
      controller = VideoPlayerController.file(File(file.path));
      _controller = controller;
      await controller.initialize();
      await controller.setLooping(true);
      await controller.play();
      setState(() {});
    } else {
      print("Loading Video error");
    }
  }
  Future<void> _disposeVideoController() async {
    if (_controller != null) {
      await _controller!.dispose();
    }
    _controller = null;
  }
}


class AspectRatioVideo extends StatefulWidget {
  AspectRatioVideo(this.controller);

  final VideoPlayerController? controller;

  @override
  AspectRatioVideoState createState() => AspectRatioVideoState();
}

class AspectRatioVideoState extends State<AspectRatioVideo> {
  VideoPlayerController? get controller => widget.controller;
  bool initialized = false;

  void _onVideoControllerUpdate() {
    if (!mounted) {
      return;
    }
    if (initialized != controller!.value.isInitialized) {
      initialized = controller!.value.isInitialized;
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    controller!.addListener(_onVideoControllerUpdate);
  }

  @override
  void dispose() {
    controller!.removeListener(_onVideoControllerUpdate);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (initialized) {
      return Center(
        child: AspectRatio(

          aspectRatio: controller!.value.aspectRatio,
          child: VideoPlayer(controller!),
        ),
      );
    } else {
      return Container();
    }
  }
}
