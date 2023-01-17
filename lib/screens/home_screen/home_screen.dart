
import 'package:brain_school/constants.dart';
import 'package:brain_school/models/Estudiante.dart';
import 'package:brain_school/screens/assignment_screen/assignment_screen.dart';
import 'package:brain_school/screens/datesheet_screen/datesheet_screen.dart';
import 'package:brain_school/screens/formalities_screen/formalities_screen.dart';
import 'package:brain_school/screens/my_profile/my_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import 'widgets/student_data.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static String routeName = 'HomeScreen';


  @override
  Widget build(BuildContext context ) {
    final EstudianteInfo estudiante= ModalRoute.of(context)!.settings.arguments as EstudianteInfo;


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
                        kHalfSizedBox,
                        StudentPicture(
                            picAddress: 'assets/images/ashFotos.png',
                            onPress: () {
                              Navigator.pushNamed(
                                  context, MyProfileScreen.routeName,
                                  arguments: estudiante
                              );
                            }
                            ),
                        StudentName(
                          studentName: estudiante.nombre_completo.toString(),
                        ),
                        kHalfSizedBox,
                        StudentClass(studentClass: estudiante.matricula.toString()),
                        kHalfSizedBox,
                        StudentYear(studentYear: 'Semestre: ${estudiante.semestre}'),
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
                            Navigator.pushNamed(
                                context, DateSheetScreen.routeName,
                                arguments: estudiante
                            );
                          },
                          icon: 'assets/icons/datesheet.svg',
                          title: 'Historial',
                        ),
                        HomeCard(
                          onPress: () {
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              arguments: estudiante.id.toString(),
                              AssignmentScreen.routeName,
                                  (route) => false,
                            );

                          },
                          icon: 'assets/icons/assignment.svg',
                          title: 'Tramites',
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        HomeCard(
                          onPress: () {},
                          icon: 'assets/icons/logout.svg',
                          title: 'Cerrar Sesión',
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
