// ignore_for_file: camel_case_types, prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names

import 'package:application_gestion_des_reclamations_pfe/Models/cas_utilisation.dart';
import 'package:flutter/material.dart';

class fonction_card extends StatelessWidget {
  const fonction_card({
    Key? key,
    required this.itemIndex,
    required this.cas_utili,
    required this.press,
  }) : super(key: key);

  final int itemIndex;
  final Cas_Utilisation cas_utili;
  final Function press;
  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.amber,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      height: 190,
      child: InkWell(
        onTap: press(),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              height: 166,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                  color: const Color.fromARGB(255, 255, 255, 255),
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 15),
                        blurRadius: 25,
                        color: Colors.black54)
                  ]),
            ),
            Positioned(
                top: 0,
                left: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  height: 160,
                  width: 200,
                  child: Image.asset(
                    cas_utili.image,
                    fit: BoxFit.cover,
                  ),
                )),
            Positioned(
                bottom: 0,
                right: 0,
                child: SizedBox(
                  height: 136,
                  width: 160,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          cas_utili.title,
                          style: TextStyle(
                              fontFamily: AutofillHints.countryName,
                              fontSize: 20),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          cas_utili.subTitle,
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
