import 'dart:convert';
import 'dart:developer';

import 'package:brain_school/constants.dart';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../Services/ServiceAPI.dart';
import '../../models/Estudiante.dart';
import '../../models/Facultad.dart';

import 'package:http/http.dart' as http;

class MyProfileScreen extends StatelessWidget {
  const MyProfileScreen({Key? key}) : super(key: key);
  static String routeName = 'MyProfileScreen';

  @override
  Widget build(BuildContext context) {
    final EstudianteInfo estudiante= ModalRoute.of(context)!.settings.arguments as EstudianteInfo;

    return Scaffold(
      appBar: AppBar(
        title: Text('Mi perfil'),
        actions: [
          InkWell(
            onTap: () {
            },
            child: Container(
              padding: EdgeInsets.only(right: kDefaultPadding / 2),
              child: Row(
                children: [
                  
                ],
              ),
            ),
          ),
        ],
      ),
      body: Container(
        color: kOtherColor,
        child: Column(
          children: [
            Container(
              width: 100.w,
              height: SizerUtil.deviceType == DeviceType.tablet ? 19.h : 15.h,
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: kBottomBorderRadius,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius:
                        SizerUtil.deviceType == DeviceType.tablet ? 12.w : 13.w,
                    backgroundColor: kSecondaryColor,
                    backgroundImage:
                        AssetImage('assets/images/ashFotos.png'),
                  ),
                  kWidthSizedBox,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Container(
                        height: 120,
                        width: 250,
                        child: FittedBox(
                          child: Column(
                            children: [
                              Text(
                                estudiante.nombre_completo, textAlign:  TextAlign.center,
                                style: TextStyle(color: Colors.white),
                              ),
                            Text(
                              estudiante.correo, textAlign:  TextAlign.center,
                              style: TextStyle(color: Colors.white60),
                            ),

                          ],
                        ),
                      ),
                      ),
                    ],
                  )
                ],
              ),
            ),
         
            sizedBox,
            ProfileDetailColumn(
              title: 'Nombre completo',
              value: estudiante.nombre_completo,
            ),
            ProfileDetailColumn(
              title: 'Correo',
              value: estudiante.correo,
            ),
            ProfileDetailColumn(
              title: 'Matricula',
              value: estudiante.matricula,
            ),
            ProfileDetailColumn(
              title: 'Semestre',
              value: estudiante.semestre,
            ),
            ProfileDetailColumn(
              title: 'Numero de telefono',
              value: estudiante.telefono,
            ),

            ProfileDetailColumn(
              title: 'Numero de telefono',
              value: estudiante.telefono,
            ),

          ],
        ),
      ),
    );
  }


}



class ProfileDetailRow extends StatelessWidget {
  const ProfileDetailRow({Key? key, required this.title, required this.value})
      : super(key: key);
  final String title;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      color: kTextBlackColor,
                      fontSize: SizerUtil.deviceType == DeviceType.tablet
                          ? 7.sp
                          : 9.sp,
                    ),
              ),
              kHalfSizedBox,
              Text(value, style: Theme.of(context).textTheme.caption),
              kHalfSizedBox,
              SizedBox(
                width: 35.w,
                child: Divider(
                  thickness: 1.0,
                ),
              ),
            ],
          ),
          Icon(
            Icons.lock_outline,
            size: 10.sp,
          ),
        ],
      ),
    );
  }
}

class ProfileDetailColumn extends StatelessWidget {
  const ProfileDetailColumn(
      {Key? key, required this.title, required this.value})
      : super(key: key);
  final String title;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      color: kTextBlackColor,
                      fontSize: SizerUtil.deviceType == DeviceType.tablet
                          ? 7.sp
                          : 11.sp,
                    ),
              ),
              kHalfSizedBox,
              Text(value, style: Theme.of(context).textTheme.caption),
              kHalfSizedBox,
              SizedBox(
                width: 92.w,
                child: Divider(
                  thickness: 1.0,
                ),
              )
            ],
          ),
          Icon(
            Icons.lock_outline,
            size: 10.sp,
          ),
        ],
      ),
    );
  }
}









