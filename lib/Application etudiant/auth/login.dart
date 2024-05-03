// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:application_gestion_des_reclamations_pfe/Application%20commune/Welcome.dart';
import 'package:application_gestion_des_reclamations_pfe/Application%20etudiant/Forgot_password.dart';
import 'package:application_gestion_des_reclamations_pfe/Application%20etudiant/Home_Screens/Home_etudiant.dart';
import 'package:application_gestion_des_reclamations_pfe/Application%20etudiant/auth/signup.dart';
import 'package:application_gestion_des_reclamations_pfe/Application%20etudiant/components/custombuttonauth.dart';
import 'package:application_gestion_des_reclamations_pfe/Application%20etudiant/components/textformfield.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

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
              const Text(
                "Email",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Container(height: 10),
              CustomTextForm(
                  hinttext: "ُEnter Your Email",
                  mycontroller: email,
                  obscureText: false),
              Container(height: 10),
              const Text(
                "Password",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Container(height: 10),
              CustomTextForm(
                  hinttext: "ُEnter Your Password",
                  mycontroller: password,
                  obscureText: true),
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
              if (email.text.isNotEmpty && password.text.isNotEmpty) {
                try {
                  final credential =
                      await FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: email.text,
                    password: password.text,
                  );
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomeEtudiant()),
                  );
                } on FirebaseAuthException catch (e) {
                  String errorMessage = 'An error occurred';
                  if (e.code == 'user-not-found') {
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.error,
                      animType: AnimType.rightSlide,
                      title: 'Error',
                      desc: 'No user found for that email.',
                      btnCancelOnPress: () {},
                      btnOkOnPress: () {},
                    ).show();
                  } else if (e.code == 'wrong-password') {
                    errorMessage = 'Wrong password provided for that user.';
                  }
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.error,
                    animType: AnimType.rightSlide,
                    title: 'Error',
                    desc: errorMessage,
                    btnCancelOnPress: () {},
                    btnOkOnPress: () {},
                  ).show();
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Veuillez remplir tous les champs'),
                ));
              }
            },
          ),
          Container(height: 20),
          Container(height: 20),
          // Text("Don't Have An Account ? Resister" , textAlign: TextAlign.center,)
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
