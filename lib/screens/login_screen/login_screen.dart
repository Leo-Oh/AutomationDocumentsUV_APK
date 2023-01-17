import 'dart:convert';
import 'dart:developer';

import 'package:brain_school/components/custom_buttons.dart';
import 'package:brain_school/constants.dart';
import 'package:brain_school/models/Estudiante.dart';
import 'package:brain_school/screens/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:sizer/sizer.dart';
import 'package:brain_school/Services/ServiceAPI.dart';

late bool _passwordVisible;

class LoginScreen extends StatefulWidget {
  static String routeName = 'LoginScreen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  String txt_matricula = "";
  get get_txt_matricula => txt_matricula;

  set set_txt_matricula(String txt_matricula) {
    this.txt_matricula = txt_matricula;
  }

  String txt_contrasena = "";
  get get_txt_contrasena => txt_contrasena;

  set set_txt_contrasena(String txt_contrasena) {
    this.txt_contrasena = txt_contrasena;
  }

  @override
  void initState() {
    super.initState();
    _passwordVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: Column(
          children: [
            Container(
              width: 100.w,
              height: 35.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Tramites UV',
                          style: Theme.of(context).textTheme.subtitle1),
                      Text('Inicia Sesion para continuar',
                          style: Theme.of(context).textTheme.subtitle2),
                      sizedBox,
                    ],
                  ),
                  Image.asset(
                    'assets/images/logouv.png',
                    height: 20.h,
                    width: 40.w,
                  ),
                  SizedBox(
                    height: kDefaultPadding / 2,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 5.w, right: 5.w),
                decoration: BoxDecoration(
                  color: kOtherColor,
                  borderRadius: kTopBorderRadius,
                ),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        sizedBox,
                        buildEmailField(),
                        sizedBox,
                        buildPasswordField(),
                        sizedBox,
                        DefaultButton(
                          onPress: () async {
                            if (_formKey.currentState!.validate()) {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Center(
                                        child: CircularProgressIndicator());
                                  });

                              var request_post =
                                  await request_POST("estudiante/ingresar", {
                                "matricula": get_txt_matricula,
                                "contrasena": get_txt_contrasena,
                              });

                              if (request_post.statusCode == 200) {
                                Navigator.pop(this.context);

                                final json_response =
                                    jsonDecode(request_post.body);
                                Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  arguments: EstudianteInfo(
                                      json_response['user']['id'].toString(),
                                      json_response['user']['id_carreras']
                                          .toString(),
                                      json_response['user']['id_facultades']
                                          .toString(),
                                      json_response['user']['nombre_completo']
                                          .toString(),
                                      json_response['user']['matricula']
                                          .toString(),
                                      json_response['user']['correo']
                                          .toString(),
                                      json_response['user']['contrasena']
                                          .toString(),
                                      json_response['user']['semestre']
                                          .toString(),
                                      json_response['user']['telefono']
                                          .toString(),
                                      json_response['user']['foto_perfil']
                                          .toString()),
                                  HomeScreen.routeName,
                                  (route) => false,
                                );
                              }

                              if (request_post.statusCode == 401) {
                                Navigator.pop(this.context);
                                Alert(
                                  context: context,
                                  type: AlertType.warning,
                                  title: "¡Credenciales no validas!",
                                  desc:
                                      "Pruebe intentando de nuevo, si el problema persiste comuniquese con control escolar.",
                                  buttons: [
                                    DialogButton(
                                      child: Text(
                                        "ACEPTAR",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                      onPressed: () =>
                                          Navigator.pop(this.context),
                                      color: Colors.blueAccent,
                                      width: 120,
                                    )
                                  ],
                                ).show();
                              }

                              if (request_post.statusCode == 500) {
                                Navigator.pop(this.context);
                                Alert(
                                  context: context,
                                  type: AlertType.error,
                                  title: "¡Ocurrió un error!",
                                  desc:
                                      "Pruebe intentando de nuevo, si el problema persiste comuniquese con control escolar.",
                                  buttons: [
                                    DialogButton(
                                      child: Text(
                                        "ACEPTAR",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                      onPressed: () =>
                                          Navigator.pop(this.context),
                                      color: Colors.blueAccent,
                                      width: 120,
                                    )
                                  ],
                                ).show();
                              }


                            }
                          },
                          title: 'Ingresar',
                          iconData: Icons.arrow_forward_outlined,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextFormField buildEmailField() {
    return TextFormField(
      textAlign: TextAlign.start,
      keyboardType: TextInputType.emailAddress,
      style: kInputTextStyle,
      decoration: InputDecoration(
        hintText: 'Ej; zS12345678',
        labelText: 'Matrícula',
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      validator: (value) {
        RegExp regExp = new RegExp(emailPattern);
        if (value == null || value.isEmpty) {
          return 'Porfavor ingrese su matrícula.';
        } else if (!regExp.hasMatch(value)) {
          return 'Ingrese una matrícula valida.';
        } else {
          txt_matricula = value.toString();
        }
      },
    );
  }

  TextFormField buildPasswordField() {
    return TextFormField(
      obscureText: _passwordVisible,
      textAlign: TextAlign.start,
      keyboardType: TextInputType.visiblePassword,
      style: kInputTextStyle,
      decoration: InputDecoration(
        labelText: 'Contraseña',
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              _passwordVisible = !_passwordVisible;
            });
          },
          icon: Icon(
            _passwordVisible
                ? Icons.visibility_off_outlined
                : Icons.visibility_off_outlined,
          ),
          iconSize: kDefaultPadding,
        ),
      ),
      validator: (value) {
        if (value!.length < 4) {
          return 'Ingrese una contraseña valida';
        } else {
          txt_contrasena = value.toString();
        }
      },
    );
  }
}
