 // Importez la page d'accueil de l'admin
import 'package:application_gestion_des_reclamations_pfe/Application%20admin/navigatorBarAdmi.dart';
import 'package:application_gestion_des_reclamations_pfe/Application%20commune/Welcome.dart';
import 'package:application_gestion_des_reclamations_pfe/Application%20enseignant/Forgot_password_old.dart';// Importez la page de récupération du mot de passe
import 'package:application_gestion_des_reclamations_pfe/Application%20enseignant/Home_enseignant.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignInEnseignant extends StatefulWidget {
  const SignInEnseignant({Key? key}) : super(key: key);

  @override
  _SignInEnseignantState createState() => _SignInEnseignantState();
}

class _SignInEnseignantState extends State<SignInEnseignant> {
  TextEditingController emailAddress = TextEditingController();
  TextEditingController password = TextEditingController();

  final _formSignInKey = GlobalKey<FormState>();
  bool rememberPassword = true;

  Future<void> _signIn(BuildContext context) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAddress.text,
        password: password.text,
      );

      // Récupérer l'utilisateur actuellement connecté
      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Si l'utilisateur est un admin
        if (user.email == 'adminappreclamation@gmail.com' && password.text == 'fst2024') {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NavigatorBarAdmin()));
        } else {
          // Si l'utilisateur est un enseignant
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeEnseignant()));
        }
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'An error occurred';
      if (e.code == 'user-not-found') {
        errorMessage = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Wrong password provided for that user.';
      }
      // Afficher une boîte de dialogue avec le message d'erreur
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 87, 118, 184),
      body: Column(
        children: [
          SizedBox(height: 38),
          Row(
            children: [
              SizedBox(width: 10),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WelcomeScreen()),
                  );
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
          Container(
            height: 80,
            width: double.infinity,
            child: Center(
              child: Text(
                'Welcome back',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.w900,
                  color: Color.fromARGB(255, 214, 228, 255),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 9,
            child: Container(
              padding: EdgeInsets.fromLTRB(25.0, 0.0, 25.0, 0.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  topRight: Radius.circular(40.0),
                ),
              ),
              child: SingleChildScrollView(
                child: Form(
                  key: _formSignInKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 1, left: 40),
                        child: Image.asset(
                          "images/login.png",
                          height: 260,
                        ),
                      ),
                      SizedBox(height: 30.0),
                      TextFormField(
                        controller: emailAddress,
                        onChanged: (value) {},
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Email';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          label: Text(
                            'Email',
                            style: TextStyle(color: Color.fromARGB(255, 9, 61, 156)),
                          ),
                          hintText: 'Enter Email',
                          hintStyle: TextStyle(color: Color.fromARGB(66, 0, 8, 53)),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Color.fromARGB(31, 2, 19, 56)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color.fromARGB(31, 1, 4, 51)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(height: 25.0),
                      TextFormField(
                        controller: password,
                        onChanged: (value) {},
                        obscureText: true,
                        obscuringCharacter: '*',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Password';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          label: Text(
                            'Password',
                            style: TextStyle(color: Color.fromARGB(255, 9, 61, 156)),
                          ),
                          hintText: 'Enter Password',
                          hintStyle: TextStyle(color: Color.fromARGB(31, 2, 19, 56)),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Color.fromARGB(31, 1, 4, 51)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black12),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => ForgotPasswordOld()),
                              );
                            },
                            child: Text(
                              'Forget password?',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 115, 124, 163),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 25.0),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            await _signIn(context);
                          },
                          child: Text('Sign In'),
                        ),
                      ),
                      SizedBox(height: 25.0),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
