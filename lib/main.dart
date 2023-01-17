import 'package:brain_school/routes.dart';
import 'package:brain_school/screens/splash_screen/splash_screen.dart';
import 'package:brain_school/theme.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
   

    return Sizer(builder: (context, orientation, device){
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Automation Documents',
        theme: CustomTheme().baseTheme,
        

        initialRoute: SplashScreen.routeName,

        routes: routes,
      );
    });
  }
}
