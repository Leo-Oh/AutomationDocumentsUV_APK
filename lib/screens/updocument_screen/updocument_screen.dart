import 'package:brain_school/constants.dart';
import 'package:brain_school/screens/assignment_screen/assignment_screen.dart';
import 'package:brain_school/screens/datesheet_screen/datesheet_screen.dart';
import 'package:brain_school/screens/formalities_screen/formalities_screen.dart';
import 'package:brain_school/screens/my_profile/my_profile.dart';
import 'package:brain_school/screens/updocument_screen/UploadCredencialScreen.dart';
import 'widgets/updocument_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import 'package:rflutter_alert/rflutter_alert.dart';
import 'data/updocument_data.dart';
import 'widgets/updocument_widgets.dart';

class DocumentScreen extends StatelessWidget {
  const DocumentScreen({Key? key}) : super(key: key);
  static String routeName = 'DocumentScreen';


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
        children: [
          Container(
            width: 100.w,
            height: 40.h,
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
                        StudentName(
                          studentName: 'Validación',
                        ),
                        kHalfSizedBox,
                        StudentClass(studentClass: ''
                            'Para poder solicitar un tramite \n'
                            'es necesario comprobar la autenticidad \n'
                            'del estudiante'),
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
                  children: [
                   
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        HomeCard(
                          onPress: () {
                            showAlert(context);
                          },
                          icon: 'assets/icons/result.svg',
                          title: 'Comenzar solicitud',
                        ),
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


class HomeCard extends StatelessWidget {
  const HomeCard(
      {Key? key,
      required this.onPress,
      required this.icon,
      required this.title})
      : super(key: key);
  final VoidCallback onPress;
  final String icon;
  final String title;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        margin: EdgeInsets.only(top: 1.h),
        width: 40.w,
        height: 20.h,
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.circular(kDefaultPadding / 2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              icon,
              height: SizerUtil.deviceType == DeviceType.tablet ? 30.sp : 40.sp,
              width: SizerUtil.deviceType == DeviceType.tablet ? 30.sp : 40.sp,
              color: kOtherColor,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.subtitle2,
            ),
          ],
        ),
      ),
    );
  }
}

showAlert(context){
  final String id_estudiante= ModalRoute.of(context)!.settings.arguments as String;
  Alert(
    context: context,
    type: AlertType.info,
    title: "Para la solicitud de un tramite es necesario:",
    desc: "\n1.-Credencial Escolar\n2.-Fotografia del estudiante\n3.-Video del rostro del estudiante (recomendable 10s)",
    buttons: [
      DialogButton(
        child: Text(
          "ACEPTAR",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () =>

        Navigator.pushNamedAndRemoveUntil(
        context,
  arguments: id_estudiante.toString(),
  UploadCredencialScreen.routeName,
  (route) => false,
  )
           ,
        color: Colors.blueAccent,
        width: 120,
      )
    ],
  ).show();
}