

// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, camel_case_types

import 'package:flutter/material.dart';

class Etudiant_details extends StatelessWidget {
  const Etudiant_details({super.key});

  @override
  Widget build(BuildContext context) {
    //double width = MediaQuery.of(context).size.width;
    //double height = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [
              Color.fromRGBO(4, 9, 35, 1),
              Color.fromRGBO(97, 129, 161, 1),
            ],
            begin: FractionalOffset.bottomCenter,
            end: FractionalOffset.topCenter,
          )),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 73),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          )),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.verified_user_outlined,
                            color: Colors.white,
                          )),
                    ],
                  ),

                  Text(
                    'Iman Abarkane',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontFamily: 'Nisebuschgardens',
                    ),
                  ),
                  // Green container widget here
                  SizedBox(
                    height: 28,
                  ),

                  //container qui contient les informations de l'etudiant
                  Container(
                    height: 450,
                    width: 900,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Les informations ',
                            style: TextStyle(
                              color: Color.fromRGBO(4, 9, 35, 1),
                              fontSize: 27,
                              fontFamily: 'Nunito',
                            ),
                          ),
                          Divider(
                            thickness: 2.5,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 60,
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 20,
                                ),
                                Icon(Icons.badge_outlined)
                              ],
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 20,
                                ),
                                Icon(Icons.home)
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 20,
                                ),
                                Icon(Icons.article_outlined)
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 20,
                                ),
                                Icon(Icons.email_outlined)
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                            onPressed: () {},
                            style: ButtonStyle(
                              minimumSize:
                                  MaterialStateProperty.all(Size(50, 50)),
                            ),
                            child: Text(
                              "Refuser",
                              style: TextStyle(
                                fontSize: 20,
                                color: Color.fromRGBO(4, 9, 35, 1),
                              ),
                            )),
                        ElevatedButton(
                            onPressed: () {},
                            style: ButtonStyle(
                              minimumSize:
                                  MaterialStateProperty.all(Size(50, 50)),
                            ),
                            child: Text(
                              "Accepter",
                              style: TextStyle(
                                  color: Color.fromRGBO(4, 9, 35, 1),
                                  fontSize: 20),
                            )),
                      ])
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
