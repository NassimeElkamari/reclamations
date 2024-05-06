// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:application_gestion_des_reclamations_pfe/Application%20admin/home/1.ensignants/ajouter_enseignant.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ListeDesEnseignants extends StatefulWidget {
  const ListeDesEnseignants({Key? key}) : super(key: key);

  @override
  State<ListeDesEnseignants> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ListeDesEnseignants> {
  List<QueryDocumentSnapshot> data = [];
  List<QueryDocumentSnapshot> filteredData = [];

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    filteredData = data;
    super.initState();
    getData();
  }

  getData() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("enseignants").get();
    setState(() {
      data = querySnapshot.docs.toList();
      filteredData =
          data; // Initialisez également filteredData avec la liste complète au début
    });
  }

  void chercher(String enteredKeyWord) {
    List<QueryDocumentSnapshot> resultat = [];
    if (enteredKeyWord.isEmpty) {
      resultat = data;
    } else {
      resultat = data
          .where((enseignant) => enseignant["nom"]
              .toLowerCase()
              .contains(enteredKeyWord.toLowerCase()))
          .toList();
    }
    setState(() {
      filteredData = resultat;
    });
  }

  //fonction de supprimer un enseignant
  void supprimerEnseignant(int index) {
    setState(() {
      filteredData.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: UniqueKey(),
      appBar: AppBar(
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(3),
            bottomRight: Radius.circular(3),
          ),
        ),
        title: Center(
          child: Text(
            "Enseignants",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: Color.fromARGB(255, 50, 93, 150),
        actions: [
          IconButton(
            icon: Icon(Icons.person_add),
            color: Colors.white,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AjouterEnseignant()));
            },
          ),
        ],
      ),
      backgroundColor: Colors.transparent,
      body: Container(
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
        child: Column(
          children: [
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                height: 40,
                margin:
                    EdgeInsets.only(top: 10, left: 16, right: 16, bottom: 10),
                child: TextFormField(
                  controller: _searchController,
                  onChanged: (value) => chercher(value),
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.search, color: Colors.white),
                    labelText: 'Rechercher un enseignant',
                    labelStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredData.length,
                itemBuilder: (context, i) {
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage:
                            NetworkImage(filteredData[i]['profile']),
                      ),
                      title: Text(
                          '${filteredData[i]['nom']} ${filteredData[i]['prenom']}'),
                      onLongPress: () {
                        // Action à effectuer lorsque l'utilisateur appuie sur le ListTile
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Confirmation'),
                              content:
                                  Text('Do you want to delete this teacher?'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    supprimerEnseignant(i);
                                    // Supprimer l'enseignant de la base de données
                                    FirebaseFirestore.instance
                                        .collection('enseignants')
                                        .doc(filteredData[i].id)
                                        .delete();
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Delete'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
