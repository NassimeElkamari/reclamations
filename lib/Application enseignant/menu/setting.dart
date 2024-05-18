import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Setting extends StatelessWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: const ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late String _nom = '';
  late String _address = '';
  late String _email = '';
  late String _phone = '';
  late String _department = '';
  late String _profileImageUrl =
      ''; // Nouvelle variable pour l'URL de la photo de profil

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    // Récupérer l'utilisateur actuellement connecté
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // Récupérer l'e-mail de l'utilisateur connecté
      String email = user.email!;
      print("Email utilisateur: $email"); // Débogage

      // Récupérer les informations de l'utilisateur à partir de Firestore
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('enseignants')
          .doc(email)
          .get();

      // Vérifier si le document existe
      if (snapshot.exists) {
        // Récupérer les données du document
        setState(() {
          _nom = snapshot.data()?['nom'] ?? '';
          _address = snapshot.data()?['adresse'] ?? '';
          _email = snapshot.data()?['email'] ?? '';
          _phone = snapshot.data()?['phone'] ?? '';
          _department = snapshot.data()?['department'] ?? '';
          _profileImageUrl = snapshot.data()?['profile'] ??
              ''; // Récupérer l'URL de la photo de profil
          print(
              "Données récupérées: $_nom, $_address, $_email, $_phone, $_department, $_profileImageUrl"); // Débogage
        });
      } else {
        print("Le document n'existe pas."); // Débogage
      }
    } else {
      print("Aucun utilisateur connecté."); // Débogage
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color.fromARGB(255, 114, 117, 122),
            Color.fromARGB(255, 172, 164, 172),
          ]),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 40),
              CircleAvatar(
                radius: 70,
                backgroundImage: _profileImageUrl.isNotEmpty
                    ? NetworkImage(
                        _profileImageUrl) // Utiliser l'URL de la photo de profil
                    : AssetImage('assets/images/user.JPG')
                        as ImageProvider, // Image par défaut
              ),
              const SizedBox(height: 20),
              itemProfile('Nom', _nom, CupertinoIcons.person),
              const SizedBox(height: 10),
              itemProfile('Adresse', _address, CupertinoIcons.location),
              const SizedBox(height: 10),
              itemProfile('Email', _email, CupertinoIcons.mail),
              const SizedBox(height: 10),
              itemProfile('Téléphone', _phone, CupertinoIcons.phone),
              const SizedBox(height: 10),
              itemProfile('Département', _department, CupertinoIcons.briefcase),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        "SignInEnseignant", (route) => false);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(15),
                  ),
                  child: const Text('Déconnexion'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget itemProfile(String title, String subtitle, IconData iconData) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 5),
            color: Colors.deepOrange.withOpacity(.2),
            spreadRadius: 2,
            blurRadius: 10,
          )
        ],
      ),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        leading: Icon(iconData),
        trailing: const Icon(Icons.arrow_forward, color: Colors.grey),
        tileColor: Colors.white,
      ),
    );
  }
}
