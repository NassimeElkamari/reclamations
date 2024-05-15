<<<<<<< HEAD
import 'package:application_gestion_des_reclamations_pfe/Application%20admin/home/etudiant_details.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ListeDesEtudiants extends StatefulWidget {
  const ListeDesEtudiants({Key? key}) : super(key: key);
=======
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:application_gestion_des_reclamations_pfe/Application%20admin/home/2.etuduiant/ajouter.dart';
import 'package:application_gestion_des_reclamations_pfe/Application%20admin/home/2.etuduiant/supprimier.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Liste_des_etudiants extends StatefulWidget {
  const Liste_des_etudiants({super.key});
>>>>>>> 27af836529cf33bdf5ce1b43ab77bb2fa601447a

  @override
  State<ListeDesEtudiants> createState() => _ListeDesEtudiantsState();
}

class _ListeDesEtudiantsState extends State<ListeDesEtudiants> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
<<<<<<< HEAD
        title: Center(
          child: Text(
            "Liste des Étudiants",
            style: TextStyle(
              fontSize: 24,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: Color.fromARGB(255, 28, 51, 128),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                suffixIcon: Icon(Icons.search),
                labelText: 'Rechercher un étudiant',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onChanged: (value) {
                setState(() {}); // Rafraîchir l'affichage lors de la saisie
              },
            ),
=======
        title: Text(
          "          Etudiants",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 50, 93, 150),
        actions: [
          IconButton(
            icon: Icon(Icons.person_remove),
            color: Colors.white,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SuppEtudiant()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.person_add),
            color: Colors.white,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AjouterEtudiant()),
              );
            },
>>>>>>> 27af836529cf33bdf5ce1b43ab77bb2fa601447a
          ),
          SizedBox(height: 20),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("etudiantsActives")
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Une erreur est survenue');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                final List<QueryDocumentSnapshot> documents =
                    snapshot.data!.docs;
                final filteredData = _searchController.text.isEmpty
                    ? documents
                    : documents.where((doc) {
                        final String searchTerm =
                            _searchController.text.toLowerCase();
                        final String nom = doc['nom'].toString().toLowerCase();
                        final String prenom =
                            doc['prenom'].toString().toLowerCase();
                        final String apoge =
                            doc['apoge'].toString().toLowerCase();

                        return nom.startsWith(searchTerm) ||
                            prenom.startsWith(searchTerm) ||
                            apoge.startsWith(searchTerm);
                      }).toList();

                return ListView.builder(
                  itemCount: filteredData.length,
                  itemBuilder: (context, index) {
                    final DocumentSnapshot document = filteredData[index];
                    final nom = document['nom'];
                    final prenom = document['prenom'] ?? '';
                    final apoge = document['apoge'];

                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Color.fromARGB(255, 13, 41, 133), width: 2),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(255, 210, 225, 255)
                                .withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: ListTile(
                        title: Text(
                          '$nom $prenom',
                          style: TextStyle(
                            color: Color.fromARGB(255, 13, 41, 133),
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          'Apoge: $apoge',
                          style: TextStyle(
                            color: Color.fromARGB(255, 13, 41, 133),
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DetailsEtudiant(documentId: document.id),
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
<<<<<<< HEAD
=======
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('etudiants').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Erreur de chargement des données'),
            );
          }

          if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text('Aucun étudiant trouvé'),
            );
          }

          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(255, 10, 30, 97),
                  Color.fromARGB(255, 101, 162, 243),
                ],
              ),
            ),
            child: ListView(
              children: snapshot.data!.docs.map((etudiant) {
                String appoge = etudiant['appoge'];
                String nom = etudiant['nom'];
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 7, horizontal: 18),
                  child: Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: ListTile(
                      title: Text(
                        appoge,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      subtitle: Text(
                        nom,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      trailing: GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Modifier '),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextField(
                                      decoration: InputDecoration(
                                        labelText: 'Nouveau numéro d\'appoge',
                                      ),
                                      onChanged: (value) {
                                        appoge = value;
                                      },
                                    ),
                                    TextField(
                                      decoration: InputDecoration(
                                        labelText: 'Nouveau nom',
                                      ),
                                      onChanged: (value) {
                                        nom = value;
                                      },
                                    ),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Annuler'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      // Mettre à jour les informations dans la base de données
                                      FirebaseFirestore.instance
                                          .collection('etudiants')
                                          .doc(etudiant.id)
                                          .update({
                                        'appoge': appoge,
                                        'nom': nom,
                                      });
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Enregistrer'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Icon(Icons.edit),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          );
        },
      ),
>>>>>>> 27af836529cf33bdf5ce1b43ab77bb2fa601447a
    );
  }
}
