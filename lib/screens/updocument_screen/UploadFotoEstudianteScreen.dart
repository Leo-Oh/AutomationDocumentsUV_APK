import 'dart:async';
import 'dart:io';

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

import 'UploadVideoEstudianteScreen.dart';


class UploadFotoEstudianteScreen extends StatefulWidget {
  static String routeName = 'UploadFotoEstudianteScreen';


  @override
  _UploadFotoEstudianteScreenState createState() => _UploadFotoEstudianteScreenState();
}

class _UploadFotoEstudianteScreenState extends State<UploadFotoEstudianteScreen> {


  @override
  void initState() {
    super.initState();
  }

  File? _image;


  Future getImage(ImageSource source) async {
    try{
      final image = await ImagePicker().pickImage(source: source);
      if(image == null ) return;

      //final imageTemporary = File(image.path);
      final imagePermanent = await saveFilePermanently(image.path);


      setState(() {
        this._image = imagePermanent;


      });
    }on PlatformException catch (e){
      print("Falló al obtener recursos de las imagenes: $e");
    }
  }




  Future<File> saveFilePermanently(String imagePath) async{
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(imagePath);
    final image = File('${directory.path}/${name}');


    return File(imagePath).copy(image.path);
  }


  showAlertDialog(title,desciption,duration) {
    showDialog(
      context:  this.context,
      builder: (context) {
        Future.delayed(
          Duration(seconds: duration),
              () {
            Navigator.of(context).pop(true);
          },
        );

        return AlertDialog(
          title: Text(title),
          content: Text(desciption),
        );
      },
    );
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
                        Text('Fotografia de su rostro', style: Theme.of(context).textTheme.subtitle1),
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


                    Column(
                      children: [
                        SizedBox(height: 50,),
                        Column(
                          children: <Widget>[

                            ElevatedButton.icon(
                              onPressed: (){
                                getImage(ImageSource.camera);
                              },
                              icon: Icon(Icons.camera_alt_rounded),
                              label: Text('Tomar fotografía'),
                            ),

                            Visibility(
                              visible:  _image != null,
                              child:
                              ElevatedButton.icon(
                                onPressed: (){
                                  final List<String?> rutas= ModalRoute.of(context)!.settings.arguments as List<String?>;
                                  rutas.add(_image?.path);

                                  Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    arguments: rutas,
                                    UploadVideoEstudianteScreen.routeName,
                                        (route) => false,
                                  );


                                  },
                                icon: Icon(Icons.near_me_rounded),
                                label: Text('Siguiente'),
                              ),
                            ),



                          ],
                        ),
                        SizedBox(height: 60,),
                        _image != null ? Image.file(_image!, width: 300, height: 400, fit: BoxFit.cover,) :
                        Image.asset("assets/images/user.png"),
                        SizedBox(height: 20,),
                      ],
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