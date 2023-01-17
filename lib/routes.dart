import 'package:brain_school/screens/%20FinalizarSolicitudScreen/FinalizarSolicitudScreen.dart';
import 'package:brain_school/screens/login_screen/login_screen.dart';
import 'package:brain_school/screens/splash_screen/splash_screen.dart';
import 'package:brain_school/screens/tramites_disponibles_screen/SeleccionarTramiteDisponibleScreen.dart';
import 'package:brain_school/screens/tramites_disponibles_screen/TramitesDisponiblesScreen.dart';
import 'package:brain_school/screens/updocument_screen/UploadFotoEstudianteScreen.dart';
import 'package:brain_school/screens/updocument_screen/UploadVideoEstudianteScreen.dart';
import 'package:brain_school/screens/updocument_screen/updocument_screen.dart';
import 'package:brain_school/screens/updocument_screen/UploadCredencialScreen.dart';
import 'package:flutter/cupertino.dart';
import 'screens/assignment_screen/assignment_screen.dart';
import 'screens/datesheet_screen/datesheet_screen.dart';
import 'screens/formalities_screen/formalities_screen.dart';
import 'screens/home_screen/home_screen.dart';
import 'screens/my_profile/my_profile.dart';

Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  LoginScreen.routeName: (context) => LoginScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  MyProfileScreen.routeName: (context) => MyProfileScreen(),
  FormalScreen.routeName: (context) => FormalScreen(),
  AssignmentScreen.routeName: (context) => AssignmentScreen(),
  DateSheetScreen.routeName: (context) => DateSheetScreen(),
  DocumentScreen.routeName: (context) => DocumentScreen(),
  UploadCredencialScreen.routeName: (context) => UploadCredencialScreen(),
  UploadFotoEstudianteScreen.routeName: (context) => UploadFotoEstudianteScreen(),
  UploadVideoEstudianteScreen.routeName: (context) => UploadVideoEstudianteScreen(),
  TramitesDisponiblesScreen.routeName: (context) => TramitesDisponiblesScreen(),
  SeleccionarTramiteDisponibleScreen.routeName: (context) => SeleccionarTramiteDisponibleScreen(),
  FinalizarSolicitudScreen.routeName: (context) => FinalizarSolicitudScreen()
};


