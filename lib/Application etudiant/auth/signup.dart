// Importations de packages nécessaires
// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:application_gestion_des_reclamations_pfe/Application%20commune/Welcome.dart';
import 'package:application_gestion_des_reclamations_pfe/Application%20enseignant/Forgot_password_old.dart';
import 'package:application_gestion_des_reclamations_pfe/Application%20etudiant/Home_Screens/ButtomnavigatorBar.dart';
import 'package:application_gestion_des_reclamations_pfe/Application%20etudiant/Home_Screens/Home_etudiant.dart';
import 'package:application_gestion_des_reclamations_pfe/Application%20etudiant/Home_Screens/profile_etudiant.dart';
import 'package:application_gestion_des_reclamations_pfe/Application%20etudiant/auth/login.dart';
import 'package:application_gestion_des_reclamations_pfe/Application%20etudiant/components/custombuttonauth.dart';
import 'package:application_gestion_des_reclamations_pfe/Application%20etudiant/components/textformfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';



 

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  // Contrôleurs pour les champs de saisie
  TextEditingController nom = TextEditingController();
  TextEditingController prenom = TextEditingController();
  TextEditingController appoge = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  // Méthode pour enregistrer l'apogée dans SharedPreferences
  Future<void> _saveApoge(String apoge) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('apogeConnecte', apoge);
  }

  // Méthode pour l'inscription de l'utilisateur
  Future<void> signUp() async {
    // Vérifier si les champs obligatoires sont remplis
    if (appoge.text.isNotEmpty &&
        email.text.isNotEmpty &&
        password.text.isNotEmpty) {
      try {
        // Vérifier si l'apogée de l'étudiant existe dans la base de données
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('etudiants')
            .where('appoge', isEqualTo: appoge.text)
            .get();

        // Si l'apogée existe, créer le compte de l'utilisateur
        if (querySnapshot.docs.isNotEmpty) {
          final credential =
              await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: email.text,
            password: password.text,
          );

          // Enregistrer les informations de l'utilisateur dans Firestore
          await FirebaseFirestore.instance.collection('etudiantsActives').add({
            'nom': nom.text,
            'prenom': prenom.text,
            'apoge': appoge.text,
            'email': email.text,
            'sexe': " ",
            'filiere': " "
          });

          // Enregistrer l'apogée dans SharedPreferences
          await _saveApoge(appoge.text);

          // Rediriger vers l'interface ProfileEtudiant
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => ProfileEtudiant()),
          );

          // Afficher un message de confirmation
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Compte activé avec succès!'),
          ));
        } else {
          // Afficher un message d'erreur si l'apogée n'est pas trouvée
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Apogée non trouvé. Veuillez vérifier vos informations.'),
          ));
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
        }
      } catch (e) {
        print(e);
      }
    } else {
      // Afficher un message si les champs obligatoires ne sont pas remplis
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Veuillez remplir les champs obligatoires'),
      ));
    }
  }
   String? apogeConnecte ;
  @override
  Widget build(BuildContext context) {
    // Interface utilisateur de l'écran d'inscription
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Bouton de retour
                Row(
                  children: [
                    SizedBox(
                      width: 10,
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
                        color: Color.fromARGB(179, 45, 11, 90),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                // Titre de la page
                Center(
                  child: const Text("SignUp",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                ),
                Container(height: 10),
                // Description de la page
                Center(
                  child: const Text("SignUp To Continue Using The App",
                      style: TextStyle(color: Colors.grey)),
                ),
                Container(height: 20),
                // Champ pour le nom
                const Text(
                  "Nom ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Container(height: 8),
                CustomTextForm(
                    hinttext: "Enter votre nom",
                    mycontroller: nom,
                    obscureText: false),
                Container(height: 20),
                // Champ pour le prénom
                const Text(
                  "Prenom ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Container(height: 8),
                CustomTextForm(
                    hinttext: "Enter votre prenom",
                    mycontroller: prenom,
                    obscureText: false),
                Container(height: 20),
                // Champ pour l'apogée
                const Text(
                  "Appoge ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Container(height: 8),
                CustomTextForm(
                    hinttext: "Enter votre Appoge",
                    mycontroller: appoge,
                    obscureText: false),
                Container(height: 20),
                // Champ pour l'email
                const Text(
                  "Email",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Container(height: 8),
                CustomTextForm(
                    hinttext: "Enter Your Email",
                    mycontroller: email,
                    obscureText: false),
                Container(height: 8),
                // Champ pour le mot de passe
                const Text(
                  "Password",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Container(height: 8),
                CustomTextForm(
                    hinttext: "Enter Your Password",
                    mycontroller: password,
                    obscureText: false),
                Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 20),
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ForgotPasswordOld()));
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
            // Bouton d'inscription
            CustomButtonAuth(
              title: "SignUp",
              onPressed: signUp,
            ),
            // Texte pour se connecter
            InkWell(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Login()));
              },
              child: const Center(
                child: Text.rich(TextSpan(children: [
                  TextSpan(
                    text: "Have An Account ? ",
                  ),
                  TextSpan(
                      text: "Login",
                      style: TextStyle(
                          color: Color.fromARGB(255, 25, 5, 80),
                          fontWeight: FontWeight.bold)),
                ])),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ErrorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Erreur'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error,
              size: 80,
              color: Colors.red,
            ),
            SizedBox(height: 20),
            Text(
              'Aucun étudiant trouvé avec ce numéro d\'apogée.',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Retourner à l'écran précédent
              },
              child: Text('Retour'),
            ),
          ],
        ),
      ),
    );
  }
}
