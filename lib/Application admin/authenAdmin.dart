// ignore_for_file: prefer_const_constructors, use_build_context_synchronously


import 'package:application_gestion_des_reclamations_pfe/Application%20admin/navigatorBarAdmi.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpAdmin extends StatefulWidget {
  const SignUpAdmin({Key? key}) : super(key: key);

  @override
  _SignUpAdminState createState() => _SignUpAdminState();
}

class _SignUpAdminState extends State<SignUpAdmin> {
  TextEditingController emailController = TextEditingController();
  TextEditingController displayNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> signUpAdmin() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // Ajouter l'admin à la collection 'admin' dans Firestore
      await FirebaseFirestore.instance.collection('admin').doc(userCredential.user!.uid).set({
        'email': emailController.text,
        'displayName': displayNameController.text,
      });
        Navigator.push(context,
                    MaterialPageRoute(builder: (context) => NavigatorBarAdmin()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Le mot de passe est trop faible.'),
        ));
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Ce compte existe déjà pour cet email.'),
        ));
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SignUp Admin'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: displayNameController,
              decoration: InputDecoration(labelText: 'Nom d\'affichage'),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Mot de passe'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: signUpAdmin,
              child: Text('S\'inscrire'),
            ),
          ],
        ),
      ),
    );
  }
}
