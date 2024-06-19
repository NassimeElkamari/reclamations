// Importations de packages nécessaires
// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:application_gestion_des_reclamations_pfe/Application%20commune/Welcome.dart';
import 'package:application_gestion_des_reclamations_pfe/Application%20enseignant/Forgot_password_old.dart';
import 'package:application_gestion_des_reclamations_pfe/Application%20etudiant/Forgot_password.dart';
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
  String? _selectedFiliere;
  //liste des fillieres
  List<String> _filieres = [
    'Sciences Mathématiques Appliquées (SMA)',
    'Sciences Mathématiques Informatiques (SMI)',
    'Sciences de la Matière Physique (SMP)',
    'Sciences de la Matière Chimie (SMC)',
    'Sciences de la Vie (SVI)',
    "Sciences de la Terre et de l'Univers (STU)",
  ];
  // Contrôleurs pour les champs de saisie
  TextEditingController nomEntre = TextEditingController();
  TextEditingController prenomEntre = TextEditingController();
  TextEditingController appogeEntre = TextEditingController();
  TextEditingController emailEntre = TextEditingController();
  TextEditingController passwordEntre = TextEditingController();

  // Méthode pour enregistrer l'apogée dans SharedPreferences
  Future<void> _saveApoge(String apoge) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('apogeConnecte', apoge);
  }

  // Méthode pour l'inscription de l'utilisateur
  Future<void> signUp() async {
    // Vérifier si les champs obligatoires sont remplis
    if (appogeEntre.text.isNotEmpty &&
        emailEntre.text.isNotEmpty &&
        passwordEntre.text.isNotEmpty) {
      try {
        // Vérifier si l'apogée de l'étudiant existe dans la bAAase de données
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('etudiants')
            .where('appoge', isEqualTo: appogeEntre.text)
            .get();

        // Si l'apogée existe, créer le compte de l'utilisateur
        if (querySnapshot.docs.isNotEmpty) {
          final credential =
              await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailEntre.text,
            password: passwordEntre.text,
          );

          // Enregistrer les informations de l'utilisateur dans Firestore
          await FirebaseFirestore.instance.collection('etudiantsActives').add({
            'nom': nomEntre.text,
            'prenom': prenomEntre.text,
            'apoge': appogeEntre.text,
            'email': emailEntre.text,
            'sexe': "  ",
            'filiere': _selectedFiliere,
            'password': passwordEntre.text
          });

          // Enregistrer l'apogée dans SharedPreferences
          await _saveApoge(appogeEntre.text);

          // Rediriger vers l'interface ProfileEtudiant
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => NavigatorBarEtudiant()),
          );

          // Afficher un message de confirmation
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Compte activé avec succès!'),
          ));
        } else {
          // Afficher un message d'erreur si l'apogée n'est pas trouvée
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content:
                Text('Apogée non trouvé. Veuillez vérifier vos informations.'),
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

  String? apogeConnecte;
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
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold,color:  Color.fromARGB(255, 33, 55, 128),)),
                ),
                Container(height: 10),
                // Description de la page
                Center(
                  child: const Text("SignUp To Continue Using The App",
                      style: TextStyle(color:  Color.fromARGB(255, 141, 149, 179),)),
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
                    mycontroller: nomEntre,
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
                    mycontroller: prenomEntre,
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
                    mycontroller: appogeEntre,
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
                    mycontroller: emailEntre,
                    obscureText: false),
                Container(height: 8),
                Text(
                  "Filière ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Container(height: 8),
                Container(
                  height: 50, // Hauteur du champ de sélection
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50), // Bord arrondi
                    border: Border.all(), // Bordure avec style par défaut
                     color:  Color.fromARGB(255, 223, 230, 252), // Couleur de fond grise
                  ),
                  child: DropdownButtonFormField<String>(
                    value: _selectedFiliere,
                    items: _filieres.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(
                            fontSize: 12, // Taille de la police réduite
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        _selectedFiliere = newValue;
                      });
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 10,
                      ), // Padding pour le contenu
                      border: InputBorder
                          .none, // Supprimer la bordure de DropdownButtonFormField
                    ),
                  ),
                ),

                Container(height: 8),
                const Text(
                  "Email",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),

                Container(height: 8),
                CustomTextForm(
                    hinttext: "Enter Your Password",
                    mycontroller: passwordEntre,
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
                SizedBox(height: 20,),
                
              ],
            ),
            // Bouton d'inscription
            CustomButtonAuth(
              title: "SignUp",
              onPressed: signUp,
            ),
            SizedBox(height: 20,),
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
