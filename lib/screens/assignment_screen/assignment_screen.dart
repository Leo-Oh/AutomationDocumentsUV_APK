import 'package:brain_school/constants.dart';
import 'package:brain_school/screens/assignment_screen/data/assignment_data.dart';
import 'package:brain_school/screens/datesheet_screen/datesheet_screen.dart';
import 'package:brain_school/screens/formalities_screen/formalities_screen.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../tramites_disponibles_screen/TramitesDisponiblesScreen.dart';
import '../updocument_screen/updocument_screen.dart';
import 'widgets/assignment_widgets.dart';

class AssignmentScreen extends StatelessWidget {
  const AssignmentScreen({Key? key}) : super(key: key);
  static String routeName = 'AssignmentScreen';




  @override
  Widget build(BuildContext context) {

    final String id_estudiante= ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: Text('Tramites'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: kOtherColor,
                borderRadius: kTopBorderRadius,
              ),
              child:  Container(
                      margin: EdgeInsets.only(bottom: kDefaultPadding),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [


                          Container(
                            padding: EdgeInsets.all(kDefaultPadding),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(kDefaultPadding),
                              color: kOtherColor,
                              boxShadow: [
                                BoxShadow(
                                  color: kTextLightColor,
                                  blurRadius: 2.0,
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                kHalfSizedBox,
                                Text(
                                    "Tramites Disponibles",
                                  style: Theme.of(context).textTheme.subtitle2!.copyWith(
                                    color: kTextBlackColor,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                  AssignmentButton(
                                    onPress: () {
                                      Navigator.pushNamed(context, TramitesDisponiblesScreen.routeName);
                                    },
                                    title: '➔',
                                  ),
                              ],
                            ),
                          ),

                          kHalfSizedBox,

                          Container(
                            padding: EdgeInsets.all(kDefaultPadding),
                            decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.circular(kDefaultPadding),
                              color: kOtherColor,
                              boxShadow: [
                                BoxShadow(
                                  color: kTextLightColor,
                                  blurRadius: 2.0,
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                kHalfSizedBox,
                                Text(
                                  "Solicitar un tramite",
                                  style: Theme.of(context).textTheme.subtitle2!.copyWith(
                                    color: kTextBlackColor,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                AssignmentButton(
                                  onPress: () {
                                    Navigator.pushNamedAndRemoveUntil(
                                      context,
                                      arguments: id_estudiante.toString(),
                                      DocumentScreen.routeName,
                                          (route) => false,
                                    );


                                  },
                                  title: '➔',
                                ),
                              ],
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
