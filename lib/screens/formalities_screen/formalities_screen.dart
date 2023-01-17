import 'package:brain_school/constants.dart';
import 'package:flutter/material.dart';
import 'package:brain_school/screens/updocument_screen/updocument_screen.dart';

import 'data/formalities_data.dart';
import 'widgets/formalities_widgets.dart';

class FormalScreen extends StatelessWidget {
  const FormalScreen({Key? key}) : super(key: key);
  static String routeName = 'FormalScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nuevo Tramite'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: kTopBorderRadius,
                color: kOtherColor,
              ),
              child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.all(kDefaultPadding),
                  itemCount: forma.length,
                  itemBuilder: (context, int index) {
                    return Container(
                      margin: EdgeInsets.only(bottom: kDefaultPadding),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(kDefaultPadding),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(kDefaultPadding),
                              ),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: kTextLightColor,
                                  blurRadius: 2.0,
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                FeeDetailRow(
                                  title: 'Tipo de Tramite',
                                  statusValue: forma[index].receiptNo,
                                ),
                                SizedBox(
                                  height: kDefaultPadding,
                                  child: Divider(
                                    thickness: 1.0,
                                  ),
                                ),
                                FeeDetailRow(
                                  title: 'Matricula',
                                  statusValue: forma[index].month,
                                ),
                                sizedBox,
                                FeeDetailRow(
                                  title: 'Nombre',
                                  statusValue: forma[index].date,
                                ),
                                sizedBox,
                                FeeDetailRow(
                                  title: 'Apellidos',
                                  statusValue: forma[index].paymentStatus,
                                ),
                                sizedBox,
                                SizedBox(
                                  height: kDefaultPadding,
                                ),
                                FeeDetailRow(
                                  title: 'Carrera',
                                  statusValue: forma[index].totalAmount,
                                ),
                              ],
                            ),
                          ),
                          FeeButton(
                              title: forma[index].btnStatus,
                              iconData: forma[index].btnStatus == 'Paid'
                                  ? Icons.download_outlined
                                  : Icons.arrow_forward_outlined,
                              onPress: () {
                                Navigator.pushNamed(context, DocumentScreen.routeName);
                              })
                        ],
                      ),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
