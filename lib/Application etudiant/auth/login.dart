// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:application_gestion_des_reclamations_pfe/Application%20commune/Welcome.dart';
import 'package:application_gestion_des_reclamations_pfe/Application%20etudiant/Forgot_password.dart';
import 'package:application_gestion_des_reclamations_pfe/Application%20etudiant/Home_Screens/ButtomnavigatorBar.dart';
import 'package:application_gestion_des_reclamations_pfe/Application%20etudiant/auth/signup.dart';
import 'package:application_gestion_des_reclamations_pfe/Application%20etudiant/components/custombuttonauth.dart';
import 'package:application_gestion_des_reclamations_pfe/Application%20etudiant/components/textformfield.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserInfo {
  static String? emailconnecte;
}

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  late bool isLoggedIn;

  @override
  void initState() {
    super.initState();
    isLoggedIn = FirebaseAuth.instance.currentUser != null;

    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      setState(() {
        isLoggedIn = user != null;
        print(isLoggedIn ? 'User is currently signed in!' : 'User is currently signed out!');
      });
    });
  }

  Future<void> _signIn(BuildContext context) async {
    try {
      final etudiantQuery = await FirebaseFirestore.instance
          .collection('etudiantsActives')
          .where('email', isEqualTo: email.text)
          .where('password', isEqualTo: password.text)
          .get();
        
      if (etudiantQuery.docs.isNotEmpty) {
        final etudiant = etudiantQuery.docs.first;
        final nom = etudiant['nom'];
        final prenom = etudiant['prenom'];
        
        UserInfo.emailconnecte = email.text; // Mise à jour de la variable emailconnecte

        print('****************************************************************************************************************************User $prenom $nom is currently signed in!');
        
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => NavigatorBarEtudiant()),
        );
      } else {
        // Aucun utilisateur trouvé dans la collection
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.rightSlide,
          title: 'Erreur',
          desc:
              'Aucun utilisateur trouvé pour cet email ou mot de passe incorrect.',
          btnCancelOnPress: () {},
          btnOkOnPress: () {},
        ).show();
      }
    } catch (e) {
      print('Error: $e');
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        title: 'Erreur',
        desc: 'Une erreur est survenue. Veuillez réessayer.',
        btnCancelOnPress: () {},
        btnOkOnPress: () {},
      ).show();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: ListView(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 0,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 5,
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WelcomeScreen()));
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: Color.fromARGB(179, 57, 33, 88),
                      )),
                ],
              ),
              Center(
                child: Container(
                    alignment: Alignment.center,
                    width: 300,
                    height: 210,
                    padding: const EdgeInsets.only(top: 0),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(70)),
                    child: Image.asset(
                      "images/login.png",
                      height: 230,
                      fit: BoxFit.fill,
                    )),
              ),
              Container(height: 20),
              const Text("Login",
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
              Container(height: 10),
              const Text("Login To Continue Using The App",
                  style: TextStyle(color: Color.fromARGB(255, 44, 36, 68))),
              Container(height: 20),
              Text(
                "Email",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Container(height: 10),
              CustomTextForm(
                  hinttext: "Enter Your Email",
                  mycontroller: email,
                  obscureText: false),
              Container(height: 10),
              const Text(
                "Password",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Container(height: 10),
              CustomTextForm(
                hinttext: "Enter Your Password",
                mycontroller: password,
                obscureText: true,
                obscuringCharacter: '*',
              ),
              Container(
                margin: const EdgeInsets.only(top: 10, bottom: 20),
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ForgotPasswordEtudiant()));
                  },
                  child: const Text(
                    "Forgot Password ?",
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          ),
          CustomButtonAuth(
            title: "login",
            onPressed: () async {
              await _signIn(context); // Appeler la fonction correctement
            },
          ),
          Container(height: 20),
          InkWell(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => SignUp()));
            },
            child: const Center(
              child: Text.rich(TextSpan(children: [
                TextSpan(
                  text: "Don't Have An Account ? ",
                ),
                TextSpan(
                    text: "Signup",
                    style: TextStyle(
                        color: Color.fromARGB(255, 166, 134, 243),
                        fontWeight: FontWeight.bold)),
              ])),
            ),
          )
        ]),
      ),
    );
  }
}
